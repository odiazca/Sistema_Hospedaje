<?php

namespace App\Services\Ia;

use App\Models\Configuracion;
use App\Models\IaConfig;
use App\Models\User;
use Carbon\Carbon;
use Illuminate\Http\Client\ConnectionException;
use Illuminate\Support\Facades\Crypt;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Http;
use InvalidArgumentException;
use PDO;
use PDOException;
use RuntimeException;
use Throwable;

/**
 * Asistente de reportes con IA + Chat IA · Hospedaje Pro (multi-empresa)
 *
 * Seguridad:
 *  - La IA NUNCA toca las tablas reales: solo ve las vistas de lectura v_ia_*.
 *  - Cada v_ia_* se materializa en cada consulta como un CTE filtrado por la empresa del usuario
 *    (WITH v_ia_reservas AS (SELECT ... FROM vb_ia_reservas WHERE empresa_id = N)), por lo que es
 *    imposible ver datos de otro hotel.
 *  - El SQL generado se valida (solo SELECT), se ejecuta en una transacción de solo lectura,
 *    con límite de tiempo y de filas.
 */
class IaService
{
    public const MAX_FILAS = 500;

    private int $empresaId;
    private string $moneda;
    private string $hotel;
    private static array $colCache = [];
    private static ?array $reales = null;

    public function __construct(private User $user)
    {
        $this->empresaId = (int) $user->empresa_id;
        abort_if($this->empresaId === 0, 403, 'Tu usuario no pertenece a una empresa.');
        $cfg = Configuracion::withoutGlobalScopes()->where('empresa_id', $this->empresaId)
            ->whereIn('clave', ['simbolo_moneda', 'nombre_hotel'])->pluck('valor', 'clave');
        $this->moneda = trim((string) ($cfg['simbolo_moneda'] ?? '')) ?: 'S/';
        $this->hotel = trim((string) ($cfg['nombre_hotel'] ?? '')) ?: ($user->empresa->nombre ?? 'el hotel');
    }

    public static function presets(): array
    {
        return config('ia.presets');
    }

    public function nombreHotel(): string
    {
        return $this->hotel;
    }

    /* =====================================================================
     *  Vistas de solo lectura (la «capa de inteligencia»)
     *  Cada vista base (vb_ia_*) lleva empresa_id como primera columna.
     * ===================================================================== */
    public static function vistas(): array
    {
        $huesped = "CONCAT(hu.nombres,' ',hu.apellidos)";

        return [
            'v_ia_reservas' => [
                "Una fila por reserva. estado: pendiente, confirmada, checkin (huésped alojado ahora), checkout (ya salió) o cancelada; las reservas válidas son estado<>'cancelada'. total_hospedaje = noches x tarifa_noche; total_consumos = extras cargados a la cuenta (minibar, restaurante...); total_cuenta = hospedaje + consumos. dias_anticipacion = días entre que se creó la reserva y el check-in.",
                "SELECT r.empresa_id, r.id AS reserva_id, r.codigo, r.fecha_checkin, r.fecha_checkout, r.noches, r.adultos, r.ninos, (r.adultos + r.ninos) AS personas, $huesped AS huesped, hu.nacionalidad, h.numero AS habitacion, th.nombre AS tipo_habitacion, h.piso, r.tarifa_noche, r.total AS total_hospedaje, COALESCE(cs.s,0) AS total_consumos, (r.total + COALESCE(cs.s,0)) AS total_cuenta, r.estado, COALESCE(u.name,'Sin usuario') AS registrado_por, r.created_at AS creada_en, DATEDIFF(r.fecha_checkin, DATE(r.created_at)) AS dias_anticipacion "
                . "FROM reservas r JOIN huespedes hu ON hu.id=r.huesped_id JOIN habitaciones h ON h.id=r.habitacion_id JOIN tipo_habitaciones th ON th.id=h.tipo_habitacion_id LEFT JOIN users u ON u.id=r.user_id "
                . "LEFT JOIN (SELECT reserva_id, SUM(subtotal) AS s FROM consumos GROUP BY reserva_id) cs ON cs.reserva_id=r.id",
            ],
            'v_ia_noches' => [
                "Una fila por cada NOCHE de cada reserva (desde fecha_checkin hasta la noche anterior al check-out). Úsala para ocupación, noches vendidas por día/mes/tipo de habitación y tarifa media. ingreso_noche = tarifa de esa noche. Filtra estado<>'cancelada'. Ocupación % = noches ocupadas / (habitaciones x días del período).",
                "SELECT r.empresa_id, DATE_ADD(r.fecha_checkin, INTERVAL n.n DAY) AS fecha, r.id AS reserva_id, r.codigo AS reserva_codigo, h.numero AS habitacion, th.nombre AS tipo_habitacion, r.tarifa_noche AS ingreso_noche, r.estado "
                . "FROM reservas r JOIN habitaciones h ON h.id=r.habitacion_id JOIN tipo_habitaciones th ON th.id=h.tipo_habitacion_id "
                . "JOIN (SELECT a.d + b.d*10 + c.d*100 AS n FROM (SELECT 0 AS d UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) a "
                . "CROSS JOIN (SELECT 0 AS d UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) b "
                . "CROSS JOIN (SELECT 0 AS d UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) c) n ON n.n < r.noches",
            ],
            'v_ia_facturas' => [
                "Una fila por factura/comprobante (una por reserva). estado: pendiente, pagada o anulada. Los ingresos cobrados son las facturas 'pagada' (SUM(total) por fecha). total_pagado = abonos registrados; saldo_pendiente > 0 en facturas 'pendiente' = dinero por cobrar. tipo_comprobante: boleta, factura o nota_credito. sunat_estado: no_emitido, pendiente, enviado, aceptado, observado, rechazado o anulado. metodo_pago: efectivo, tarjeta, yape o transferencia.",
                "SELECT f.empresa_id, f.id AS factura_id, f.numero, f.tipo_comprobante, CONCAT(COALESCE(f.serie,''),'-',COALESCE(f.correlativo,'')) AS comprobante, f.fecha, f.subtotal, f.igv, f.total, f.estado, f.metodo_pago, f.sunat_estado, $huesped AS huesped, hu.documento_numero AS documento, h.numero AS habitacion, r.codigo AS reserva_codigo, COALESCE(pg.pagado,0) AS total_pagado, (CASE WHEN f.estado='pendiente' THEN GREATEST(f.total - COALESCE(pg.pagado,0),0) ELSE 0 END) AS saldo_pendiente "
                . "FROM facturas f JOIN reservas r ON r.id=f.reserva_id JOIN huespedes hu ON hu.id=r.huesped_id JOIN habitaciones h ON h.id=r.habitacion_id "
                . "LEFT JOIN (SELECT factura_id, SUM(monto) AS pagado FROM pagos GROUP BY factura_id) pg ON pg.factura_id=f.id",
            ],
            'v_ia_pagos' => [
                "Cobros (abonos) registrados contra facturas, con el método de pago, el cajero y la caja. Úsala para ingresos por método de pago, por cajero o por día de cobro. metodo_pago: efectivo, tarjeta, yape o transferencia.",
                "SELECT pg.empresa_id, pg.id AS pago_id, pg.fecha, pg.monto, pg.metodo_pago, f.numero AS factura, $huesped AS huesped, COALESCE(u.name,'Sin usuario') AS cajero, pg.caja_sesion_id AS caja_id, pg.nota "
                . "FROM pagos pg JOIN facturas f ON f.id=pg.factura_id LEFT JOIN reservas r ON r.id=f.reserva_id LEFT JOIN huespedes hu ON hu.id=r.huesped_id LEFT JOIN users u ON u.id=pg.user_id",
            ],
            'v_ia_consumos' => [
                "Consumos extra cargados a las reservas (minibar, restaurante, lavandería, servicios...). importe = ingreso de la línea. categoria: minibar, restaurante, lavanderia, servicios u otros. Filtra estado_reserva<>'cancelada' para consumos válidos.",
                "SELECT c.empresa_id, c.id AS consumo_id, c.fecha, c.descripcion, COALESCE(p.nombre, c.descripcion) AS producto, COALESCE(p.categoria,'otros') AS categoria, c.cantidad, c.precio_unit AS precio_unitario, c.subtotal AS importe, r.codigo AS reserva_codigo, $huesped AS huesped, h.numero AS habitacion, r.estado AS estado_reserva, COALESCE(u.name,'Sin usuario') AS registrado_por "
                . "FROM consumos c JOIN reservas r ON r.id=c.reserva_id JOIN huespedes hu ON hu.id=r.huesped_id JOIN habitaciones h ON h.id=r.habitacion_id LEFT JOIN productos p ON p.id=c.producto_id LEFT JOIN users u ON u.id=c.user_id",
            ],
            'v_ia_habitaciones' => [
                "Inventario de habitaciones con su estado actual y su historial. estado: disponible, ocupada, mantenimiento o limpieza. Total de habitaciones = COUNT(*) de esta vista. noches_vendidas e ingreso_hospedaje cuentan reservas no canceladas.",
                "SELECT h.empresa_id, h.id AS habitacion_id, h.numero, th.nombre AS tipo_habitacion, h.piso, h.capacidad, h.precio_noche, h.estado, COALESCE(x.n_res,0) AS num_reservas, COALESCE(x.noches,0) AS noches_vendidas, COALESCE(x.ingreso,0) AS ingreso_hospedaje "
                . "FROM habitaciones h JOIN tipo_habitaciones th ON th.id=h.tipo_habitacion_id "
                . "LEFT JOIN (SELECT habitacion_id, COUNT(*) AS n_res, SUM(noches) AS noches, SUM(total) AS ingreso FROM reservas WHERE estado<>'cancelada' GROUP BY habitacion_id) x ON x.habitacion_id=h.id",
            ],
            'v_ia_huespedes' => [
                "Huéspedes con su historial (solo reservas no canceladas). tipo_documento: DNI, CE, Pasaporte o RUC (en mayúsculas/capitalizado). total_gastado = suma de hospedaje de sus reservas. Úsala para huéspedes frecuentes, nacionalidades y clientes que más gastan.",
                "SELECT hu.empresa_id, hu.id AS huesped_id, $huesped AS nombre, hu.documento_tipo AS tipo_documento, hu.documento_numero AS numero_documento, hu.nacionalidad, hu.telefono, hu.email, hu.created_at AS creado_en, COALESCE(x.n_res,0) AS num_reservas, COALESCE(x.noches,0) AS noches_totales, COALESCE(x.gasto,0) AS total_gastado, x.ultima AS ultima_estadia "
                . "FROM huespedes hu LEFT JOIN (SELECT huesped_id, COUNT(*) AS n_res, SUM(noches) AS noches, SUM(total) AS gasto, MAX(fecha_checkin) AS ultima FROM reservas WHERE estado<>'cancelada' GROUP BY huesped_id) x ON x.huesped_id=hu.id",
            ],
            'v_ia_productos' => [
                "Catálogo de productos/servicios extra del hotel con sus ventas acumuladas. categoria: minibar, restaurante, lavanderia, servicios u otros. activo=1 son los vigentes.",
                "SELECT p.empresa_id, p.id AS producto_id, p.nombre AS producto, p.categoria, p.precio, p.activo, COALESCE(x.unid,0) AS unidades_vendidas, COALESCE(x.imp,0) AS importe_vendido "
                . "FROM productos p LEFT JOIN (SELECT producto_id, SUM(cantidad) AS unid, SUM(subtotal) AS imp FROM consumos GROUP BY producto_id) x ON x.producto_id=p.id",
            ],
            'v_ia_tarifas_temporada' => [
                "Tarifas de temporada (alta, baja o especial) que ajustan el precio por noche en un rango de fechas. ajuste_tipo: porcentaje o fijo. vigente_hoy=1 si hoy está dentro del rango y está activa.",
                "SELECT t.empresa_id, t.id AS tarifa_id, t.nombre, t.tipo, t.fecha_inicio, t.fecha_fin, t.ajuste_tipo, t.ajuste_valor, t.activo, (t.activo=1 AND CURDATE() BETWEEN t.fecha_inicio AND t.fecha_fin) AS vigente_hoy "
                . "FROM tarifa_temporadas t",
            ],
            'v_ia_cajas' => [
                "Sesiones de caja (apertura y cierre) por cajero. estado: abierta o cerrada. diferencia = monto_final - monto_esperado. total_cobrado = suma de cobros registrados en esa caja.",
                "SELECT cs.empresa_id, cs.id AS caja_id, cs.abierta_at AS fecha_apertura, cs.cerrada_at AS fecha_cierre, COALESCE(u.name,'Sin usuario') AS cajero, cs.monto_inicial, cs.monto_esperado, cs.monto_final, cs.diferencia, COALESCE(pg.t,0) AS total_cobrado, cs.estado "
                . "FROM caja_sesiones cs LEFT JOIN users u ON u.id=cs.user_id LEFT JOIN (SELECT caja_sesion_id, SUM(monto) AS t FROM pagos GROUP BY caja_sesion_id) pg ON pg.caja_sesion_id=cs.id",
            ],
        ];
    }

    private static function base(string $vista): string
    {
        return 'vb_' . substr($vista, 2); // v_ia_x -> vb_ia_x
    }

    /** Crea (o recrea) las vistas base si faltan. Con $force siempre las recrea. */
    public static function instalarVistas(bool $force = false): void
    {
        $vistas = self::vistas();
        if (! $force) {
            $n = DB::selectOne("SELECT COUNT(*) AS c FROM information_schema.views WHERE table_schema = DATABASE() AND table_name REGEXP '^vb_ia_'");
            if ((int) ($n->c ?? 0) === count($vistas)) {
                return;
            }
        }
        foreach ($vistas as $v => [, $sql]) {
            DB::unprepared('CREATE OR REPLACE VIEW `' . self::base($v) . '` AS ' . $sql);
        }
        self::$colCache = [];
        self::$reales = null;
    }

    public static function quitarVistas(): void
    {
        foreach (array_keys(self::vistas()) as $v) {
            DB::unprepared('DROP VIEW IF EXISTS `' . self::base($v) . '`');
        }
    }

    /** Columnas de una vista base, sin empresa_id (la IA no lo necesita). */
    private function columnas(string $base): array
    {
        if (! isset(self::$colCache[$base])) {
            self::$colCache[$base] = [];
            foreach (DB::select("SHOW COLUMNS FROM `$base`") as $c) {
                if ($c->Field !== 'empresa_id') {
                    self::$colCache[$base][$c->Field] = strtolower(preg_replace('/\(.*/', '', $c->Type));
                }
            }
        }

        return self::$colCache[$base];
    }

    public function esquemaTexto(): string
    {
        $t = '';
        foreach (self::vistas() as $v => [$desc]) {
            $cols = [];
            foreach ($this->columnas(self::base($v)) as $campo => $tipo) {
                $cols[] = "$campo $tipo";
            }
            $t .= "$v: $desc\n  columnas: " . implode(', ', $cols) . "\n";
        }

        return $t;
    }

    /** CTEs que «sustituyen» cada v_ia_* por sus filas de ESTA empresa. */
    private function ctes(): string
    {
        $p = [];
        foreach (array_keys(self::vistas()) as $v) {
            $base = self::base($v);
            $cols = implode(',', array_map(fn ($c) => "`$c`", array_keys($this->columnas($base))));
            $p[] = "$v AS (SELECT $cols FROM `$base` WHERE empresa_id = {$this->empresaId})";
        }

        return implode(', ', $p);
    }

    private function envolver(string $sql): string
    {
        if (preg_match('/^\s*with\s+/i', $sql)) {
            return preg_replace('/^\s*with\s+/i', 'WITH ' . $this->ctes() . ', ', $sql, 1);
        }

        return 'WITH ' . $this->ctes() . ' ' . $sql;
    }

    /* =====================================================================
     *  Configuración (por empresa) y clave cifrada
     * ===================================================================== */
    public function cfg(): array
    {
        $presets = self::presets();
        $row = IaConfig::where('empresa_id', $this->empresaId)->first();
        $p = $row->proveedor ?? 'gemini';
        if (! isset($presets[$p])) {
            $p = 'gemini';
        }
        $clave = '';
        if ($row && $row->clave) {
            try {
                $clave = Crypt::decryptString($row->clave);
            } catch (Throwable) {
                $clave = '';
            }
        }

        return [
            'proveedor' => $p,
            'url' => $row->url ?? $presets[$p]['url'],
            'modelo' => $row->modelo ?? $presets[$p]['modelo'],
            'clave' => $clave,
            'resumen' => $row ? (bool) $row->resumen : true,
        ];
    }

    public function listo(?array $c = null): bool
    {
        $c ??= $this->cfg();

        return $c['url'] !== '' && $c['modelo'] !== '' && (! self::presets()[$c['proveedor']]['clave'] || $c['clave'] !== '');
    }

    public function guardarConfig(string $proveedor, string $url, string $modelo, bool $resumen, string $clave): void
    {
        $datos = ['proveedor' => $proveedor, 'url' => $url, 'modelo' => $modelo, 'resumen' => $resumen];
        if ($clave === '__borrar__') {
            $datos['clave'] = null;
        } elseif ($clave !== '') {
            $datos['clave'] = Crypt::encryptString($clave);
        }
        IaConfig::updateOrCreate(['empresa_id' => $this->empresaId], $datos);
    }

    /* =====================================================================
     *  Llamada al modelo (API compatible con OpenAI)
     * ===================================================================== */
    public function llamar(array $mensajes, int $maxTokens = 900): string
    {
        $c = $this->cfg();
        if ($c['url'] === '' || $c['modelo'] === '') {
            throw new RuntimeException('Configura el proveedor de IA (URL y modelo).');
        }
        if (self::presets()[$c['proveedor']]['clave'] && $c['clave'] === '') {
            throw new RuntimeException('Falta la clave (API key) del proveedor de IA. Configúrala con el botón «Configurar IA».');
        }
        $url = rtrim($c['url'], '/') . '/chat/completions';
        if (! preg_match('#^https?://#i', $url)) {
            throw new RuntimeException('La URL del proveedor debe empezar por http:// o https://');
        }

        try {
            $req = Http::timeout(60)->connectTimeout(10)->acceptJson()->asJson();
            if ($c['clave'] !== '') {
                $req = $req->withToken($c['clave']);
            }
            $res = $req->post($url, ['model' => $c['modelo'], 'messages' => $mensajes, 'temperature' => 0, 'max_tokens' => $maxTokens]);
        } catch (ConnectionException $e) {
            throw new RuntimeException('No se pudo conectar con el proveedor de IA (' . mb_substr($e->getMessage(), 0, 140) . '). Revisa tu internet y la URL.');
        }

        $code = $res->status();
        $j = $res->json();
        if ($code === 401 || $code === 403) {
            throw new RuntimeException('El proveedor rechazó la clave (API key). Revisa que sea correcta.');
        }
        if ($code === 429) {
            throw new RuntimeException('Se alcanzó el límite del plan gratuito. Espera un minuto e inténtalo de nuevo.');
        }
        if ($code === 404) {
            throw new RuntimeException('Modelo o URL no encontrados (' . $c['modelo'] . '). Google renueva sus modelos: prueba con gemini-3.5-flash-lite o gemini-3.5-flash.');
        }
        if ($code >= 400 || ! is_array($j)) {
            $m = is_array($j) ? ($j['error']['message'] ?? ($j[0]['error']['message'] ?? '')) : '';
            throw new RuntimeException('Error del proveedor de IA (' . $code . ')' . ($m ? ': ' . mb_substr((string) $m, 0, 200) : '.'));
        }
        $txt = $j['choices'][0]['message']['content'] ?? '';
        if (is_array($txt)) {
            $txt = implode('', array_map(fn ($p) => $p['text'] ?? '', $txt));
        }
        if (trim((string) $txt) === '') {
            throw new RuntimeException('La IA no devolvió respuesta. Intenta reformular la pregunta.');
        }

        return (string) $txt;
    }

    public static function extraerJson(string $t): ?array
    {
        $t = trim($t);
        if (preg_match('/```(?:json)?\s*(.*?)```/is', $t, $m)) {
            $t = trim($m[1]);
        }
        $j = json_decode($t, true);
        if (is_array($j)) {
            return $j;
        }
        $a = strpos($t, '{');
        $b = strrpos($t, '}');
        if ($a !== false && $b > $a) {
            $j = json_decode(substr($t, $a, $b - $a + 1), true);
            if (is_array($j)) {
                return $j;
            }
        }

        return null;
    }

    /* =====================================================================
     *  Validación del SQL (defensa en profundidad)
     * ===================================================================== */
    public function validarSql(string $sql): string
    {
        $sql = rtrim(trim($sql), "; \t\r\n");
        if ($sql === '' || strlen($sql) > 4000) {
            throw new InvalidArgumentException('La consulta está vacía o es demasiado larga.');
        }
        // Quita literales de texto para analizar solo la estructura
        $s = preg_replace("/'(?:[^'\\\\]|\\\\.|'')*'/s", ' 0 ', $sql);
        $s = preg_replace('/"(?:[^"\\\\]|\\\\.|"")*"/s', ' 0 ', $s);
        if (strpbrk($s, "'\"") !== false) {
            throw new InvalidArgumentException('Comillas sin cerrar en la consulta.');
        }
        if (str_contains($s, ';')) {
            throw new InvalidArgumentException('Solo se permite una consulta.');
        }
        if (preg_match('/--|\/\*|\*\/|#|@/', $s)) {
            throw new InvalidArgumentException('No se permiten comentarios ni variables.');
        }
        $l = strtolower(str_replace('`', ' ', $s));
        if (! preg_match('/^\s*(select|with)\b/', $l)) {
            throw new InvalidArgumentException('Solo se permiten consultas SELECT.');
        }
        $prohib = 'insert|update|delete|drop|alter|create|truncate|grant|revoke|call|execute|prepare|handler|load|outfile|dumpfile|into|lock|unlock|set|rename|use|show|describe|explain|optimize|analyze|sleep|benchmark|load_file|get_lock|release_lock|information_schema|performance_schema|mysql|sys|user|current_user|session_user|system_user|database|schema|version|connection_id|row_count|found_rows|last_insert_id|uuid|procedure|kill|shutdown|flush|reset|purge|install|uninstall|import|binlog|xa|savepoint|commit|rollback|begin|start|recursive';
        if (preg_match('/\b(' . $prohib . ')\b/', $l, $m)) {
            throw new InvalidArgumentException('Palabra no permitida en la consulta: ' . strtoupper($m[1]));
        }
        if (preg_match('/for\s+update|lock\s+in\s+share/', $l)) {
            throw new InvalidArgumentException('Bloqueos no permitidos.');
        }
        // Ninguna tabla/vista real: solo los alias v_ia_*
        if (self::$reales === null) {
            self::$reales = [];
            foreach (DB::connection()->getPdo()->query('SHOW FULL TABLES')->fetchAll(PDO::FETCH_NUM) as $r) {
                self::$reales[strtolower($r[0])] = true;
            }
            self::$reales[strtolower((string) config('database.connections.' . config('database.default') . '.database'))] = true;
        }
        if (preg_match_all('/(?<![\w.])(?:(as)\s+)?([a-z_][a-z0-9_]*)\b/', $l, $mm, PREG_SET_ORDER)) {
            foreach ($mm as $t) {
                if (isset(self::$reales[$t[2]]) && $t[1] === '') {
                    throw new InvalidArgumentException('Solo puedes consultar las vistas v_ia_* (no la tabla «' . $t[2] . '»). Si es un alias, usa otro nombre.');
                }
            }
        }
        if (preg_match('/\b[a-z_][a-z0-9_]*\s*\.\s*[a-z_][a-z0-9_]*\s*\./', $l)) {
            throw new InvalidArgumentException('No se permiten nombres con base de datos.');
        }

        return $sql;
    }

    /** Ejecuta en solo lectura con límite de tiempo y de filas. Devuelve columnas, filas, truncado, ms y sql. */
    public function ejecutar(string $sql): array
    {
        $sql = $this->validarSql($sql);
        self::instalarVistas();
        $completo = $this->envolver($sql);
        $pdo = DB::connection()->getPdo();
        $t0 = microtime(true);
        foreach (['SET SESSION MAX_EXECUTION_TIME=8000', 'SET SESSION max_statement_time=8'] as $x) {
            try {
                $pdo->exec($x);
            } catch (Throwable) {
            }
        }
        $buf = $pdo->getAttribute(PDO::MYSQL_ATTR_USE_BUFFERED_QUERY);
        try {
            $pdo->exec('START TRANSACTION READ ONLY');
            $pdo->setAttribute(PDO::MYSQL_ATTR_USE_BUFFERED_QUERY, false);
            $st = $pdo->query($completo);
            $n = $st->columnCount();
            $cols = $tipos = [];
            for ($i = 0; $i < $n; $i++) {
                $m = $st->getColumnMeta($i);
                $cols[] = $m['name'] ?? ('col' . $i);
                $tipos[] = strtoupper((string) ($m['native_type'] ?? ''));
            }
            $filas = [];
            $trunc = false;
            while ($r = $st->fetch(PDO::FETCH_NUM)) {
                if (count($filas) >= self::MAX_FILAS) {
                    $trunc = true;
                    break;
                }
                foreach ($r as $i => $v) {
                    if ($v !== null && is_string($v) && in_array($tipos[$i], ['NEWDECIMAL', 'DECIMAL', 'LONG', 'LONGLONG', 'SHORT', 'TINY', 'INT24', 'FLOAT', 'DOUBLE'], true) && is_numeric($v)) {
                        $r[$i] = $v + 0;
                    }
                }
                $filas[] = $r;
            }
            $st->closeCursor();
        } catch (PDOException $e) {
            $pdo->setAttribute(PDO::MYSQL_ATTR_USE_BUFFERED_QUERY, $buf);
            try {
                $pdo->exec('ROLLBACK');
            } catch (Throwable) {
            }
            throw new RuntimeException('Error SQL: ' . preg_replace('/^SQLSTATE\[[^\]]*\]:?\s*(\d+\s*)?/', '', $e->getMessage()));
        }
        $pdo->setAttribute(PDO::MYSQL_ATTR_USE_BUFFERED_QUERY, $buf);
        try {
            $pdo->exec('ROLLBACK');
        } catch (Throwable) {
        }

        return ['columnas' => $cols, 'filas' => $filas, 'truncado' => $trunc, 'ms' => (int) round((microtime(true) - $t0) * 1000), 'sql' => $sql];
    }

    /* =====================================================================
     *  Reglas de negocio compartidas por el Asistente y el Chat
     * ===================================================================== */
    private function reglas(): string
    {
        $dias = ['domingo', 'lunes', 'martes', 'miércoles', 'jueves', 'viernes', 'sábado'];
        $hoy = Carbon::now();

        return "REGLAS:\n- Genera un único SELECT (o WITH ... SELECT) usando SOLO las vistas v_ia_*. Sin punto y coma, sin comentarios, sin variables.\n"
            . '- Hoy es ' . $dias[(int) $hoy->format('w')] . ' ' . $hoy->format('Y-m-d') . " (usa CURDATE()/NOW() para fechas relativas). La semana empieza el lunes. «Este mes» = desde el día 1 del mes actual hasta hoy; «mes pasado» = mes calendario anterior.\n"
            . "- Los estados y métodos de pago están en minúscula. Reservas válidas: estado<>'cancelada'. Huéspedes alojados ahora: reservas con estado='checkin'. Llegadas de hoy: fecha_checkin=CURDATE() y estado IN ('pendiente','confirmada'). Salidas de hoy: fecha_checkout=CURDATE() y estado='checkin'.\n"
            . "- Ingresos cobrados = facturas con estado='pagada' (SUM(total) por fecha de la factura). Cuentas por cobrar = facturas con estado='pendiente' y saldo_pendiente>0. Las facturas 'anulada' nunca cuentan.\n"
            . "- Ocupación % del período = noches ocupadas (COUNT(*) en v_ia_noches con estado<>'cancelada' y fecha dentro del período) / (COUNT(*) de v_ia_habitaciones x número de días del período) x 100. ADR (tarifa media) = SUM(ingreso_noche)/COUNT(*) de v_ia_noches. RevPAR = ingreso de habitaciones del período / (habitaciones x días).\n"
            . "- Habitaciones libres hoy = v_ia_habitaciones con estado='disponible'. Para buscar por nombre de huésped usa LIKE '%texto%' sobre LOWER(columna), con el texto en minúsculas.\n"
            . '- Moneda: ' . $this->moneda . ". Redondea importes con ROUND(x,2). Pon alias de columnas legibles en español (sin espacios: usa guion bajo), por ejemplo tipo_habitacion, noches_vendidas, ingresos.\n"
            . '- Si piden un ranking sin cantidad, usa LIMIT 10; en cualquier caso nunca más de ' . self::MAX_FILAS . " filas. Ordena de forma útil.\n"
            . '- Si la pregunta no se puede responder con estas vistas, no inventes.';
    }

    /* =====================================================================
     *  Asistente de reportes: pregunta en lenguaje natural → SQL
     * ===================================================================== */
    private function promptSistema(): string
    {
        return "Eres el analista de datos de un hotel/hospedaje con sistema de reservas, facturación y caja. Conviertes preguntas en español en UNA consulta SQL (MySQL 8) de solo lectura.\n\n"
            . "VISTAS DISPONIBLES (no existe nada más):\n" . $this->esquemaTexto() . "\n"
            . $this->reglas() . " Si no se puede responder, devuelve sql null y explica en «mensaje».\n\n"
            . "Responde SOLO con un objeto JSON, sin texto adicional ni markdown:\n"
            . '{"titulo":"título corto del reporte","sql":"SELECT ...","grafico":{"tipo":"bar|line|pie|none","x":"alias_columna_etiquetas","y":"alias_columna_numerica"},"mensaje":null}' . "\n"
            . 'grafico.tipo: line para series por fecha, bar para rankings/comparaciones, pie para participación (máx. 8 categorías), none si no tiene sentido graficar.';
    }

    public function preguntar(string $pregunta, ?array $previo = null): array
    {
        $m = [['role' => 'system', 'content' => $this->promptSistema()]];
        if ($previo && ! empty($previo['pregunta']) && ! empty($previo['sql'])) {
            $m[] = ['role' => 'user', 'content' => mb_substr((string) $previo['pregunta'], 0, 300)];
            $m[] = ['role' => 'assistant', 'content' => json_encode(['titulo' => '', 'sql' => mb_substr((string) $previo['sql'], 0, 1500), 'grafico' => ['tipo' => 'none'], 'mensaje' => null], JSON_UNESCAPED_UNICODE)];
        }
        $m[] = ['role' => 'user', 'content' => $pregunta];
        $ultimoError = '';
        for ($intento = 0; $intento < 2; $intento++) {
            $raw = $this->llamar($m);
            $j = self::extraerJson($raw);
            if (! $j) {
                $m[] = ['role' => 'assistant', 'content' => mb_substr($raw, 0, 800)];
                $m[] = ['role' => 'user', 'content' => 'Tu respuesta no era JSON válido. Responde SOLO el objeto JSON indicado.'];
                $ultimoError = 'La IA respondió en un formato inesperado.';
                continue;
            }
            if (empty($j['sql'])) {
                return ['mensaje' => (string) (($j['mensaje'] ?? '') ?: 'No puedo responder esa pregunta con los datos disponibles. Prueba con reservas, ocupación, ingresos, huéspedes, habitaciones, consumos o cuentas por cobrar.')];
            }
            try {
                $r = $this->ejecutar((string) $j['sql']);
                $g = is_array($j['grafico'] ?? null) ? $j['grafico'] : [];

                return $r + [
                    'titulo' => mb_substr(trim((string) ($j['titulo'] ?? '')) ?: $pregunta, 0, 160),
                    'grafico' => [
                        'tipo' => in_array($g['tipo'] ?? '', ['bar', 'line', 'pie', 'none'], true) ? $g['tipo'] : 'none',
                        'x' => (string) ($g['x'] ?? ''),
                        'y' => (string) ($g['y'] ?? ''),
                    ],
                ];
            } catch (Throwable $e) {
                $ultimoError = $e->getMessage();
                $m[] = ['role' => 'assistant', 'content' => $raw];
                $m[] = ['role' => 'user', 'content' => 'Esa consulta falló: ' . $ultimoError . '. Corrígela usando solo las vistas y columnas listadas y responde de nuevo SOLO el JSON.'];
            }
        }
        throw new RuntimeException('No pude generar una consulta válida para esa pregunta. Reformúlala con más detalle. (' . $ultimoError . ')');
    }

    public function resumir(string $pregunta, array $cols, array $filas): string
    {
        $muestra = array_slice($filas, 0, 25);
        $txt = $this->llamar([
            ['role' => 'system', 'content' => 'Eres un analista de un hotel. Responde en español, en 1 o 2 frases claras, mencionando las cifras más relevantes. No uses listas, ni markdown, ni inventes datos que no estén en la tabla. Moneda: ' . $this->moneda . '.'],
            ['role' => 'user', 'content' => "Pregunta: $pregunta\nColumnas: " . implode(', ', $cols) . "\nFilas (" . count($filas) . ' en total, se muestran ' . count($muestra) . "):\n" . json_encode($muestra, JSON_UNESCAPED_UNICODE)],
        ], 250);

        return trim(strip_tags($txt));
    }

    /* =====================================================================
     *  Chat conversacional
     * ===================================================================== */
    private const GUIA = 'Dashboard: resumen del día. Calendario: vista mensual de reservas y ocupación. Reservas: crear (con disponibilidad y tarifa sugerida según temporada), editar y cambiar el estado pendiente → confirmada → checkin → checkout (o cancelada); el check-in marca la habitación como ocupada y el check-out/cancelación la pasa a limpieza; desde la reserva se cargan consumos extra (minibar, restaurante, lavandería, servicios). Huéspedes: directorio con documento (DNI, CE, Pasaporte, RUC). Facturación: una factura por reserva; registrar cobros parciales o totales (efectivo, tarjeta, Yape, transferencia), imprimir y anular (permiso especial). Facturación electrónica SUNAT: emitir boleta/factura, descargar XML y CDR, nota de crédito y resumen diario de boletas (solo administrador configura las credenciales). Caja: abrir y cerrar caja; los cobros se asocian a la caja abierta. Housekeeping: estado de limpieza y mantenimiento de las habitaciones. Habitaciones y tipos de habitación: precio por noche, piso y capacidad. Productos: catálogo de minibar, restaurante, lavandería y servicios. Tarifas de temporada: ajustes por porcentaje o monto fijo en rangos de fechas. Reportes: ingresos, ocupación, ADR, RevPAR, exportar CSV y PDF. Usuarios, Roles y permisos, Configuración (datos del hotel, moneda, IGV, horas de check-in/check-out) y Mi Plan: solo administrador. Backup y Sistema. Asistente IA (reportes con gráficos) y Chat IA.';

    private function promptChat(): string
    {
        return 'Eres el chatbot de «' . $this->hotel . "», un sistema de gestión de hospedaje (hotel). Conversas en español con el administrador, con tono cercano y breve.\n"
            . "Puedes: (1) consultar datos del negocio (reservas, ocupación, habitaciones, huéspedes, facturas, cobros, consumos, productos, tarifas, cajas); (2) explicar cómo usar el sistema; (3) saludar o aclarar. NO puedes registrar, modificar ni borrar nada: si te lo piden, explica en qué módulo se hace.\n\n"
            . "VISTAS DISPONIBLES (no existe nada más):\n" . $this->esquemaTexto() . "\n" . $this->reglas() . "\n"
            . "- Para datos de una reserva, huésped o habitación concretos devuelve pocas columnas útiles y LIMIT 20.\n"
            . "- Si el mensaje es una continuación («¿y el mes pasado?», «¿y por tipo de habitación?»), reutiliza y adapta la consulta anterior.\n\n"
            . 'GUÍA DEL SISTEMA: ' . self::GUIA . "\n\n"
            . "Responde SOLO con un objeto JSON, sin texto adicional ni markdown, en una de dos formas:\n"
            . '{"accion":"consulta","sql":"SELECT ..."}  → cuando necesites datos.' . "\n"
            . '{"accion":"respuesta","texto":"..."}  → cuando no necesites datos (saludo, ayuda de uso, aclaración, o si algo no es posible).';
    }

    /** Un turno de chat. $hist = [['q'=>..., 'sql'=>?, 'a'=>...], ...]. Devuelve ['texto'=>..., 'tabla'=>?, 'sql'=>?] */
    public function chat(string $msg, array $hist): array
    {
        $m = [['role' => 'system', 'content' => $this->promptChat()]];
        foreach (array_slice($hist, -6) as $h) {
            $m[] = ['role' => 'user', 'content' => (string) $h['q']];
            $m[] = ['role' => 'assistant', 'content' => json_encode(! empty($h['sql']) ? ['accion' => 'consulta', 'sql' => $h['sql']] : ['accion' => 'respuesta', 'texto' => mb_substr((string) $h['a'], 0, 300)], JSON_UNESCAPED_UNICODE)];
        }
        $m[] = ['role' => 'user', 'content' => $msg];
        $err = '';
        for ($i = 0; $i < 2; $i++) {
            $raw = $this->llamar($m, 700);
            $j = self::extraerJson($raw);
            if (! $j) {
                $t = trim(strip_tags($raw));
                if ($t !== '' && $t[0] !== '{') {
                    return ['texto' => $t];
                }
                $m[] = ['role' => 'assistant', 'content' => mb_substr($raw, 0, 500)];
                $m[] = ['role' => 'user', 'content' => 'Responde SOLO con el objeto JSON indicado.'];
                continue;
            }
            if (($j['accion'] ?? '') !== 'consulta' || empty($j['sql'])) {
                return ['texto' => trim((string) ($j['texto'] ?? $j['respuesta'] ?? '')) ?: 'No entendí bien. ¿Puedes darme más detalle?'];
            }
            try {
                $r = $this->ejecutar((string) $j['sql']);
            } catch (Throwable $e) {
                $err = $e->getMessage();
                $m[] = ['role' => 'assistant', 'content' => $raw];
                $m[] = ['role' => 'user', 'content' => 'Esa consulta falló: ' . $err . '. Corrígela usando solo las vistas y columnas listadas y responde SOLO el JSON.'];
                continue;
            }
            $muestra = array_slice($r['filas'], 0, 25);
            $texto = $this->llamar([
                ['role' => 'system', 'content' => 'Eres el chatbot de un hotel. Responde en español con tono cercano y breve (máximo 4 frases o una lista corta con guiones). Usa las cifras EXACTAS de los datos, sin inventar nada. Importes con el símbolo ' . $this->moneda . ' (ejemplo de formato: ' . $this->moneda . ' 1,234.50). Si no hay filas, dilo claramente. No menciones SQL, vistas ni columnas técnicas.'],
                ['role' => 'user', 'content' => "Pregunta: $msg\nColumnas: " . implode(', ', $r['columnas']) . "\nFilas (" . count($r['filas']) . ' en total' . ($r['truncado'] ? ', hay más' : '') . ', se muestran ' . count($muestra) . "):\n" . json_encode($muestra, JSON_UNESCAPED_UNICODE)],
            ], 450);

            return [
                'texto' => trim(strip_tags($texto)),
                'sql' => $r['sql'],
                'tabla' => ['columnas' => $r['columnas'], 'filas' => array_slice($r['filas'], 0, 10), 'total' => count($r['filas'])],
            ];
        }
        throw new RuntimeException('No pude consultar eso con los datos disponibles. Prueba reformulando la pregunta. (' . $err . ')');
    }
}
