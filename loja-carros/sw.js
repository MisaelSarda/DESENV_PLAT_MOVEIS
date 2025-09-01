const CACHE_NAME = "autocar-cache-v1";
const urlsToCache = [
  "/",
  "/index.html",
  "/style.css",
  "/images/carro1.jpg",
  "/images/carro2.jpg",
  "/images/carro3.jpg"
];

self.addEventListener("install", event => {
  event.waitUntil(
    caches.open(CACHE_NAME)
      .then(cache => cache.addAll(urlsToCache))
  );
});

self.addEventListener("fetch", event => {
  event.respondWith(
    caches.match(event.request)
      .then(response => response || fetch(event.request))
  );
});
