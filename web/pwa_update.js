/**
 * PWA update strip: detect a waiting service worker, then let the user apply
 * it. The new build is downloaded when the app is opened. Do not auto-reload
 * (that races first-install precache).
 *
 * Do not fetch version.json — that duplicated SW update() and showed up as
 * a Network stampede (often attributed to the worker).
 */
(function () {
  if (window.__elementdeckPwaInit) return;
  window.__elementdeckPwaInit = true;
  if (!('serviceWorker' in navigator)) return;

  var applyRequested = false;
  var readyNotified = false;
  var waitingWorker = null;
  var lastCheckAt = 0;
  var CHECK_TTL_MS = 10 * 60 * 1000;

  function notifyReady() {
    if (readyNotified) return;
    readyNotified = true;
    try {
      window.__elementdeckPwaUpdateReady = true;
      window.dispatchEvent(new CustomEvent('elementdeck-pwa-update'));
    } catch (_) {}
  }

  function rememberWaiting(worker) {
    if (!worker || worker.state === 'redundant') return;
    waitingWorker = worker;
    notifyReady();
  }

  window.__elementdeckApplyPwaUpdate = function () {
    applyRequested = true;
    if (waitingWorker) {
      try {
        waitingWorker.postMessage('SKIP_WAITING');
        waitingWorker.postMessage('skipWaiting');
        waitingWorker.postMessage({ type: 'SKIP_WAITING' });
      } catch (_) {}
    }
    window.setTimeout(function () {
      window.location.reload();
    }, 250);
  };

  window.__elementdeckCheckPwaUpdate = function (force) {
    if (!navigator.onLine) return;
    var now = Date.now();
    if (!force && lastCheckAt && now - lastCheckAt < CHECK_TTL_MS) return;
    lastCheckAt = now;
    navigator.serviceWorker.getRegistration().then(function (reg) {
      if (!reg) return;
      if (reg.waiting) rememberWaiting(reg.waiting);
      reg.update().catch(function () {});
    });
  };

  window.__elementdeckNotifyPwaIfReady = function () {
    if (!readyNotified) return;
    try {
      window.dispatchEvent(new CustomEvent('elementdeck-pwa-update'));
    } catch (_) {}
  };

  navigator.serviceWorker.addEventListener('controllerchange', function () {
    if (!applyRequested) return;
    window.location.reload();
  });

  function watchRegistration(reg) {
    if (!reg) return;
    if (reg.waiting) rememberWaiting(reg.waiting);
    reg.addEventListener('updatefound', function () {
      var installing = reg.installing;
      if (!installing) return;
      installing.addEventListener('statechange', function () {
        if (installing.state === 'installed' && navigator.serviceWorker.controller) {
          rememberWaiting(reg.waiting || installing);
        }
      });
    });
  }

  function onOpened() {
    window.__elementdeckCheckPwaUpdate(true);
  }

  document.addEventListener('visibilitychange', function () {
    if (document.visibilityState === 'visible') onOpened();
  });
  window.addEventListener('pageshow', onOpened);

  var swUrl = new URL('flutter_service_worker.js', document.baseURI).href;
  fetch(swUrl, { cache: 'no-cache', credentials: 'same-origin' })
    .then(function (res) {
      if (!res.ok) throw new Error('service worker missing');
      return res.text();
    })
    .then(function (body) {
      // Flutter's default worker unregisters itself and reloads every client.
      if (body.indexOf('registration.unregister') !== -1) {
        console.warn('[Element Deck] skipping Flutter unregister service worker');
        return null;
      }
      return navigator.serviceWorker.register(swUrl);
    })
    .then(function (reg) {
      if (!reg) return;
      watchRegistration(reg);
      window.__elementdeckCheckPwaUpdate(true);
      window.setInterval(function () {
        window.__elementdeckCheckPwaUpdate(false);
      }, 15 * 60 * 1000);
    })
    .catch(function (err) {
      console.warn('[Element Deck] service worker registration failed', err);
    });
})();
