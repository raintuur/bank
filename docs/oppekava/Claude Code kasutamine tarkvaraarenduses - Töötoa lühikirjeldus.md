# Töötuba: Claude Code kasutamine tarkvaraarenduses

## Eesmärk

Töötoa eesmärk on anda osalejale praktiline kogemus Claude Code tööriista kasutamisest
tarkvaraarenduses. Töötoa käigus tutvub osaleja olemasolevas, spetsiaalselt töötoa jaoks
ette valmistatud rakenduses Claude Code peamiste võimalustega ning õpib, kuidas
tööriista abil projekti tegemisele süsteemselt läheneda.

Töötoa fookus ei ole koodil ega koodikvaliteedil, vaid Claude Code võimalustel ning
metoodikal: kuidas tööriista kasutada, milliseid töövõtteid rakendada ja kuidas üles
ehitada oma töövoog projektiga töötamiseks.

## Sisu

Töötoa lähtepunktiks on Vali-IT projektist pärit pangaautomaatide asukoha fullstack
rakendus (Vue.js, Java, Spring Boot). Olemasoleva ja läbiviijale tuttava projekti
kasutamine vähendab ettevalmistusriski ning võimaldab keskenduda Claude Code
võimaluste õpetamisele. Rakendusega on juba kaasas töötav build, järjestikused
taskid, PostgreSQL-i andmebaasimudel ja seadistusskriptid, OpenAPI teenuste kontrakt,
JSON näidised, mock-pildid ning valmis näidis-skillid.

Backend kasutab lokaalset PostgreSQL-i ja `vali_it` andmebaasi vastavalt projekti
`application.properties` seadistusele. Vajalik andmebaas ja arenduskeskkond on
töötoa eeltingimused ning valmistatakse osalejate arvutites ette enne töötuba.

Praktiline töö toimub samm-sammult, väikese arvu kumulatiivsete ülesannete kaupa.
Ülesanded ehitavad üksteise peale ja annavad töötava vahetulemuse. Ülesanded
tutvustavad Claude Code erinevaid võimalusi: projekti konteksti seadistamist,
plaanipõhist lähenemist enne koodi kirjutamist, turvalist katsetamist ja
tagasikerimist, korduvkasutatava töövõtte loomist ning valminud töö ülevaatust
tööriista enda abiga.

Osalejad liiguvad läbi töötoa promptimise osas järk-järgult vähema toe suunas.
Alguses kasutatakse täisvalmis, ettevalmistatud prompte, keskel kohandatakse
poolikuid näidisprompte ning töötoa lõpus koostab osaleja prompti juba täiesti
iseseisvalt. See tagab, et osaleja ei jää ainult "nuppu vajutama", vaid õpib ka ise
Claude Code'iga suhtlema.

Kõik osalejad töötavad samas repos, igaüks oma Git-harus. Töötoa läbiviija töötab
paralleelselt samas projektis ja teeb pidevalt commite oma harusse, mistõttu saab
osaleja soovi korral kiirelt "järgi tulla", jätkates läbiviija harult. Osaleja
varasem töö ei kao, vaid jääb alles eraldi harus ja on hiljem, pärast töötuba,
uuesti vaadatav.

Lisaks tutvustatakse osalejale võimalust ühendada Claude Code väliste tööriistade
ja teenustega MCP protokolli kaudu, mis avardab tööriista kasutusala kaugemale
otsesest koodiga töötamisest.

## Ülesehitus

Töötoa kestvus on 4 akadeemilist tundi.

Töötuba toimub füüsilises või veebipõhises vormis ning selle metoodiline kese on
juhendatud praktiline töö: lühike sissejuhatus iga uue Claude Code võimaluse kohta,
millele järgneb kohene iseseisev katsetamine samas projektis. Töötoa rõhuasetus on
tööriista võimaluste ja praktilise lähenemisviisi tundmaõppimisel, mitte teoreetilisel
loengul.

## Õpitulemid

Töötoa läbimise tulemusel oskab osaleja kasutada Claude Code peamisi võimalusi
olemasoleva rakendusega töötamisel: projekti konteksti seadistamist, plaanipõhist
lähenemist enne muudatuste tegemist, tehtud töö turvalist tagasikerimist, enda
korduvkasutatava töövõtte loomist ning valminud töö ülevaatust tööriista enda abiga.

Osaleja mõistab, kuidas Claude Code'iga suhelda promptide kaudu, nii etteantud
prompte kohandades kui ka neid täiesti iseseisvalt koostades, ning oskab hinnata,
millist Claude Code võimalust millise ülesande jaoks kasutada.

Osaleja teab, mis on MCP ja oskab tuua näiteid, kuidas see Claude Code kasutusala
väliste tööriistade ja teenustega laiendab.

## Praktiline väljund

Töötoa lõpuks on iga osaleja läbinud rea kumulatiivseid praktilisi ülesandeid
ettevalmistatud rakenduses, kasutades Claude Code peamisi võimalusi otsast lõpuni,
alates projekti kontekstiga tutvumisest kuni oma töövõtte loomise ja valminud töö
ülevaatuseni. Osaleja lahkub töötoast praktilise kogemusega, mida saab kohe rakendada
oma igapäevases arendustöös.

## Eeltingimused

Töötoas täisväärtuslikuks osalemiseks on osalejal vaja Claude Code subscriptionit
(kuupõhine tasu) või API key olemasolu (tasu tokeni kasutuse pealt). Ilma selleta
saab osaleja küll kaasa vaadata, aga sellisel osalemisel poleks praktilist väärtust.

Osalejal peab töötoa alguseks olema arvutis vajalik tarkvara ja seadistused juba
tehtud, sealhulgas töötav lokaalne PostgreSQL-i server ning `vali_it` andmebaas
vastavalt projekti `backend/src/main/resources/application.properties` seadistusele.
Osalejal peab olema ka GitHubi konto, kuna kõik osalejad töötavad ühises repos.

Vajalikud juhendid tarkvara installimiseks ja seadistamiseks saadetakse osalejatele
enne töötuba.
