# CLAUDE.md

See fail annab Claude Code'ile juhised selles repositooriumis töötamiseks.

**Keel:** Kõik uued kanded projekti CLAUDE.md failidesse kirjutatakse eesti keeles.

## Ülevaade

See on Vali-IT pangaäpi monorepo: Spring Boot backend + Vue 3 frontend.

```
backend/    Spring Boot 4.x / Java 21 REST API — vt backend/CLAUDE.md
frontend/   Vue 3 + Vite SPA — vt frontend/CLAUDE.md
docs/       Dokumentatsioon ja andmebaasiskriptid
```

**Backend ja frontend on eraldi arendatavad ja käivitatavad rakendused** — igaühel on oma CLAUDE.md alamkaustas koos täpsete ehitus-/käivitus-/testikäskudega, arhitektuuri ja koodikonventsioonidega. Enne kummaski kaustas töötamist loe vastav CLAUDE.md.

## Töötoa kontekst

Repositooriumit kasutatakse Claude Code'i tarkvaraarenduse töötoa ettevalmistamisel. Töötoa eesmärk on õpetada kogemusega juunior- ja kesktaseme arendajatele eelkõige tööriista võimalusi ning süsteemset tööviisi, mitte teha koodikvaliteedi süvaõpet.

Töötoa sisu kavandamisel ja õppematerjalide muutmisel arvesta dokumentidega:

- `docs/oppekava/Claude Code kasutamine tarkvaraarenduses - Töötoa lühikirjeldus.md` — kokkulepitud eesmärk, ülesehitus, õpitulemid ja praktiline väljund;
- `docs/oppekava/claude-code-tootoa-visand.md` — mustand, põhjendused, ideed ja lahtised küsimused; vastuolu korral eelista lühikirjeldust ning küsi olulise sisulise valiku puhul kasutajalt kinnitust.

Töötoa materjalide loomisel järgi neid põhimõtteid:

- hoia ülesanded vähesed, väikesed, kumulatiivsed ja töötava vahetulemusega;
- suuna osaleja kasutama enne muudatuste tegemist plaani ning pärast muudatusi diffi, teste ja ülevaatust;
- vähenda promptide tuge astmeliselt: täisvalmis prompt → täiendatav prompt → iseseisvalt koostatav prompt;
- tee Claude Code'i töövõte osalejale nähtavaks: selgita lühidalt, millist võimalust kasutatakse ja miks;
- ära tee osaleja eest vaikimisi Git-commite, ära kirjuta tema muudatusi üle ega kasuta destruktiivseid Git-käske;
- kasuta töötoa praktilise alusena seda olemasolevat Vali-IT pangaautomaatide asukoha projekti ning selle task'e, OpenAPI lepingut ja mock-pilte;
- eelda töötoa arenduskeskkonnas lokaalset PostgreSQL-i ja `vali_it` andmebaasi vastavalt faili `backend/src/main/resources/application.properties` seadistusele; ära asenda seda H2-ga.

## Claude Code'i keskkond (WSL2/Ubuntu)

Claude Code terminal jookseb WSL2 Ubuntu sees, mitte Windowsi peal — Windowsi tööriistad (nt IntelliJ, Docker Desktop) ei ole siit kättesaadavad. Vali-IT õpilase masinal on WSL2 sees kindlalt olemas:

- `rg` (ripgrep), `jq`, `tree`, `curl`, `unzip` — otsingu-/abitööriistad
- `java` (OpenJDK 21) — backendi jaoks
- `node`, `npm` (NVM kaudu paigaldatud, eraldi versioon Windowsi Node'ist)
- `gh` (GitHub CLI)
- `psql` — **ainult klient**, andmebaasi server ise jookseb Windowsis (port 5432, `localhost:5432` kaudu kättesaadav WSL2-st)
- Docker **puudub** WSL-i seest natiivselt (ainult Windows Docker Desktopi kaudu, kui õpilane on selle käsitsi sisse lülitanud)

## docs/ kausta struktuur

- `docs/database/` — PostgreSQL skeemi skriptid (`1_reset_database.sql`, `2_create.sql`, `3_import.sql`), mida käivitatakse backendi lokaalseks seadistamiseks (vt backend/CLAUDE.md andmebaasi jaotist)
- `docs/frontend/` — frontendi arhitektuuri dokumendid (nt projekti struktuur, Vue komponendi struktuur)
- `docs/oppekava/` — Claude Code'i töötoa lühikirjeldus ja kavandi mustand
- `docs/tutorials/` — tööriistade ja integratsioonide seadistusjuhendid

Kogu dokumentatsiooni sisu (sh uued failid) peab olema eestikeelne.
