# Backendi soovituslik struktuur

See on Spring Boot backendi soovituslik sihtstruktuur. Loo ainult funktsionaalsuse jaoks
vajalikud paketid ja failid; `example` tähistab päris domeeni nime, näiteks `location` või
`city`.

```text
backend/
├── gradle/
│   └── wrapper/                                  // Gradle Wrapperi failid
│       ├── gradle-wrapper.jar
│       └── gradle-wrapper.properties
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── ee/bcs/bank/                      // Rakenduse baaspakett
│   │   │       ├── controller/                    // REST endpointid ja DTOd
│   │   │       │   └── example/                   // Domeeni alampakett, nt location
│   │   │       │       ├── ExampleController.java // REST-kontroller
│   │   │       │       └── dto/                   // Päringu ja vastuse DTOd
│   │   │       │           └── ExampleInfo.java
│   │   │       ├── infrastructure/                // Läbivad tehnilised komponendid
│   │   │       │   ├── RestExceptionHandler.java // Globaalne API veakäsitleja
│   │   │       │   ├── error/                     // Standardne veavastuse mudel
│   │   │       │   │   └── ApiError.java
│   │   │       │   └── exception/                 // Kohandatud erindiklassid
│   │   │       │       ├── DataNotFoundException.java
│   │   │       │       ├── ForbiddenException.java
│   │   │       │       └── PrimaryKeyNotFoundException.java
│   │   │       ├── persistence/                   // Andmebaasikiht
│   │   │       │   └── example/                   // Domeeni alampakett, nt location
│   │   │       │       ├── Example.java           // JPA entiteet
│   │   │       │       ├── ExampleMapper.java     // MapStructi mapper
│   │   │       │       └── ExampleRepository.java // Spring Data repositoorium
│   │   │       ├── service/                       // Äriloogika teenused
│   │   │       │   └── ExampleService.java
│   │   │       └── BankApplication.java           // Rakenduse käivitusklass
│   │   └── resources/
│   │       ├── application.properties             // Rakenduse ja DB seadistus
│   │       └── spy.properties                     // P6Spy SQL-logimise seadistus
│   └── test/
│       └── java/
│           └── ee/bcs/bank/                       // Ühiku- ja integratsioonitestid
├── .gitattributes
├── .gitignore
├── build.gradle                                   // Sõltuvused ja build'i seadistus
├── gradlew                                        // Gradle Wrapper Linuxile ja macOS-ile
├── gradlew.bat                                    // Gradle Wrapper Windowsile
└── settings.gradle                                // Gradle projekti nimi ja moodulid
```

## Pakettide vastutus

- `controller/` võtab vastu HTTP-päringud ja tagastab DTOd. Äriloogika ei kuulu
  kontrollerisse.
- `service/` sisaldab äriloogikat ja koordineerib andmebaasitoiminguid.
- `persistence/` sisaldab JPA entiteete, Spring Data repositooriume ja MapStructi
  mappereid. Iga domeen saab oma alampaketi.
- `infrastructure/` sisaldab domeenideüleseid tehnilisi komponente, näiteks veakäsitlust
  ja kohandatud erindeid.
- `resources/` sisaldab rakenduse konfiguratsiooni ja muid käitusaegseid ressursse.
- `test/` peegeldab võimaluse korral production-koodi paketistruktuuri.

Andmebaasi loomise ja algandmete skriptid ei asu `backend/` kaustas. Selle repo ühised
skriptid paiknevad siin:

```text
docs/database/
├── 1_reset_database.sql                          // Lähtestab bank-skeemi
├── 2_create.sql                                  // Loob tabelid ja seosed
└── 3_import.sql                                  // Lisab algandmed
```
