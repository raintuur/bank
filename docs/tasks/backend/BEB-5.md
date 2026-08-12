# BEB-5 — Login koos rolliga

## Kirjeldus

### Andmebaasi mudel

Siin taskis mängivad rolli tabelid: `role` ja `user`.

### Loo teenus `GET /api/login`

Sisse logimisel saadetakse backend serverile HTTP GET sõnum aadressil `/api/login` koos query/request parameetritega (URL'ist väljaspool olevad parameetrid):

- `username` (string)
- `password` (string)

Näited saadetavatest sõnumitest:

```
GET http://localhost:8080/api/login?username=admin&password=123
GET http://localhost:8080/api/login?username=rain&password=123
GET http://localhost:8080/api/login?username=rain&password=blablabla
```

### Happy path

Kui andmebaasis on olemas vastava `username` ja `password`'iga active kasutaja (`user` tabeli veeru `status` väärtus on `A`), siis tagastab teenus HTTP status 200 ja response objekti, kus on alljärgnevad väljad:

- `userId`: number
- `roleName`: string

### Sad path

Kui selliste sisenditega kasutajat ei leitud, siis tagastab teenus HTTP status 403 ja response objekti, kus on alljärgnevad väljad:

- `message`: string
- `errorCode`: integer

Vea halduseks kasutada enumit:

- `INCORRECT_CREDENTIALS`
  - message: Vale kasutajanimi või parool
  - errorCode: 111

### Näidised vastus sõnumitest

Status 200 — admin

```json
{
  "userId": 1,
  "roleName": "admin"
}
```

Status 200 — rain

```json
{
  "userId": 2,
  "roleName": "customer"
}
```

Status 403 — error

```json
{
  "message": "Vale kasutajanimi või parool",
  "errorCode": 111
}
```

## API documentation

Teenuse dokumentatsioon:

- Teenuse kokkuvõtvaks kirjelduseks võiks panna:
  - Sisse logimine. Tagastab userId ja roleName
- Teenuse detailsemaks kirjelduseks võiks panna:
  - Süsteemist otsitakse username ja password abil kasutajat, kelle konto on ka aktiivne. Kui vastet ei leita vistakse viga errorCode'ga 111
- Status 200 kirjeldus:
  - OK
- Status 403 kirjeldus:
  - Vale kasutajanimi või parool

Näidiskood API dokumentatsiooni annotatsioonidest:

```java
@Operation(summary = "Sisse logimine. Tagastab userId ja roleName",
    description = """
        Süsteemist otsitakse username ja password abil kasutajat, kelle konto on ka aktiivne.
        Kui vastet ei leita vistakse viga errorCode'ga 111
        """)
@ApiResponses(value = {
    @ApiResponse(responseCode = "200", description = "OK"),
    @ApiResponse(responseCode = "403", description = "Vale kasutajanimi või parool")
})
public void someMethod() {
}
```

## Lisad

Taskiga on kaasas andmebaasi mudeli pilt (tabelid `user`, `role`, `profile`, `user_image`, `location` jt).
