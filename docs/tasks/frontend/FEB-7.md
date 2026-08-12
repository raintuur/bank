# FEB-7 — Login koos rolliga

## Kirjeldus

### Andmebaasi mudel

Siin taskis mängivad rolli tabelid:

- `user`
- `role`

### Loo sisse logimise vaade `/login`

- Loo uus vaatekomponent (`LoginView.vue`) aadressil `/login`
- Lisa menüsse ka vastav link nimega **Sisse logimine**

### Andmete päring Backend serverilt

Logi sisse vajutamisel:

- Kontrollitakse, et kas kõik väljad on täidetud.
  - Kui kumbki väli on jäänud täitmata, siis väljastatakse veateade **"Täida kõik väljad"**
  - Loo selle jaoks eraldi komponent `AlertDanger.vue`, mis võtab sisse propsi `message`
    - kui `message` on tühi string siis alerti ei kuvata, kui on mingi sisu siis kuvatakse alerti
- Kui kõik vajalikud väljad on täidetud, siis saadetakse backend'ile HTTP sõnum aadressil `GET /api/login` sõnum koos query/request parameetritega:
  - `username` (string)
  - `password` (string)
  - Näidis sõnum: `GET /api/login?username=admin&password=123`

Backend tagastab sellele päringule JSON-i alljärgnevates formaatides.

Status 200 või Status 403

#### Edukas päring (HTTP Status 200)

```json
{
  "userId": 1,
  "roleName": "admin"
}
```

või

```json
{
  "userId": 2,
  "roleName": "customer"
}
```

- Vastusest saadud `userId` väärtus salvestatakse `sessionStorage` faili võtmega `userId`
- Vastusest saadud `roleName` väärtus salvestatakse `sessionStorage` faili võtmega `roleName`
- Menüüst peidetakse ära **Sisse logimine** link
- Menüüsse ilmub link **Logi välja**
- Peale edukat sisse logimist suunatakse kasutaja pangaautomaatide asukohtade vaatele (`/atms`)

#### Vea vastusega päring (HTTP Status 403)

```json
{
  "message": "Vale kasutajanimi või parool",
  "errorCode": 111
}
```

- Kui vastuse Status on 403 ja sõnumi JSON-i välja `errorCode` väärtus on 111, siis kuvada välja `message` veateade ("Vale kasutajanimi või parool")
  - Veateade tuleb võtta error sõnumist, `message` väljalt
- Kõikide teiste vigade puhul suunata kasutaja vaatele `/error`

### Liikumine vaatele `/atms`

- Lehele saabudes peab kätte saama `sessionStorage` oleva `userId` ja `roleName` info ning kuvama seda Alertis (Proof of Concept — et login infot on võimalik talletada ja vajadusel on see kättesaadav ka teistele vaadetele).
- Kui kasutaja on sisse logitud (admin, customer), siis "Sisse logimine" nuppu ei kuvata.
  - Selle asemel kuvatakse "Logi välja" nuppu

## Lisad

Taskiga on kaasas:
- andmebaasi mudeli pilt (tabelid `user`, `role`, `profile` jt);
- mockup sisselogimise vaatest (`/login`) koos veateate näidisega;
- mockup `/atms` vaatest, kus on näha Alert (PoC) sisu ja "Logi välja" nupp.
