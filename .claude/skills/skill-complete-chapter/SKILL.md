---
name: skill-complete-chapter
description: Märgi faili docs/oppekava/check-list.md ühe peatüki kõik checkboxid tehtuks. Kasuta, kui kasutaja ütleb näiteks „märgi peatükk tehtuks“, „lõpeta peatükk“, „täida peatüki checkboxid“, „peatükk on läbitud“ või soovib checklisti konkreetse peatüki lõpetatuks märkida.
---

# Complete Chapter

Küsi kasutajalt, millise peatüki checkboxid tuleb tehtuks märkida.

Näide:

```text
Millise peatüki märgin tehtuks? Näiteks „Enne töötoa algust“.
```

Oota kasutaja vastus ära ja järgi seejärel samme.

## Sammud

1. Loe fail `docs/oppekava/check-list.md`.
2. Leia kasutaja antud nimele vastav `##` peatükk.
3. Peatüki ulatus algab selle pealkirja alt ja lõpeb järgmise `##` pealkirja ees või faili
   lõpus.
4. Muuda ainult leitud peatüki märkimata checkboxid:

   ```text
   - [ ] → - [x]
   ```

5. Ära muuda teiste peatükkide checkboxe ega muud teksti.
6. Teata kasutajale peatüki nimi ja mitu checkboxi märgiti tehtuks.

Kui täpset peatükki ei leidu või mitu peatükki võivad sobida, näita sobivaid pealkirju ja
küsi kasutajalt täpsustust. Kui kõik peatüki checkboxid on juba märgitud, ära faili muuda
ning teata, et peatükk oli juba tehtud.
