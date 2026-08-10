# Claude Code töötuba — visand (mustand, mitte lõplik kava)

Vaba mõttevahetuse fail teemade ja ideede kogumiseks enne lõpliku õppekava koostamist.

## Kontekst

- Rain koostab 3h praktilise Claude Code töötoa tarkvaraarendajatele.
- Meelis koostab paralleelset töötuba (NL-to-SQL vestlusassistendi lisamine Java rakendusse) — vt `Tehisaru-põhise vestlusassistendi arendamine Java rakendusse - Töötoa lühikirjeldus.pdf`.
- Kaks töötuba ei tohi sisuliselt kattuda.
- Formaat/pikkus paindlik, toimub augusti 1.–3. nädalal, nii klassis kui veebis.
- Tähtaeg Annile: järgmine kolmapäev.

---

## 1. Sihtgrupp

**Otsus:** kogemusega juunior + kesktasemega arendajad. Mitte täiesti algajad.

- Eeldus: osaleja oskab koodi ise lugeda ja mõista, oskab hinnata, kas AI genereeritud lahendus on mõistlik.
- See võimaldab rõhku panna Claude Code võimaluste tutvustamisele (plan mode, agendid, custom skills/commands, MCP), mitte niivõrd üldisele "kuidas AI-väljundit üldse kontrollida" baasile.
- Kontroll/vastutustunde teema (mitte pimesi usaldada AI väljundit) jääb siiski sisse, aga kergema kaaluga — pigem hea harjumus/nipp töövoo sees, mitte töötoa põhitala.
- Täiesti algajad (nt bootcamp/karjäärivahetajad) ei ole sihtgrupp — nende jaoks oleks vaja rohkem alusteadmisi baasist, mis 3h praktilisse formaati ei mahu.

---

## 1b. Fookus: tööriist ja metoodika, mitte kood ise

**Otsus:** töötuba ei keskendu koodile ega koodikvaliteedile — fookus on Claude Code võimalustel ning sellel, kuidas projekti tegemisele üldse läheneda (töövõtted, metoodika, tööriista kasutamise viis).

- See tähendab, et osalejad ei pea genereeritud koodi ennast sügavuti hindama ega parandama — tähtsam on mõista, *mida* Claude Code suudab ja *kuidas* seda tööprotsessi üles ehitada.
- Mõjutab ka punkti 4 kategooriat C (`/code-review`, `/simplify`, `/security-review`): rõhk jääb sellele, et selline töövõte on olemas ja kuidas seda kutsuda, mitte konkreetse koodi kvaliteedi süvaanalüüsile.
- Kooskõlas punktiga 1 — kontroll/vastutustunde teema jääb kergema kaaluga, kuna see pole töötoa põhitala.

---

## 2. Praktiline formaat — olemasolev Vali-IT pangaautomaatide projekt

**Otsus:** kasutada töötoa alusena Vali-IT projektist pärit olemasolevat pangaautomaatide asukoha projekti, mitte valmistada ajakriisis ette uut näidisrepositooriumit.

- Projekti domeen on arusaadav ning läbiviijale juba tuttav.
- Olemas on taskid, OpenAPI teenuste kontrakt ja mock-pildid, mistõttu jääb ettevalmistusaeg töötoa sisu ja Claude Code'i töövõtete viimistlemiseks.
- Töötoa fookus püsib Claude Code'i võimalustel; pangaäpi funktsionaalsus on harjutuste kandja, mitte õpetamise põhiteema.
- Meelise töötoaga sisulise kattumise vältimiseks keskendub see töötuba Claude Code'i töövoole, mitte NL-to-SQL vestlusassistendi arendamisele.

**Mis on repos valmis enne töötuba (tehniline infra, mitte MVP):**

- Stack: Vue.js (frontend), Spring Boot (backend), lokaalne PostgreSQL (andmebaas).
- Ilma autentimiseta (nt JWT/kasutajahaldus) — hoiab repo lihtsana, fookus jääb Claude Code õppimisele, mitte auth-seadistusele.
- **Otsus — DB käivitusviis:** backend kasutab lokaalset PostgreSQL-i ja `vali_it` andmebaasi täpselt nii, nagu on kirjeldatud failis `backend/src/main/resources/application.properties`. H2-le üle ei minda. Töötav andmebaas on ettevalmistatud arenduskeskkonna osa ja töötoa eeltingimus.
- Pangaautomaadi asukohtade rakenduse andmebaasimudel ja SQL-seadistusskriptid on olemas kaustas `docs/database/`.
- OpenAPI.json — teenuste contract (endpoint'ide kirjeldus) olemas juba enne töötuba.
- JSON näidised (nt näidis request/response payload'id) olemas.
- Postman/HTTP request näidised — vt lahtised küsimused.
- CLAUDE.md failid (root + backend + frontend) — konventsioonide näidis, mida Claude Code jälgib.
- Mõned valmis skillid näidiseks, et osalejad näeksid mustrit enne kui ise loovad.
- Task-failid iga harjutuse jaoks (nt tasks/ kaustas), mis annavad konkreetse, järjestikuse ülesande.
- Pre-made promptid (vt punkt 3).

**Eesmärk ei ole valmis MVP** — eesmärk on Claude Code võimaluste õppimine samm-sammult. "Praktiline väljund" iga harjutuse juures on kogemus/oskus, mitte tingimata täiuslik feature.

**Ülesehitus: kumulatiivne, väike arv taske.**

- Iga järgmine task ehitab eelmise peale (nagu Meelise "iga etapp annab töötava vahetulemuse") — annab tugevama narratiivi ja rahulolutunde kui lahtised harjutused.
- Taskide arv hoitakse väiksena — pigem vähem taske, aga iga task valitud läbimõeldult selle järgi, mida ja kuidas see kõige paremini õpetab (milline Claude Code võimalus tuleb kõige paremini esile just selle sammuga).
- Risk: kui keegi jääb ühe task'i juures kinni, kannatab ka järgmine — vaja mõelda, kuidas sellest ajaliselt üle tulla (nt valmis vahepunktid/checkpointid, kuhu saab vajadusel "hüpata").

---

## 3. Promptide progressioon läbi töötoa

**Otsus:** repos on valmis pre-made promptid + koolituse ajal jagatavad promptid, aga struktuur liigub läbi töötoa järk-järgult vähema toe suunas:

1. **Näita** — esimesed tasked kasutavad täisvalmis prompti (kopeeri-kleebi-käivita). Eesmärk on näidata mustrit ja anda kiire varajane õnnestumine, ilma et osaleja peaks veel ise sõnastama.
2. **Tee koos** — keskmised tasked annavad poolikud/juhistega promptid (nt struktuur või näidis olemas, aga osaleja peab ise midagi täiendama või kohandama enne käivitamist) — sunnib aktiivsele lugemisele, mitte pimesi kopeerimisele.
3. **Tee ise** — viimane(sed) task(id) nõuavad, et osaleja kirjutab prompti täiesti ise, ilma etteantud mustrita. See on oluline, kuna sihtgrupp on kesktasemega arendajad (mitte algajad) — muidu jääks õppetulemuseks "oska nuppu vajutada", mitte "oska Claude Code'iga suhelda".

**Why:** valmis promptid annavad turvavõrgu ja tempokontrolli (nt kui keegi jääb kinni), aga ainult see üksi ei õpeta promptimist ennast. Progressioon (näita → tee koos → tee ise) annab pedagoogilise selgroo, mitte ainult mugavuse.

**Lahtine küsimus:** kas koolituse ajal jagatavad promptid on eelnevalt valmis kirjutatud (ennustatav, korratav — oluline kuna sama töötuba toimub nii klassis kui veebis mitmel korral) või osaliselt live-kohandatavad vastavalt rühma tempole? Kaldub esimese poole, aga lõplikult veel otsustamata.

---

## 4. Claude Code slash-käskude kandidaadid (ametlik dokumentatsioon: code.claude.com/docs/en/commands)

Täielik nimekiri on väga pikk (~90 käsku) ja enamik on administratiivsed/UI-seadistused, mis 3h töötoa jaoks pole relevantsed. Allpool on ainult töötoa jaoks valitud kandidaadid, kategooriate kaupa.

### A. Projekti seadistus (algus töötoast)

| Käsk | Mida teeb | Miks sobib |
|---|---|---|
| `/init` | Genereerib alg-CLAUDE.md failist koodibaasi analüüsides | Väga hea avapunkt — näitab, kuidas Claude Code "õpib" projekti tundma |
| `/mcp` | MCP serverite haldus/ühendamine | Kui tahad MCP teemat katta |
| `/permissions` | Tool-kasutuse allow/ask/deny reeglid | Oluline turvalisuse/kontrolli nurgast — mida Claude Code tohib ise teha |

### B. Töövoog ülesande käigus

| Käsk | Mida teeb | Miks sobib |
|---|---|---|
| `/plan` | Sisenemine plan mode'i — Claude teeb enne koodimist plaani, mida saab kinnitada/muuta | Tuumikkäsk — kesktasemega arendaja jaoks üks väärtuslikumaid harjumusi |
| `/model` | Mudeli vahetus (nt Sonnet/Opus/Haiku), effort tase | Lühidalt mainida — millal tasub mudelit vahetada |
| `/effort` | Reasoning-taseme reguleerimine (low/medium/high/xhigh/max) | Koos `/model`-iga |
| `/context` | Näitab, mis täidab kontekstiakent | Hea "mis toimub kapoti all" teema |
| `/compact` | Vestluse kokkuvõtte tegemine konteksti vabastamiseks | Praktiline, sageli vajalik pikemas sessioonis |
| `/diff` | Interaktiivne diff-vaataja | Enne "kas kiita see muudatus heaks" otsust |
| `/rewind` | Koodi/vestluse tagasikerimine checkpointi juurde | Tuumikkäsk — väga väärtuslik "julgen katsetada" harjumuse jaoks, turvavõrk |

### C. Kvaliteet ja review (lõpuosa)

| Käsk | Mida teeb | Miks sobib |
|---|---|---|
| `/code-review` | Diffi ülevaatus vigade/lihtsustuste osas, `--fix` rakendab leiud | Tuumikkäsk — näitab AI-d kui enda töö kontrollijat |
| `/simplify` | Puhtalt kvaliteedile keskenduv ülevaatus (reuse/lihtsus/efektiivsus), rakendab automaatselt | Hea kontrast `/code-review`-ga |
| `/security-review` | Turvaauk-fookusega ülevaatus | Kui aeg lubab — sobib "vastutustundlik kasutus" alateemaga |

### D. Muu kasulik

| Käsk | Mida teeb | Miks sobib |
|---|---|---|
| `/usage` | Sessiooni kulu, plaani limiidid, kasutuse jaotus skilli/subagendi/MCP kaupa | Hea näidata arendajale, kui palju miski maksab/kui palju konteksti kulub |
| `/export` | Ekspordib vestluse puhta tekstina, failina või lõikelauale | Kasulik vestluse/tulemuse jagamiseks pärast töötuba |
| `/color` | Muudab prompt bar värvi praeguses sessioonis | Väike, aga lihtne isikupärastamise näide |
| `/chrome` | Claude in Chrome integratsiooni seadistus | Kasulik, kui katad browser-automation/frontend testimise teemat |

### E. Custom skills/commands — oma sisu loomine

| Kontseptsioon | Mida teeb | Miks sobib |
|---|---|---|
| `.claude/skills/<name>/SKILL.md` või `.claude/commands/<name>.md` | Oma `/nimi` käsu loomine | Väga hea praktiline harjutus — "loo oma korduvkasutatav töövõte" |
| `/skills` | Olemasolevate skillide nimekiri | Lühidalt näidata, mis on juba olemas repos (vt punkt 2 "mõned valmis skillid näidiseks") |

---

## 5. Riskimaandus — kinnijäämine ja Git-haru struktuur

**Otsus:** kõik töötavad samas projektis, aga igal osalejal oma Git-haru. Lektor (Rain) töötab paralleelselt samas repos ja commitib/pushib pidevalt oma harusse. Kui osaleja jääb task'i juures kinni, saab ta kiirelt "järgi tulla" — võtab lektori harult uue haru ja jätkab sealt.

- Annab tempokontrolli — keegi ei jää lõplikult maha, sõltumata sellest, kus keegi parasjagu on.
- Lisaboonusena reaalne Git-õppetunn "peale" (branch checkout, catch-up teise haruga), ilma et see peaks olema eraldi teema.

**Lahendus:** osaleja ei kirjuta oma senist tööd üle. Iga "järgi tulemine" loob uue paralleelse haru postfixiga (nt `osaleja-nimi-v1`, `-v2`, `-v3` jne). Vana haru jääb alles ja osaleja saab hiljem, pärast töötuba, oma varasema katse juurde tagasi vaadata, kui soovib. See on turvavõrk töö kadumise vastu, mitte "puhas checkpoint, alusta uuesti".

---

## Lahtised küsimused

- Kas koolituse ajal jagatavad promptid on eelnevalt valmis kirjutatud või osaliselt live-kohandatavad? (vt punkt 3)
- Kas repos on ka Postman/HTTP request näidised — kaalumisel, veel kindlalt otsustamata (vt punkt 2).
- Täpne taskide valik, sisu ja järjekord (millised A–E kandidaadid millisesse taski lähevad) — planeeritakse eraldi, kui kontseptsioon on paigas.
