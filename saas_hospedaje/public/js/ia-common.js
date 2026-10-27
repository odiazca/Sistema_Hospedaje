/* Utilidades compartidas del Asistente IA y del Chat IA (Hospedaje Pro) · iconos Bootstrap Icons */
(() => {
  if (window.IAU) return;
  const BI = {
    send: 'send-fill', sparkles: 'stars', gear: 'gear-fill', star: 'star', starOn: 'star-fill', x: 'x-lg', download: 'download',
    code: 'code-slash', table: 'table', chat: 'chat-dots-fill', refresh: 'arrow-clockwise', warn: 'exclamation-triangle-fill',
    info: 'info-circle-fill', check: 'check-lg', bolt: 'lightning-charge-fill', shield: 'shield-check', db: 'database',
    clock: 'clock-history', redo: 'arrow-repeat', inbox: 'inbox',
  };
  const IAU = {
    esc: (s) => String(s ?? '').replace(/[&<>"']/g, (c) => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c])),
    fmt: (n, d = 2) => Number(n).toLocaleString('en-US', { minimumFractionDigits: d, maximumFractionDigits: d }),
    money: (n) => ((window.IA && IA.moneda) || 'S/') + ' ' + IAU.fmt(n, 2),
    ico(name, cls = '', fill = false) {
      return `<i class="bi bi-${BI[fill && name === 'star' ? 'starOn' : name] || name} ${cls}" aria-hidden="true"></i>`;
    },
    async api(url, body) {
      const opt = { credentials: 'same-origin', headers: { Accept: 'application/json', 'X-Requested-With': 'XMLHttpRequest', 'X-CSRF-TOKEN': (window.IA && IA.csrf) || '' } };
      if (body !== undefined) { opt.method = 'POST'; opt.headers['Content-Type'] = 'application/json'; opt.body = JSON.stringify(body); }
      let res, j = null;
      try { res = await fetch(url, opt); } catch (e) { throw new Error('No hay conexión con el servidor.'); }
      try { j = await res.json(); } catch (e) { /* sin cuerpo JSON */ }
      if (res.status === 419) throw new Error('Tu sesión expiró. Recarga la página (F5) e inténtalo de nuevo.');
      if (res.status === 403) throw new Error((j && (j.error || j.message)) || 'No tienes permiso para usar el asistente.');
      if (!res.ok || !j || j.ok === false) throw new Error((j && (j.error || j.message)) || 'Error del servidor (' + res.status + ').');
      return j;
    },
    toast(msg, tipo = 'ok') {
      const d = document.createElement('div');
      d.className = 'ia-toast ' + (tipo === 'danger' ? 'bad' : tipo === 'warning' ? 'warn' : 'good');
      d.textContent = msg; document.body.appendChild(d);
      setTimeout(() => { d.style.opacity = '0'; setTimeout(() => d.remove(), 300); }, 2600);
    },
    /** Activa Gemini con solo la clave (valores gratuitos por defecto) y prueba la conexión */
    async activar(clave) {
      await IAU.api(IA.u.config, { proveedor: 'gemini', url: 'https://generativelanguage.googleapis.com/v1beta/openai', modelo: 'gemini-3.5-flash-lite', clave, resumen: 1 });
      await IAU.api(IA.u.probar, {});
    },
  };
  window.IAU = IAU;
})();
