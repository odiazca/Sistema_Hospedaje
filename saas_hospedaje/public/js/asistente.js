/* Asistente de reportes con IA (Hospedaje Pro) */
(() => {
  const $ = (s) => document.querySelector(s);
  const { esc, fmt, money, ico, api, toast } = IAU;
  const SUG = ['Ocupación por mes de los últimos 6 meses', 'Ingresos cobrados por día este mes', 'Ingresos por método de pago esta semana', 'Ingresos por tipo de habitación este mes', 'Huéspedes que más han gastado', 'Llegadas y salidas de hoy', 'Cuentas por cobrar pendientes', 'Consumos extra por categoría este mes', 'Reservas por estado este mes'];
  const COLORS = ['#0fb6a8', '#155e9c', '#e3a72f', '#ef4444', '#06b6d4', '#8b5cf6', '#ec4899', '#84cc16', '#64748b'];
  let ST = null, last = null, chart = null, cur = null;
  const MONEY = /(total|importe|ingreso|venta|monto|utilidad|costo|precio|tarifa|valor|deuda|gasto|margen|saldo|ticket|promedio|adr|revpar|pagado|cobrado|gastado|consumos|igv|subtotal)/i;
  const isNum = (v) => typeof v === 'number';
  const isDate = (v) => typeof v === 'string' && /^\d{4}-\d{2}-\d{2}/.test(v);
  const label = (c) => c.replace(/_/g, ' ').replace(/^./, (x) => x.toUpperCase());
  const cell = (v, c) => v === null || v === undefined ? '<span class="text-muted">—</span>' : isNum(v) ? (MONEY.test(c) ? money(v) : fmt(v, Number.isInteger(v) ? 0 : 2)) : esc(String(v));
  const modal = (id, on) => { $(id).hidden = !on; document.body.classList.toggle('overflow-hidden', on); };
  const starIco = (on) => ico('star', on ? 'text-warning' : '', on);

  $('#iaChips').innerHTML = SUG.slice(0, 6).map((s) => `<button type="button" class="ia-chip">${esc(s)}</button>`).join('');
  $('#iaChips').addEventListener('click', (e) => { const c = e.target.closest('.ia-chip'); if (c) { $('#iaQ').value = c.textContent; preguntar(true); } });
  $('#iaQ').addEventListener('keydown', (e) => { if (e.key === 'Enter' && !e.shiftKey) { e.preventDefault(); preguntar(); } });
  $('#iaQ').addEventListener('input', (e) => { e.target.style.height = 'auto'; e.target.style.height = Math.min(120, e.target.scrollHeight) + 'px'; });
  $('#frmAsk').onsubmit = (e) => { e.preventDefault(); preguntar(); };
  document.querySelectorAll('[data-close]').forEach((b) => b.addEventListener('click', () => modal('#' + b.dataset.close, false)));
  document.querySelectorAll('.ia-modal').forEach((m) => m.addEventListener('mousedown', (e) => { if (e.target === m) modal('#' + m.id, false); }));

  async function estado() {
    ST = await api(IA.u.estado);
    $('#iaSetup').hidden = ST.listo;
    const lst = (arr, fav) => arr.map((x) => `<div class="it" data-id="${x.id}">${fav ? ico('star', 'text-warning', true) : ico('redo', 'text-muted')}<div class="tx">${esc(x.titulo || x.pregunta)}<small>${esc(x.pregunta)}</small></div><button type="button" data-fav="${x.id}" data-v="${fav ? 0 : 1}" title="${fav ? 'Quitar de favoritas' : 'Marcar como favorita'}">${ico('star')}</button><button type="button" data-del="${x.id}" title="Eliminar">${ico('x')}</button></div>`).join('');
    $('#iaFav').innerHTML = lst(ST.favoritos, true) || '<div class="text-muted small py-2">Marca con la estrella tus consultas frecuentes para repetirlas con un clic (sin gastar IA).</div>';
    $('#iaHis').innerHTML = lst(ST.historial, false) || '<div class="text-muted small py-2">Aún no hay consultas.</div>';
  }
  document.addEventListener('click', async (e) => {
    const side = e.target.closest('.ia-side .it'); if (!side) return;
    const f = e.target.closest('[data-fav]'), d = e.target.closest('[data-del]');
    try {
      if (f) { await api(IA.u.favorito, { id: +f.dataset.fav, valor: +f.dataset.v }); estado(); if (cur && cur.id === +f.dataset.fav) { cur.favorito = +f.dataset.v; const b = $('#iaStar'); if (b) b.innerHTML = starIco(cur.favorito); } return; }
      if (d) { await api(IA.u.borrar, { id: +d.dataset.del }); estado(); return; }
      cargarGuardada(+side.dataset.id);
    } catch (x) { toast(x.message, 'danger'); }
  });

  function cargando(txt) { $('#iaOut').innerHTML = `<div class="ia-card ia-res"><div class="ia-load"><div class="ia-dots"><span></span><span></span><span></span></div><div id="iaLt">${esc(txt)}</div></div></div>`; }
  async function preguntar(auto) {
    const q = $('#iaQ').value.trim(); if (q.length < 4) return toast('Escribe tu pregunta', 'warning');
    if (!ST.listo) { toast('Primero configura el proveedor de IA', 'warning'); return abrirCfg(); }
    $('#iaGo').disabled = true; cargando('Interpretando tu pregunta…');
    const t = setTimeout(() => { const e = $('#iaLt'); if (e) e.textContent = 'Consultando tus datos…'; }, 2500);
    try {
      const r = await api(IA.u.preguntar, { pregunta: q, previo: !auto && last ? { pregunta: last.pregunta, sql: last.sql } : null });
      if (r.mensaje) { $('#iaOut').innerHTML = `<div class="ia-card ia-res"><div class="d-flex gap-3 text-primary">${ico('info', 'fs-4')}<div class="text-body">${esc(r.mensaje)}</div></div></div>`; }
      else { r.pregunta = q; mostrar(r); resumir(r.id); }
      estado();
    } catch (x) { $('#iaOut').innerHTML = `<div class="ia-card ia-res"><div class="d-flex gap-3"><span class="text-warning">${ico('warn', 'fs-4')}</span><div><b>No se pudo completar la consulta</b><div class="small text-muted mt-1">${esc(x.message)}</div></div></div></div>`; }
    clearTimeout(t); $('#iaGo').disabled = false;
  }
  async function cargarGuardada(id) {
    cargando('Ejecutando consulta guardada…');
    try { const r = await api(IA.u.ejecutar, { id }); $('#iaQ').value = r.pregunta; mostrar(r); resumir(r.id); estado(); }
    catch (x) { $('#iaOut').innerHTML = `<div class="ia-card ia-res text-danger">${esc(x.message)}</div>`; }
  }

  function elegirGrafico(r) {
    const cols = r.columnas, f = r.filas; if (!f.length || cols.length < 2) return null;
    const g = r.grafico || {}; let xi = cols.indexOf(g.x), yi = cols.indexOf(g.y);
    if (xi < 0 || yi < 0 || !isNum(f[0][yi])) { xi = cols.findIndex((c, i) => !isNum(f[0][i])); yi = cols.findIndex((c, i) => i !== xi && isNum(f[0][i])); if (xi < 0) xi = 0; }
    if (yi < 0 || !isNum(f.find((x) => x[yi] !== null)?.[yi])) return null;
    let tipo = g.tipo && g.tipo !== 'none' ? g.tipo : (isDate(f[0][xi]) ? 'line' : (f.length <= 40 ? 'bar' : 'none'));
    if (g.tipo === 'none' && !isDate(f[0][xi]) && f.length > 1 && f.length <= 15) tipo = 'bar';
    if (tipo === 'none' || f.length < 2) return null;
    if (tipo === 'pie' && f.length > 8) tipo = 'bar';
    return { xi, yi, tipo };
  }
  function dibujar(r, cfg, tipo) {
    if (chart) { chart.destroy(); chart = null; }
    const cv = $('#iaCv'); if (!cv || !cfg || !window.Chart) return;
    const lab = r.filas.map((x) => isDate(x[cfg.xi]) ? String(x[cfg.xi]).slice(0, 10) : String(x[cfg.xi] ?? '—')), val = r.filas.map((x) => x[cfg.yi]);
    const pie = tipo === 'pie', line = tipo === 'line', yn = r.columnas[cfg.yi];
    Chart.defaults.font.family = "'Inter',sans-serif"; Chart.defaults.color = '#64748b';
    chart = new Chart(cv, { type: pie ? 'doughnut' : tipo, data: { labels: lab, datasets: [{ label: label(yn), data: val, backgroundColor: pie ? COLORS : (line ? 'rgba(15,182,168,.15)' : '#0fb6a8'), borderColor: pie ? '#fff' : '#0fb6a8', borderWidth: 2, borderRadius: line || pie ? 0 : 8, fill: line, tension: .3, pointRadius: line ? 3 : 0 }] },
      options: { responsive: true, maintainAspectRatio: false, indexAxis: !pie && !line && lab.length > 6 && lab.some((l) => l.length > 14) ? 'y' : 'x', plugins: { legend: { display: pie, position: 'right' }, tooltip: { callbacks: { label: (c) => ' ' + (MONEY.test(yn) ? money(c.parsed.y ?? c.parsed) : fmt(c.parsed.y ?? c.parsed, Number.isInteger(c.parsed.y ?? c.parsed) ? 0 : 2)) } } }, scales: pie ? {} : { x: { grid: { display: false } }, y: { beginAtZero: true, grid: { color: 'rgba(148,163,184,.2)' } } } } });
  }

  function mostrar(r) {
    last = r; cur = r; const cfg = elegirGrafico(r); const tipo = cfg?.tipo;
    const th = r.columnas.map((c, i) => `<th class="${r.filas.length && isNum(r.filas[0][i]) ? 'r' : ''}">${esc(label(c))}</th>`).join('');
    const tb = r.filas.map((f) => `<tr>${f.map((v, i) => `<td class="${isNum(v) ? 'r' : ''}">${cell(v, r.columnas[i])}</td>`).join('')}</tr>`).join('') || `<tr><td colspan="${r.columnas.length}"><div class="text-center text-muted py-4">${ico('inbox', 'fs-2 d-block mb-1')}La consulta no devolvió resultados</div></td></tr>`;
    $('#iaOut').innerHTML = `<div class="ia-card ia-res">
      <div class="d-flex justify-content-between align-items-start gap-2 flex-wrap"><div><h5 class="fw-bold mb-0">${esc(r.titulo)}</h5><div class="small text-muted">${r.filas.length} fila(s)${r.truncado ? ' (límite de 500 alcanzado)' : ''} · ${r.ms} ms · «${esc(r.pregunta || '')}»</div></div>
        <div class="d-flex gap-2"><button type="button" class="ia-soft" id="iaStar" title="Favorita">${starIco(r.favorito)}</button><a class="ia-soft" href="${IA.u.csv}/${r.id}">${ico('download')} CSV</a><button type="button" class="ia-soft" id="iaSqlB">${ico('code')} SQL</button></div></div>
      <div id="iaSum"></div>
      ${cfg ? `<div class="d-flex justify-content-end"><div class="ia-seg" id="iaSeg"><button type="button" data-t="bar">Barras</button><button type="button" data-t="line">Líneas</button><button type="button" data-t="pie">Torta</button></div></div><div class="ia-chart"><canvas id="iaCv"></canvas></div>` : ''}
      <div class="ia-tbl"><table class="ia-t"><thead><tr>${th}</tr></thead><tbody>${tb}</tbody></table></div>
      <pre class="ia-sql" id="iaSql" hidden>${esc(r.sql)}</pre></div>`;
    if (cfg) { dibujar(r, cfg, tipo); const seg = $('#iaSeg'); seg.querySelector(`[data-t=${tipo}]`)?.classList.add('on'); seg.onclick = (e) => { const b = e.target.closest('[data-t]'); if (!b) return; seg.querySelectorAll('button').forEach((x) => x.classList.toggle('on', x === b)); dibujar(r, cfg, b.dataset.t); }; }
    $('#iaSqlB').onclick = () => { const p = $('#iaSql'); p.hidden = !p.hidden; };
    $('#iaStar').onclick = async () => { try { const v = cur.favorito ? 0 : 1; await api(IA.u.favorito, { id: cur.id, valor: v }); cur.favorito = v; $('#iaStar').innerHTML = starIco(v); estado(); if (v) toast('Guardada en favoritas'); } catch (x) { toast(x.message, 'danger'); } };
    document.querySelector('.ia-res')?.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
  }
  async function resumir(id) {
    if (!ST.cfg.resumen) return; const box = $('#iaSum'); if (!box) return;
    box.innerHTML = `<div class="ia-sum">${ico('sparkles')}<div class="ia-dots mt-1"><span></span><span></span><span></span></div></div>`;
    try { const r = await api(IA.u.resumir, { id }); if (cur && cur.id === id && $('#iaSum')) $('#iaSum').innerHTML = `<div class="ia-sum">${ico('sparkles')}<div>${esc(r.resumen)}</div></div>`; }
    catch (x) { if ($('#iaSum')) $('#iaSum').innerHTML = ''; }
  }

  // ---- Configuración ----
  function abrirCfg() { cargarCfg(); modal('#mdlCfg', true); }
  function cargarCfg() {
    const c = ST.cfg, P = ST.presets;
    $('#cProv').innerHTML = Object.entries(P).map(([k, p]) => `<option value="${k}">${esc(p.nombre)}</option>`).join(''); $('#cProv').value = c.proveedor;
    $('#cUrl').value = c.url; $('#cMod').value = c.modelo; $('#cKey').value = ''; $('#cRes').checked = !!c.resumen; $('#cErr').textContent = ''; ayuda();
  }
  function ayuda() { const p = ST.presets[$('#cProv').value]; $('#cAyuda').textContent = p.ayuda; $('#cKey').disabled = !p.clave; $('#cKeyH').textContent = !p.clave ? 'Este proveedor no necesita clave.' : (ST.cfg.clave_puesta && $('#cProv').value === ST.cfg.proveedor ? 'Hay una clave guardada. Déjalo vacío para conservarla.' : 'Pega aquí tu clave. Se guarda cifrada y no se vuelve a mostrar.'); }
  $('#cProv').onchange = () => { const p = ST.presets[$('#cProv').value]; if (p.url) { $('#cUrl').value = p.url; $('#cMod').value = p.modelo; } ayuda(); };
  $('#btnCfg').onclick = abrirCfg;
  const datosCfg = () => ({ proveedor: $('#cProv').value, url: $('#cUrl').value, modelo: $('#cMod').value, clave: $('#cKey').value, resumen: $('#cRes').checked ? 1 : 0 });
  $('#frmCfg').onsubmit = async (e) => { e.preventDefault(); $('#cErr').textContent = ''; try { await api(IA.u.config, datosCfg()); await estado(); modal('#mdlCfg', false); toast('Configuración guardada'); } catch (x) { $('#cErr').className = 'small text-danger'; $('#cErr').textContent = x.message; } };
  $('#cTest').onclick = async () => {
    $('#cErr').textContent = ''; const b = $('#cTest'); b.disabled = true; const h = b.innerHTML; b.textContent = 'Probando…';
    try { await api(IA.u.config, datosCfg()); await estado(); const r = await api(IA.u.probar, {}); $('#cErr').className = 'small text-success'; $('#cErr').textContent = '✔ Conexión correcta (respuesta: ' + r.respuesta + ')'; }
    catch (x) { $('#cErr').className = 'small text-danger'; $('#cErr').textContent = x.message; }
    b.disabled = false; b.innerHTML = h;
  };
  $('#btnEsq').onclick = async () => {
    modal('#mdlEsq', true); $('#esqTxt').textContent = 'Cargando…';
    try { $('#esqTxt').textContent = await (await fetch(IA.u.esquema, { credentials: 'same-origin' })).text(); } catch (x) { $('#esqTxt').textContent = 'No se pudo cargar.'; }
  };
  $('#frmQuick').onsubmit = async (e) => {
    e.preventDefault(); const k = $('#qKey').value.trim(), b = $('#qGo'); $('#qErr').textContent = ''; if (k.length < 8) { $('#qErr').textContent = 'Pega la clave completa.'; return; }
    b.disabled = true; b.textContent = 'Probando…';
    try { await IAU.activar(k); toast('IA activada'); await estado(); } catch (x) { $('#qErr').textContent = x.message; } b.disabled = false; b.textContent = 'Activar';
  };
  estado().catch((x) => toast(x.message, 'danger'));
})();
