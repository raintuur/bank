# `/permissions`

Käivita:

```text
/permissions
```

Siin saad vaadata ja muuta, mida Claude Code tohib teha.

- **Allow** — tegevus on lubatud ilma kinnitust küsimata.
- **Ask** — Claude küsib enne tegevust kinnitust.
- **Deny** — tegevus on keelatud.

Näiteks võib lubada testide käivitamise, kuid keelata `git push` käsu.

```text
Allow: Bash(./gradlew test)
Deny:  Bash(git push *)
```

Keelav reegel on alati lubavast reeglist tugevam. Anna Claude'ile ainult ülesande jaoks vajalikud õigused.

Kui Claude küsib käsu käivitamiseks luba ja valid **Yes, don't ask again**, salvestatakse vastav käsureegel projekti jaoks. Failimuudatuste luba võib kehtida ainult sessiooni lõpuni.

Reeglid võivad asuda:

- `.claude/settings.local.json` — sinule selles projektis;
- `.claude/settings.json` — kogu meeskonnale;
- `~/.claude/settings.json` — sinule kõikides projektides.

`/permissions` näitab, millisest failist iga reegel pärineb.

## Demo

Palu Claude'il käivitada:

```text
git fetch origin
```

Vali **Yes, don't ask again**, ava `/permissions` ja vaata lisatud reeglit. Käivita sama käsk uuesti — Claude ei peaks enam luba küsima.
