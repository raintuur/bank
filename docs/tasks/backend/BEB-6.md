# BEB-6 — Linnade info

## Kirjeldus

### Andmebaasi mudel

Siin taskis mängib rolli tabel: `city`.

### Loo teenus `GET /api/cities`

- Teenus peab tagastama loetelu kõikidest linnadest.
- Näide saadetavast sõnumist:

```
GET http://localhost:8080/api/cities
```

- Teenus peab tagastama listi (massiivi) objektidest, milles on alljärgnevad väljad:
  - `cityId`: number
  - `cityName`: string

### Näidised vastus sõnumitest

Status 200

```json
[
  {
    "cityId": 2,
    "cityName": "Tallinn"
  },
  {
    "cityId": 3,
    "cityName": "Tartu"
  },
  {
    "cityId": 1,
    "cityName": "Pärnu"
  }
]
```

## API documentation

Teenuse dokumentatsioon:

- Teenuse kokkuvõtvaks kirjelduseks võiks panna:
  - Leiab süsteemist (andmebaasist city tabelist) kõik linnad.
- Teenuse detailsemaks kirjelduseks võiks panna:
  - Tagastab info koos cityId ja cityName'ga

Näidiskood API dokumentatsiooni annotatsioonidest:

```java
@Operation(
    summary = "Leiab süsteemist (andmebaasist city tabelist) kõik linnad.",
    description = "Tagastab info koos cityId ja cityName'ga"
)
```

## Lisad

Taskiga on kaasas andmebaasi mudeli pilt (tabelid `city`, `user`, `role`, `profile`, `location` jt).

## Detailid

- Staatus: To Do
- Assignee: Unassigned
- Parent: BEB-2 Pangaautomaatide info
- Priority: Medium
- Reporter: Rain
