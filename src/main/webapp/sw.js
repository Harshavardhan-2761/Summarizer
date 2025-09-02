self.addEventListener("install", e => {
  e.waitUntil(
    caches.open("summarizer-cache").then(cache =>
      cache.addAll(["/", "/manifest.json"])
    )
  );
});

self.addEventListener("fetch", e => {
  e.respondWith(
    caches.match(e.request).then(resp => resp || fetch(e.request))
  );
});
