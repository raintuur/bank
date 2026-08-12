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

## Claude Code'i keskkond (WSL2/Ubuntu)

Claude Code terminal jookseb WSL2 Ubuntu sees, mitte Windowsi peal — Windowsi tööriistad (nt IntelliJ, Docker Desktop) ei ole siit kättesaadavad. Vali-IT õpilase masinal on WSL2 sees kindlalt olemas:

- `rg` (ripgrep), `jq`, `tree`, `curl`, `unzip` — otsingu-/abitööriistad
- `java` (OpenJDK 21) — backendi jaoks
- `node`, `npm` (NVM kaudu paigaldatud, eraldi versioon Windowsi Node'ist)
- `gh` (GitHub CLI)
- `psql` — **ainult klient**, andmebaasi server ise jookseb Windowsis (port 5432, `localhost:5432` kaudu kättesaadav WSL2-st)
- Docker **puudub** WSL-i seest natiivselt (ainult Windows Docker Desktopi kaudu, kui õpilane on selle käsitsi sisse lülitanud)

## docs/ kausta struktuur

- `docs/architecture/` — rakenduse arhitektuuridokumendid, sh REST API OpenAPI leping (`openAPI.json`)
- `docs/database/` — PostgreSQL skeemi skriptid (`1_reset_database.sql`, `2_create.sql`, `3_import.sql`), mida käivitatakse backendi lokaalseks seadistamiseks (vt backend/CLAUDE.md andmebaasi jaotist)
- `docs/frontend/` — frontendi arhitektuuri dokumendid (nt projekti struktuur, Vue komponendi struktuur)
- `docs/oppekava/` — Claude Code'i töötoa lühikirjeldus ja kavandi mustand
- `docs/tutorials/` — tööriistade ja integratsioonide seadistusjuhendid

Kogu dokumentatsiooni sisu (sh uued failid) peab olema eestikeelne.

## Andmebaasi kirjeldus

Projekt kasutab lokaalset PostgreSQL-i andmebaasi `vali_it`. Andmebaasi lähtestamise
skriptid asuvad kaustas `docs/database/` ja neid käivitatakse numbrilises järjekorras:

1. `1_reset_database.sql` — kustutab kogu olemasoleva `public` skeemi koos tabelite ja
   andmetega ning loob skeemi uuesti;
2. `2_create.sql` — loob tabelid, primaarvõtmed ja välisvõtmed;
3. `3_import.sql` — lisab arendamiseks vajalikud näidisandmed: rollid, kasutajad, linnad,
   pangaautomaatide asukohad ja tehingutüübid.

Neid skripte saab kasutada andmebaasi puhtalt seisult uuesti loomiseks. Kuna esimene
skript kustutab olemasolevad andmed, ära käivita lähtestamist kasutaja selge soovita.

### Tabelid ja seosed

- `city` — linnad; üks linn võib olla seotud mitme pangaautomaadi asukohaga.
- `location` — pangaautomaadi asukoht, automaatide arv, olek ja koordinaadid; `city_id`
  viitab tabelile `city`.
- `location_image` — asukoha pilt binaarandmetena; `location_id` viitab tabelile
  `location`.
- `transaction_type` — pangaautomaadis pakutava tehingu tüüp, näiteks raha sisse,
  raha välja või maksed.
- `location_transaction_type` — seostabel asukohtade ja tehingutüüpide mitu-mitmele
  seose jaoks; viitab tabelitele `location` ja `transaction_type`.
- `role` — kasutajaroll, näiteks `admin` või `customer`.
- `user` — kasutajakonto, sisselogimisandmed ja olek; `role_id` viitab tabelile `role`.
- `profile` — kasutaja aadress ja telefoninumber; `user_id` viitab tabelile `user`.
- `user_image` — kasutaja pilt binaarandmetena; `user_id` viitab tabelile `user`.

Peamised seoseahelad:

```text
city 1 ── * location 1 ── * location_image
                    * ── * transaction_type (location_transaction_type kaudu)

role 1 ── * user 1 ── * profile
                  1 ── * user_image
```

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

### Pooleliolev töö: töötoa kontrollnimekiri

Jätkame 2026-08-12 toimuva Claude Code'i töötoa läbiviija kontrollnimekirja failis
`docs/oppekava/check-list.md`. Lihtsamad teemad jäävad checklist'i lühikeste punktidena.
Selgitust vajava teema kohta loo lühike spikri-stiilis fail kausta
`docs/oppekava/materjalid/` ja lingi see checklist'ist. Järgi olemasolevate materjalide
ülesehitust, detailsust ja eestikeelset sõnastust. Eesmärk on homseks kasutatav
läbiviimismaterjal, mitte ammendav käsiraamat.




## Development Principles

### 1. Think Before Coding

**Don't assume. Don't hide confusion. Surface tradeoffs.**

Before implementing:
- State your assumptions explicitly. If uncertain, ask.
- If multiple interpretations exist, present them - don't pick silently.
- If a simpler approach exists, say so. Push back when warranted.
- If something is unclear, stop. Name what's confusing. Ask.

### 2. Simplicity First

**Minimum code that solves the problem. Nothing speculative.**

- No features beyond what was asked.
- No abstractions for single-use code.
- No "flexibility" or "configurability" that wasn't requested.
- No error handling for impossible scenarios.
- If you write 200 lines and it could be 50, rewrite it.

Ask yourself: "Would a senior engineer say this is overcomplicated?" If yes, simplify.

### 3. Surgical Changes

**Touch only what you must. Clean up only your own mess.**

When editing existing code:
- Don't "improve" adjacent code, comments, or formatting.
- Don't refactor things that aren't broken.
- Match existing style, even if you'd do it differently.
- If you notice unrelated dead code, mention it - don't delete it.

When your changes create orphans:
- Remove imports/variables/functions that YOUR changes made unused.
- Don't remove pre-existing dead code unless asked.

The test: Every changed line should trace directly to the user's request.

### 4. Goal-Driven Execution

**Define success criteria. Loop until verified.**

Transform tasks into verifiable goals:
- "Add validation" → "Write tests for invalid inputs, then make them pass"
- "Fix the bug" → "Write a test that reproduces it, then make it pass"
- "Refactor X" → "Ensure tests pass before and after"

For multi-step tasks, state a brief plan:
```
1. [Step] → verify: [check]
2. [Step] → verify: [check]
3. [Step] → verify: [check]
```

Strong success criteria let you loop independently. Weak criteria ("make it work") require constant clarification.

## Communication Language

Respond in Estonian by default. Technical terms (e.g. endpoint, branch, merge, refactor) may remain in English.

## Commit Messages

**Commit messages must be written in Estonian.** Technical and programming-specific terms may remain in English where appropriate.
