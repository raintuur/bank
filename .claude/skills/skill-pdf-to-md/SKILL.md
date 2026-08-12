---
name: skill-pdf-to-md
description: Muuda Jira PDF-taski fail selgeks Markdown-failiks. Kasuta, kui kasutaja soovib PDF-taski Markdowniks teisendada, mainib "PDF to md" või annab ette PDF-taski faili raja.
---

# PDF to MD

Küsi kasutajalt PDF-taski faili rada, kui see pole juba antud.

Näide:

```text
Millise PDF-taski faili teisendan? Näiteks: docs/tasks/frontend/[FEB-4] Muuda kodu vaadet - Jira.pdf
```

Oota kasutaja vastus ära (kui rada polnud juba antud) ja järgi seejärel samme.

## Sammud

1. Loe antud PDF-fail.
2. Leia sellest taski pealkiri, kirjeldus, nõuded/vastuvõtukriteeriumid ja muu oluline
   tehniline info (nt API päringud, koodinäited, tabelid).
3. Tuvasta task'i ID failinimest (nt `[FEB-4] Muuda kodu vaadet - Jira.pdf` → `FEB-4`).
4. Loo sama kausta, kus PDF asub, uus fail nimega `<task-ID>.md` (nt `FEB-4.md`).
5. Kirjuta faili taski sisu selge struktuurina:
   - `#` pealkirjaks taski ID ja pealkiri;
   - kirjeldus ja nõuded punktidena või lõikudena, nii nagu PDF-is;
   - vastuvõtukriteeriumid, kui neid taskis eraldi välja on toodud;
   - tehniline info (päringud, koodinäited, tabelid) originaalkujul säilitatuna.
6. Ära lisa taski sisusse omapoolseid tõlgendusi ega täiendusi — kanna üle ainult see, mis
   PDF-is olemas on.
7. Teata kasutajale loodud faili rada ja lühike kokkuvõte, mis taskiga tegu oli.

Kui antud PDF-faili ei leidu, teata sellest kasutajale ja küsi õiget rada.
