// Placeholder overwritten by scripts/generate_offline_sw.py after flutter build web.
// Flutter's own generated worker unregisters itself; do not ship that file.
'use strict';
self.addEventListener('install', (event) => {
  event.waitUntil(
    (async () => {
      if (!self.registration.active) {
        await self.skipWaiting();
      }
    })(),
  );
});
self.addEventListener('activate', (event) => {
  event.waitUntil(self.clients.claim());
});
self.addEventListener('message', (event) => {
  const data = event.data;
  if (
    data === 'skipWaiting' ||
    data === 'SKIP_WAITING' ||
    (data && data.type === 'SKIP_WAITING')
  ) {
    event.waitUntil(self.skipWaiting());
  }
});
