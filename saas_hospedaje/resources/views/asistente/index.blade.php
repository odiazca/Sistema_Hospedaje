@extends('layouts.app')
@section('title', 'Asistente IA')
@section('breadcrumb', 'Inteligencia / Asistente IA')

@section('content')
<div class="d-flex justify-content-between align-items-start flex-wrap gap-2 mb-3">
    <div>
        <h1 class="hp-pagetitle">Asistente de reportes</h1>
        <p class="text-muted small mb-0">Pregunta en lenguaje natural y obtén tablas, gráficos y resúmenes de tu hotel</p>
    </div>
    <div class="d-flex gap-2">
        <button type="button" class="ia-soft" id="btnEsq"><i class="bi bi-database"></i> Qué datos ve la IA</button>
        <button type="button" class="ia-soft" id="btnCfg"><i class="bi bi-gear-fill"></i> Configurar IA</button>
    </div>
</div>

<div class="ia-hero">
    <h2><i class="bi bi-stars"></i> ¿Qué quieres saber de tu hotel?</h2>
    <p>Escribe tu pregunta como se la harías a un analista. Ejemplo: «¿Cuál fue la ocupación de cada mes este año?»</p>
    <form class="ia-ask" id="frmAsk">
        <textarea id="iaQ" rows="1" maxlength="500" placeholder="Escribe tu pregunta aquí…" aria-label="Pregunta"></textarea>
        <button type="submit" id="iaGo"><i class="bi bi-send-fill"></i> Preguntar</button>
    </form>
    <div class="ia-chips" id="iaChips"></div>
</div>

<div id="iaSetup" class="ia-card mb-3" hidden>
    <h6 class="fw-bold mb-3"><i class="bi bi-stars text-success me-1"></i> Activa el asistente en 2 minutos (gratis)</h6>
    <div class="ia-step"><b>1</b><div class="small">Entra a <a href="https://aistudio.google.com/apikey" target="_blank" rel="noopener">aistudio.google.com/apikey</a> con tu cuenta de Google y crea una clave gratuita.</div></div>
    <div class="ia-step"><b>2</b>
        <div class="flex-fill small">Pega la clave aquí y pulsa <b>Activar</b>:
            <form class="d-flex gap-2 mt-2 flex-wrap" id="frmQuick">
                <input type="password" class="form-control" id="qKey" style="max-width:340px" placeholder="Clave de Gemini" autocomplete="new-password">
                <button class="ia-btn" id="qGo">Activar</button>
            </form>
            <div class="small text-danger mt-1" id="qErr"></div>
        </div>
    </div>
    <p class="small text-muted mb-2">También puedes usar Groq, OpenRouter u Ollama (local, sin enviar datos a internet) desde la configuración avanzada.</p>
    <button type="button" class="ia-soft" onclick="document.getElementById('btnCfg').click()"><i class="bi bi-gear-fill"></i> Configuración avanzada</button>
</div>

<div class="row g-3">
    <div class="col-lg-8 min-w-0">
        <div id="iaOut">
            <div class="ia-card text-center text-muted py-5">
                <i class="bi bi-chat-dots fs-1 d-block text-secondary opacity-50"></i>
                <div class="mt-2">Aquí aparecerán tus resultados</div>
                <div class="small">Puedes hacer preguntas de seguimiento, como «ahora por tipo de habitación».</div>
            </div>
        </div>
    </div>
    <div class="col-lg-4">
        <div class="ia-card ia-side mb-3">
            <h6 class="fw-bold mb-2"><i class="bi bi-star-fill text-warning me-1"></i> Favoritas</h6>
            <div id="iaFav"></div>
        </div>
        <div class="ia-card ia-side">
            <h6 class="fw-bold mb-2"><i class="bi bi-clock-history me-1"></i> Recientes</h6>
            <div id="iaHis"></div>
        </div>
    </div>
</div>

{{-- Modal: configuración --}}
<div class="ia-modal" id="mdlCfg" hidden>
    <div>
        <form id="frmCfg" novalidate>
            <div class="d-flex align-items-center justify-content-between px-4 pt-4">
                <h5 class="fw-bold mb-0"><i class="bi bi-gear-fill me-1"></i> Configurar el asistente de IA</h5>
                <button type="button" class="btn-close" data-close="mdlCfg" aria-label="Cerrar"></button>
            </div>
            <div class="px-4 py-3 row g-3">
                <div class="col-12">
                    <label class="form-label small fw-semibold">Proveedor</label>
                    <select class="form-select" id="cProv"></select>
                    <div class="form-text" id="cAyuda"></div>
                </div>
                <div class="col-md-7"><label class="form-label small fw-semibold">URL de la API</label><input class="form-control" id="cUrl" autocomplete="off"></div>
                <div class="col-md-5"><label class="form-label small fw-semibold">Modelo</label><input class="form-control" id="cMod" autocomplete="off"></div>
                <div class="col-12">
                    <label class="form-label small fw-semibold">Clave (API key)</label>
                    <input type="password" class="form-control" id="cKey" autocomplete="new-password">
                    <div class="form-text" id="cKeyH"></div>
                </div>
                <div class="col-12">
                    <div class="form-check"><input type="checkbox" class="form-check-input" id="cRes"><label class="form-check-label small" for="cRes">Generar un resumen en lenguaje natural de cada resultado (usa una segunda consulta a la IA)</label></div>
                </div>
                <div class="col-12">
                    <div class="border rounded p-3 small text-muted bg-light"><b class="text-dark">Privacidad y seguridad.</b> La IA solo ve la estructura de unas vistas de lectura de <b>tu hotel</b> (sin contraseñas ni usuarios) y su consulta se valida antes de ejecutarse: solo SELECT, en modo lectura, con límite de tiempo y de filas. Al proveedor se envía tu pregunta y, si activas el resumen, hasta 25 filas del resultado (pueden incluir nombres de huéspedes o habitaciones). Con <b>Ollama</b> nada sale de tu PC. La clave se guarda cifrada.</div>
                </div>
                <div class="col-12 small text-danger" id="cErr"></div>
            </div>
            <div class="d-flex align-items-center gap-2 px-4 pb-4">
                <button type="button" class="ia-soft me-auto" id="cTest"><i class="bi bi-lightning-charge-fill"></i> Probar conexión</button>
                <button type="button" class="ia-soft" data-close="mdlCfg">Cerrar</button>
                <button type="submit" class="ia-btn"><i class="bi bi-check-lg"></i> Guardar</button>
            </div>
        </form>
    </div>
</div>

{{-- Modal: datos que ve la IA --}}
<div class="ia-modal" id="mdlEsq" hidden>
    <div>
        <div class="d-flex align-items-center justify-content-between px-4 pt-4">
            <h5 class="fw-bold mb-0"><i class="bi bi-database me-1"></i> Datos que ve la IA</h5>
            <button type="button" class="btn-close" data-close="mdlEsq" aria-label="Cerrar"></button>
        </div>
        <div class="px-4 py-3">
            <p class="small text-muted mb-2">Solo estas vistas de lectura, filtradas por tu empresa. Nunca accede a las tablas reales, usuarios ni contraseñas.</p>
            <pre class="ia-sql" id="esqTxt" style="margin:0"></pre>
        </div>
    </div>
</div>
@endsection

@push('scripts')
<script src="{{ asset('js/asistente.js') }}?v=1"></script>
@endpush
