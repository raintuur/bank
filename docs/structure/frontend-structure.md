# Frontendi soovituslik struktuur

See on Vue 3 + Vite frontendi soovituslik sihtstruktuur. Loo ainult funktsionaalsuse jaoks
vajalikud kaustad ja failid; `example` tähistab päris funktsionaalsust, näiteks `location`
või `transactionType`.

```text
frontend/
├── public/                              // Vite'i poolt töötlemata staatilised failid
│   └── favicon.ico                      // Brauseri vahelehe ikoon
├── src/                                 // Rakenduse lähtekood
│   ├── assets/                          // Vite'i töödeldavad pildid ja stiilid
│   │   ├── images/
│   │   │   └── example.png
│   │   └── main.css                     // Rakenduse globaalsed stiilid
│   ├── components/                      // Korduvkasutatavad Vue komponendid
│   │   ├── common/                      // Domeenist sõltumatud UI komponendid
│   │   │   └── LoadingSpinner.vue
│   │   └── example/                     // Funktsionaalsuse komponendid, nt location
│   │       ├── ExampleForm.vue          // Lisamise ja muutmise vorm
│   │       └── ExampleList.vue          // Andmete loetelu või tabel
│   ├── router/
│   │   └── index.js                     // Marsruudid ja navigatsioonikaitsed
│   ├── services/                        // Backendi API-ga suhtlemine
│   │   └── exampleService.js            // Funktsionaalsuse API-päringud
│   ├── stores/                          // Pinia jagatud olek
│   │   └── example.js                   // Funktsionaalsuse store
│   ├── views/                           // Marsruutidele vastavad lehevaated
│   │   ├── HomeView.vue                 // Avaleht
│   │   └── example/                     // Funktsionaalsuse vaated, nt location
│   │       ├── ExampleListView.vue
│   │       └── ExampleDetailView.vue
│   ├── App.vue                          // Rakenduse juurkomponent ja RouterView
│   └── main.js                          // Vue, Routeri ja Pinia käivitamine
├── .gitignore                           // Giti poolt eiratavad failid
├── eslint.config.js                     // ESLinti reeglid
├── index.html                           // Vite'i HTML-mall
├── jsconfig.json                        // JavaScripti sätted ja teealiased
├── package-lock.json                    // Lukustatud sõltuvuste versioonid
├── package.json                         // Sõltuvused ja npm-skriptid
└── vite.config.js                       // Vite'i ja API proksi seadistus
```

## Kaustade vastutus

- `views/` sisaldab marsruutidele vastavaid lehekomponente. Vaade seob lehe osad kokku,
  kuid korduvkasutatav UI ja API-päringud ei kuulu otse vaatesse.
- `components/` sisaldab korduvkasutatavaid komponente. Domeenist sõltumatud komponendid
  lähevad `common/` alla, funktsionaalsusega seotud komponendid oma alankausta.
- `services/` koondab Axiosel põhinevad API-päringud. Üks teenus vastutab ühe
  funktsionaalsuse või ressursi eest.
- `stores/` sisaldab ainult komponentide vahel jagatavat Pinia olekut. Ühe komponendi
  lokaalne olek jääb komponenti.
- `router/` kirjeldab URL-ide ja vaadete seosed ning vajaduse korral
  navigatsioonikaitsed.
- `assets/` sisaldab lähtekoodist imporditavaid pilte ja stiile. Muutmata kujul avaldatavad
  failid lähevad `public/` kausta.

## Nimetamine

- Vue komponentide ja vaadete failinimed on PascalCase'is: `LocationList.vue` ja
  `LocationDetailView.vue`.
- Teenusefailide nimed on camelCase'is ja lõppevad sõnaga `Service`:
  `locationService.js`.
- Pinia store'i fail saab funktsionaalsust kirjeldava nime, näiteks `location.js`.
- Üldine komponent saab `App`-prefiksi või selgelt rolli kirjeldava nime, näiteks
  `AppNavbar.vue` või `LoadingSpinner.vue`.

Ära loo tühje näidiskaustu ette. Kui projekt võtab hiljem kasutusele TypeScripti, i18n-i
või testiraamistiku, lisa nende jaoks eraldi struktuur alles koos vastava seadistusega.
