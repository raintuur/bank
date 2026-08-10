---
name: skill-catch-up-teacher
description: Õpilase poolelioleva töö commit'imine ja uue versiooniga haru loomine õpetaja haru värske seisu pealt. Kasuta, kui kasutaja ütleb „võta õpetajale järgi“ või soovib õpetaja koodiga samalt tasemelt jätkata.
disable-model-invocation: false
---

# Catch Up Teacher

Salvesta õpilase pooleliolev töö commit'ina ja loo õpetaja remote-haru pealt uus versiooniga haru. Ära tee push'i.

Tegutse võimalikult kiiresti ja jätka küsimusteta, kui harud on üheselt tuvastatavad. Küsi kasutajalt ainult siis, kui sobivat õpetaja haru ei leita, sobivaid harusid on mitu või mõni Git-käsk ebaõnnestub.

## Sammud

### 1. Tuvasta hetke haru ja salvesta nimi
- Käivita `git branch --show-current` — see on õpilase arenduse haru (nt `MARI-FEB-7`, `JUKU-BEB-7-v2`, `mari` või `mari-v2`).
- Kui käsk ei tagasta haru nime, peata flow ja teata, et repository on detached HEAD seisus.
- Salvesta see nimi — hiljem on vaja uue haru nimetamiseks.
- Kontrolli, kas harunimes on Jira/task'i numbri liide (nt `FEB-7` või `BEB-7`).
  - Kui liide on olemas, kasuta seda sobiva õpetaja haru otsimiseks.
  - Kui liidet pole, kasuta lihtsat nimepõhist stsenaariumi: õpilaste harud on nende nimedega ja õpetaja haru on `opetaja`.

### 2. Salvesta pooleliolev töö commit'ina
- Käivita `git status --short`.
- Kui muudatusi pole, jäta commit vahele ja jätka kohe fetch'iga.
- Kui muudatusi on:
  1. Käivita `git add -A`, et lisada commit'i jälgitud ja uued failid.
  2. Käivita `git commit -m "catch up teacher"`.
  3. Kui commit ebaõnnestub, peata flow ja näita kasutajale veateadet.
- Ära tee push'i. Checkpoint-commit peab jääma ainult õpilase vanale kohalikule harule.

### 3. Fetch
- Käivita `git fetch origin`, et värskendada õpetaja remote-haru infot.
- Kui fetch ebaõnnestub, peata flow ja näita kasutajale veateadet.

### 4. Otsi õpetaja remote arenduse haru
- Käivita `git branch -r` ja otsi õpetaja remote-haru ühe järgneva stsenaariumi järgi:
  - **Task'i numbriga:** leia `origin/OPETAJA-*` haru, mille Jira/task'i number klapib õpilase haruga (nt õpilane `MARI-FEB-7` → õpetaja `origin/OPETAJA-FEB-7`).
  - **Task'i numbrita:** kui õpilase haru on ainult nimi või nime versioon (nt `mari` või `mari-v2`), kasuta õpetaja haru `origin/opetaja`.
- **Kui leiad täpselt ühe sobiva haru** — jätka automaatselt.
- **Kui leiad mitu sobivat haru** — küsi kasutajalt, millist haru ta soovib kasutada, ja oota vastust.
- **Kui ei leia ühtegi sobivat haru** — teavita kasutajat ja küsi, mida teha.

### 5. Loo uus haru õpetaja harult
- Määra uue haru nimi: võta õpilase vana haru nimi ja lisa või suurenda lõpus olevat versiooni numbrit.
  - Kui vanal harunimel pole versiooni numbrit (nt `MARI-FEB-7`) → uus nimi on `MARI-FEB-7-v2`
  - Kui vanal harunimel on versiooni number (nt `MARI-FEB-7-v2`) → suurenda numbrit (nt `MARI-FEB-7-v3`)
  - Sama loogika kehtib task'i numbrita harudele: `mari` → `mari-v2` ja `mari-v2` → `mari-v3`.
- Kontrolli nii kohalikke kui ka `origin` remote-harusid. Kui arvutatud nimi on juba olemas, suurenda versiooni seni, kuni leiad vaba nime.
- Käivita `git switch -c <uus-haru-nimi> --track origin/<opetaja-haru-nimi>`.
- Ära kopeeri vana haru commit'e uude harusse: uus haru peab algama otse õpetaja remote-haru värske seisu pealt.
- Ära tee push'i.

### 6. Kokkuvõte
- Teata kasutajale lühidalt:
  - vana haru nimi;
  - kas checkpoint-commit loodi ja selle commit hash või et muudatusi polnud;
  - kasutatud õpetaja remote-haru;
  - uus aktiivne haru;
  - push'i ei tehtud.
