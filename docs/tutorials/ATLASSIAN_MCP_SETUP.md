# Claude Code + Jira / Confluence via Atlassian Rovo MCP

See juhend seadistab **Claude Code'i** kasutama Atlassiani ametlikku **Rovo MCP Serverit**, et Claude saaks terminalist lugeda Jira task'e ja Confluence'i sisu.

> Soovitus: alusta read-only töövoost. Luba Jira muutmine, kommentaaride lisamine või staatuse muutmine ainult siis, kui sa seda Claude'ilt eksplitsiitselt küsid.

## Eeldused

Sul peaks olema:

- Atlassian Cloud konto ja ligipääs Jira projektile;
- Claude Code paigaldatud ja sisse logitud;
- brauser, milles saad Atlassiani OAuth autentimise lõpule viia.

Atlassiani Rovo MCP kasutab interaktiivse kasutaja puhul OAuth 2.1 autentimist. Sa ei pea enne brauseris Atlassiani sisse logitud olema — OAuth flow küsib vajadusel sisselogimist.

## 1. Lisa Atlassian MCP Claude Code'i

Repo juurkaustas või suvalises terminalis käivita:

```bash
claude mcp add --transport http atlassian \
  https://mcp.atlassian.com/v1/mcp/authv2
```

Seejärel kontrolli, kas MCP on lisatud:

```bash
claude mcp list
```

Kui kasutad Claude Code'i interaktiivses režiimis:

```bash
claude
```

ja seejärel Claude Code'i sees:

```text
/mcp
```

Sealt peaksid nägema `atlassian` MCP serverit.

## 2. Tee OAuth autentimine

Kui Claude Code proovib Atlassiani MCP-ga ühenduda, käivitub OAuth flow.

Tavaliselt toimub see nii:

1. Claude Code avab või pakub Atlassiani authorization URL-i.
2. Brauseris logid Atlassiani sisse, kui sa pole juba sisse logitud.
3. Kinnitad MCP ligipääsu.
4. Valid vajadusel Atlassian Cloud site'i, mille Jira/Confluence andmeid soovid kasutada.
5. Pärast edukat autoriseerimist saab Claude Code OAuth tokeni ja MCP ühendus aktiveerub.

Kontrolli uuesti:

```text
/mcp
```

Kui ühenduse juures on autentimise või ühenduse viga, vaata terminali veateadet ja kontrolli, kas sinu Atlassian kasutajal on vastavale Jira projektile ligipääs.

## 2.1. Logi Atlassian MCP-st välja

Atlassiani MCP ühendusest väljalogimiseks ei ole vaja Claude Code'i kontolt välja logida ega MCP serverit konfiguratsioonist eemaldada.

1. Ava Claude Code'i interaktiivne režiim:

```bash
claude
```

2. Ava MCP ühenduste menüü:

```text
/mcp
```

3. Vali nimekirjast `atlassian`.
4. Vali **Clear authentication** ja kinnita valik.
5. Ava `/mcp` uuesti ning kontrolli, et Atlassiani ühendus nõuab autentimist.

See eemaldab Claude Code'i salvestatud Atlassiani OAuth autentimise. MCP serveri seadistus jääb alles, mistõttu ei pea käsku `claude mcp add` uuesti käivitama.

> Claude Code'i käsk `/logout` logib välja Claude Code'i enda kasutajakontolt. Atlassiani MCP konto vahetamiseks kasuta `/mcp` menüü valikut **Clear authentication**.

## 2.2. Logi Atlassian MCP-sse uuesti sisse

1. Käivita Claude Code ja ava:

```text
/mcp
```

2. Vali `atlassian` ning alusta autentimist.
3. Ava Claude Code'i pakutud authorization URL brauseris. Kui brauser ei avane automaatselt, kopeeri URL ja ava see käsitsi.
4. Logi soovitud Atlassiani kontoga sisse, kinnita ligipääs ja vali õige Atlassian Cloud site.
5. Naase Claude Code'i ning kontrolli `/mcp` menüüst, et ühendus on aktiivne.
6. Kontrolli kasutajat ja ligipääsu read-only päringuga, näiteks:

```text
Which Atlassian user am I authenticated as, and which Atlassian sites can I access?
Do not modify anything.
```

Kui Atlassian logib brauseris automaatselt eelmise kontoga sisse, logi Atlassianist brauseris välja või korda autentimist privaatses brauseriaknas.

## 3. Esimene test Jira taskiga

Claude Code'is proovi näiteks:

```text
Find my Jira issues that are currently in progress.
```

Või konkreetse issue võtmega:

```text
Read Jira issue PROJ-123 and summarize:
- description
- status
- acceptance criteria
- relevant comments

Do not modify the Jira issue.
```

Asenda `PROJ-123` päris Jira issue key'ga.

## 4. Kasuta Jira taski koos kohaliku repoga

Kõige kasulikum workflow on see, kus Claude loeb Jira taski ja võrdleb seda kohe repo koodiga.

Näiteks:

```text
Read Jira issue PROJ-123.

Then inspect this repository and explain:
1. what the task requires,
2. which files are probably affected,
3. what implementation approach you recommend,
4. what tests should be added or changed.

Do not modify files yet.
```

Kui plaan tundub õige:

```text
Implement PROJ-123 according to the Jira description and acceptance criteria.

Run the relevant tests after making the changes.
Do not change the Jira issue itself.
```

## 5. Soovituslik CLAUDE.md konfiguratsioon

Lisa repo juurkausta `CLAUDE.md` faili järgmine osa või ühenda see olemasoleva failiga:

```markdown
## Jira workflow

When a Jira issue key such as `PROJ-123` is mentioned:

1. Fetch the Jira issue using the Atlassian MCP server.
2. Read the description, acceptance criteria, status, and relevant comments.
3. Treat the Jira issue as the primary source of truth for task requirements.
4. Inspect the existing repository before proposing or making changes.
5. Prefer existing project conventions and patterns over introducing new ones.
6. If Jira requirements conflict with the existing code or documentation, point out the conflict before proceeding.
7. Do not modify Jira issues, add comments, change status, or create new issues unless explicitly requested.
8. Before implementation, summarize the intended changes when the task is non-trivial.
9. After implementation, run relevant tests and summarize what changed.
```

See võimaldab sul hiljem kasutada palju lühemat käsku:

```text
Work on PROJ-123.
```

või:

```text
Implement PROJ-123.
```

## 6. Kasulikud promptid

### Taski analüüs ilma koodi muutmata

```text
Analyze PROJ-123 against this repository.
Do not modify anything.
Tell me what needs to change and identify any unclear requirements.
```

### Implementatsioon

```text
Implement PROJ-123.
Use the Jira acceptance criteria as the definition of done.
Run relevant tests afterwards.
Do not update Jira.
```

### Jira taski ja olemasoleva koodi võrdlus

```text
Read PROJ-123 and inspect the current implementation.
Tell me which parts of the Jira task are already implemented and which are missing.
```

### Bug task

```text
Read PROJ-123.
Reproduce or identify the likely cause of the bug in this repository.
Explain the root cause before changing code.
```

### PR ettevalmistus

```text
Read PROJ-123 and review my current git diff.
Check whether the implementation satisfies the Jira acceptance criteria.
List anything missing before I create a PR.
```

## 7. Confluence'i kasutamine

Sama Atlassian MCP ühenduse kaudu saab Claude kasutada ka Confluence'i, kui sinu Atlassian kasutajal on vastavale sisule ligipääs.

Näiteks:

```text
Read PROJ-123 and find relevant Confluence documentation for this feature.
Use both sources to explain the expected behavior.
```

Või:

```text
Find the Confluence technical specification related to PROJ-123.
Compare it with the Jira acceptance criteria and highlight inconsistencies.
```

## 8. Jira muutmine

Rovo MCP võib sõltuvalt sinu õigustest toetada ka write-operatsioone.

Näiteks võib Claude olla võimeline:

- lisama Jira kommentaari;
- muutma issue välju;
- muutma staatust;
- looma uusi Jira issue'sid.

Soovitatav reegel repos on siiski:

```text
Never modify Jira unless explicitly requested by the user.
```

Kui soovid hiljem teadlikult kommentaari lisada, tee see eraldi käsuna:

```text
Add a comment to PROJ-123 summarizing the implementation I just completed.
Show me the proposed comment before posting it.
```

## 9. Troubleshooting

### MCP serverit ei kuvata

Kontrolli:

```bash
claude mcp list
```

Kui Atlassiani pole nimekirjas, lisa see uuesti:

```bash
claude mcp add --transport http atlassian \
  https://mcp.atlassian.com/v1/mcp/authv2
```

### OAuth ei avane või autentimine ebaõnnestub

Claude Code'i sees ava:

```text
/mcp
```

ja proovi Atlassiani ühendus uuesti autentida.

Kontrolli ka:

- kas Atlassian Cloud site avaneb sul brauseris;
- kas sinu kasutajal on Jira projektile ligipääs;
- kas organisatsiooni Atlassian admin pole väliste AI/MCP klientide kasutamist piiranud;
- kas VPN, proxy või ettevõtte võrgureeglid ei blokeeri ühendust.

### Claude näeb Jirat, aga mitte konkreetset taski

Kontrolli kõigepealt sama kasutajaga brauseris, kas Jira issue on sulle nähtav. MCP järgib sinu Atlassiani kasutaja õigusi.

### Remote / SSH server

Kui Claude Code töötab SSH kaudu serveris, aga brauser on sinu lokaalses arvutis, võib OAuth flow sõltuda terminali ja Claude Code'i versioonist. Authorization URL-i saab üldjuhul avada lokaalses brauseris ning autentimine lõpetatakse sealt.

Kui kasutad püsivalt headless CI/bot setup'i, on interaktiivse OAuth asemel mõistlik uurida Atlassiani API-tokeni põhist MCP autentimist.

## 10. Minimaalne soovitatud workflow

Igapäevaseks kasutuseks piisab sellest:

```bash
cd my-project
claude
```

Seejärel:

```text
Work on PROJ-123.
```

Kui `CLAUDE.md` sisaldab ülaltoodud Jira reegleid, peaks Claude:

1. tõmbama Jira taski MCP kaudu;
2. lugema acceptance criteria;
3. inspekteerima repot;
4. tegema implementatsiooni;
5. jooksutama teste;
6. jätma Jira enda muutmata, kui sa pole seda eraldi palunud.

## Ametlik dokumentatsioon

- Atlassian Rovo MCP Server: https://support.atlassian.com/atlassian-rovo-mcp-server/docs/getting-started-with-the-atlassian-remote-mcp-server/
- Atlassian OAuth 2.1: https://support.atlassian.com/atlassian-rovo-mcp-server/docs/configuring-oauth-2-1/
- Claude Code MCP: https://docs.anthropic.com/en/docs/claude-code/mcp
