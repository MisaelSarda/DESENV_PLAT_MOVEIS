const CACHE_NAME = 'nascar-v1.0.0';
const STATIC_CACHE = 'nascar-static-v1.0.0';
const DYNAMIC_CACHE = 'nascar-dynamic-v1.0.0';

const STATIC_FILES = [
  './',
  './index.html',
  './style.css',
  './manifest.json',
  './images/nascar-hero.jpg',
  './images/nascar-sobre.png',
  './images/piloto1.png',
  './images/piloto2.png',
  './images/piloto3.png',
  './images/talladega.png'
];

self.addEventListener('install', event => {
  console.log('Service Worker: Instalando...');
  event.waitUntil(
    caches.open(STATIC_CACHE)
      .then(cache => {
        console.log('Service Worker: Cache estático criado');
        return cache.addAll(STATIC_FILES);
      })
      .then(() => {
        console.log('Service Worker: Arquivos estáticos em cache');
        return self.skipWaiting();
      })
      .catch(err => console.log('Erro ao fazer cache:', err))
  );
});

self.addEventListener('activate', event => {
  console.log('Service Worker: Ativando...');
  event.waitUntil(
    caches.keys().then(cacheNames => {
      return Promise.all(
        cacheNames.map(cacheName => {
          if (cacheName !== STATIC_CACHE && cacheName !== DYNAMIC_CACHE) {
            console.log('Service Worker: Removendo cache antigo:', cacheName);
            return caches.delete(cacheName);
          }
        })
      );
    }).then(() => {
      console.log('Service Worker: Ativado');
      return self.clients.claim();
    })
  );
});

self.addEventListener('fetch', event => {

  if (STATIC_FILES.includes(event.request.url.replace(self.location.origin, '.'))) {
    event.respondWith(
      caches.match(event.request)
        .then(response => {
          return response || fetch(event.request);
        })
    );
  }
  
  else {
    event.respondWith(
      fetch(event.request)
        .then(response => {
          
          const responseClone = response.clone();
          
          
          caches.open(DYNAMIC_CACHE)
            .then(cache => {
              cache.put(event.request, responseClone);
            });
          
          return response;
        })
        .catch(() => {
          
          return caches.match(event.request);
        })
    );
  }
});

self.addEventListener('message', event => {
  if (event.data && event.data.type === 'SKIP_WAITING') {
    self.skipWaiting();
  }
});

self.addEventListener('updatefound', () => {
  console.log('Service Worker: Nova versão disponível');
});
