# Claude Code töötoa kontrollnimekiri

Lihtne kontrollnimekiri töötoa ajal järje hoidmiseks. Märgi käsitletud teema tehtuks kujul `[x]`.

## Enne töötoa algust

- [x] Osalejatel on Claude Code kasutamiseks subscription või API key
- [x] Projekt on kloonitud
- [x] [Iga osaleja töötab oma Git-harus](materjalid/git-harud-ja-opetajale-jargi-tulemine.md)
- [x] Vajalikud arendustööriistad töötavad WSL2/Ubuntu keskkonnas
- [x] Lokaalne PostgreSQL töötab
- [x] [IntelliJ Database'i all on ühendus olemas](materjalid/intellij-andmebaasi-uhendus.md)
- [x] `vali_it` andmebaas on loodud ja seadistatud
- [x] Backendi build ja testid töötavad
- [x] Frontendi sõltuvused on paigaldatud ja rakendus käivitub
- [x] [Promptide jagamine töötoa ajal](materjalid/promptide-jagamine.md)
- [x] [Soovi korral võib jääda vaatlejaks](materjalid/vaatlejana-osalemine.md)
- [x] [Töötuba on dialoog](materjalid/tootuba-on-dialoog.md)

## Sissejuhatus

- [x] [Töötoa eesmärk ja ülesehitus](materjalid/tootoa-eesmark-ja-ulesehitus.md)
- [x] [`/init`](materjalid/init.md)
- [x] [`CLAUDE.md` failide eesmärk](materjalid/claude-md-failide-eesmark.md)
- [x] [Kuidas Claude Code projekti konteksti kasutab](materjalid/claude-code-projekti-kontekst.md)

## Claude Code'i terminali põhivõtted

- [x] `/` — käskude ja skillide menüü
- [x] `@` — failile või kaustale viitamine
- [x] `!` — terminalikäsu käivitamine (!git status)
- [x] `Alt+V` — lõikelaualt pildi lisamine Windowsis
- [x] `Shift+Enter` või `Ctrl+J` — uus rida promptis
- [x] `↑` / `↓` — varasemate promptide sirvimine
- [x] `Ctrl+U` — sisestusrea tühjendamine
- [x] `Esc` — Claude'i tegevuse katkestamine
- [x] [`Ctrl+Z` — Claude Code'i peatamine](materjalid/ctrl-z.md)
- [x] [`Shift+Tab` — permission mode'i vahetamine](materjalid/permission-mode.md)
- [x] [`Ctrl+Alt+K` — IDE-st faili ja valitud ridade lisamine](materjalid/ctrl-alt-k.md)
- [x] Ava kõrvale uus terminal — korraga võib olla avatud mitu terminali

## Käsud ja featuurid

- [x] [`/model`](materjalid/model.md)
- [x] [`/effort`](materjalid/effort.md)
- [x] [`settings.json`](materjalid/settings-json.md)
- [x] [`/permissions`](materjalid/permissions.md)
- [x] [`/chrome`](materjalid/chrome.md)
- [x] `/powerup` — lühikesed interaktiivsed õpetused
- [x] `/color` — promptiriba värvi muutmine
- [x] `/copy` — Claude'i viimase vastuse kopeerimine
- [x] `/skills` — saadaolevate skillide vaatamine


## Kontekst ja sessiooni haldamine

- [ ] [`/usage`](materjalid/usage.md)
- [ ] [`/context`](materjalid/context.md)
- [ ] [`/export`](materjalid/export.md)
- [ ] [`/compact`](materjalid/compact.md)
- [ ] [`/clear`](materjalid/clear.md)

## Korduvkasutatavad töövõtted

- [ ] [Mis asi on skill](materjalid/mis-asi-on-skill.md)
- [ ] [Skilli ja tavalise prompti erinevus](materjalid/skilli-ja-tavalise-prompti-erinevus.md)
- [ ] [Skill-faili ülesehitus ja nõuded](materjalid/skill-faili-ulesehitus-ja-nouded.md)
- [ ] Olemasolevate skillide tutvustus
- [ ] [Oma skilli loomine](materjalid/oma-skilli-loomine.md)

## Projekti tutvustus
- [ ] [Projekti idee](materjalid/projekti-idee.md)
- [ ] [Mock veebileht (Balsamiq)](materjalid/mock-veebileht-balsamiq.md)
- [ ] [Jira taskid](materjalid/jira-taskid.md)
- [ ] [PDF taskid](materjalid/pdf-taskid.md)
- [ ] [Andmebaasi mudel](materjalid/andmebaasi-mudel.md)
- [ ] [`openAPI.json`](materjalid/openapi-json.md)


## MCP

- [ ] [Mis on MCP](materjalid/mis-on-mcp.md)
- [ ] [`/mcp`](materjalid/mcp.md)
- [ ] [Näide Claude Code'i ühendamisest välise tööriista või teenusega](materjalid/mcp-uhendamise-naide.md)
- [ ] [MCP serveri eemaldamise näide](materjalid/mcp-eemaldamise-naide.md)


## PDF Taski järgi arendus
- [ ] [FEB-4 ja FEB-5](materjalid/pdf-taski-jargi-arendus.md) (commit)
- [ ] [`/rewind`](materjalid/rewind.md)

## Taskist .md fail
- [ ] [Teeme PDF to .md skilli (esialgu Notepadis)](materjalid/pdf-to-md-skill.md)
- [ ] FEB-7 - Login koos rolliga (commit)
- [ ] BEB-5 - Login koos rolliga (commit)
- [ ] BEB-5 skill-grill-me demo (lühidalt)

## Taskist implementatsiooni plaan
- [ ] [Teeme mitmest .md failist implementatsiooniplaani skilli (esialgu Notepadis)](materjalid/md-failidest-implementatsiooni-plaan.md)
- [ ] FEB-7
- [ ] BEB-5
- [ ] commit

## Taski implementatsioon
- [ ] [Implementeerime lahenduse](materjalid/implementeerime-lahenduse.md)
- [ ] NB! ÄRA TEE commiti

## Valminud töö ülevaatus
- [ ] [`/simplify`](materjalid/simplify.md)
- [ ] [`/security-review`](materjalid/security-review.md)
- [ ] [`/code-review`](materjalid/code-review.md)
- [ ] commit


## Teeme taski + implementatsioon (Mock REST + openAPI.json kontroll) -> notepadis
- [ ] [STEP-6 (Pangautomaadid, tabel)-KÕIK](materjalid/step-6-pangaautomaatide-tabel.md)
- [ ] commit

## /plan mode (Mock basic + openAPI.json)
- [ ] [Teeme esialgse plaani Notepadis](materjalid/step-7-asukoha-lisamise-plaan.md)
- [ ] STEP-7 (Askoha lisamine - tühi)
- [ ] STEP-7 (Askoha lisamine) komponentide raamid
- [ ] STEP-7 (Askoha lisamine) success message


## Single prompt + openAPI.json
- [ ] [Vaade `/atms`: asukoha nimi hüperlingiks](materjalid/atms-asukoha-link.md)
- [ ] vaata referensiks üle vaated STEP-9 (Pangaautomaadid, view link) ja STEP-10-Mustamäe (view)


## Tagasiside

- [ ] [Palun jätke tagasiside](materjalid/tagasiside.md)
