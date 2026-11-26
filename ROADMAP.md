# Backlog prototypu

[Plan etapów i kryteria przejścia](docs/etapy.md). Każdy wiersz odpowiada jednemu issue. Identyfikatory Txx służą do powiązania z GitHubem po publikacji. W issue zachowuj numer zadania zależnego. Każdy test zaczyna się z tego samego miejsca.

| ID | Zadanie | Po | Odbiór |
|---|---|---|---|
| T00 | Git Flow, autorstwo i zasady prototypu | — | Oba typy agentów mają wspólne reguły, wskazaną gałąź docelową i instrukcję przekazania. |
| T01 | Plansza z brył | — | Bench otwiera się jako scena główna. Stanowiska do biegu, kucania i badania wiązki mają kolizję. |
| T02 | Chód i obrót myszy | T01 | Gracz przechodzi prostą i zatrzymuje się przy ścianie. Ruch po skosie zachowuje prędkość. |
| T03 | Kucanie | T02 | Gracz przechodzi pod niskim stropem i może wstać dopiero po wyjściu. |
| T04 | Sprint i kondycja | T02 | Sprint wyczerpuje zapas, który wraca po odpoczynku. |
| T05 | Zapałki w domu | T02 | Każde zapalenie zużywa sztukę. F gasi płomień, który może też wypalić się sam. |
| T06 | Wymienne ogniwa latarki plenerowej | T05 | Bateria ubywa podczas świecenia. R wymienia ogniwo z zapasu. |
| T07 | Optyka bodycam | T02 | Z jednego miejsca porównano dwa ustawienia dystorsji i stabilność środka przy obrocie. |
| T08 | Pamięć oświetlonych powierzchni | T05, T06 | Zapałka pozostawia słabszy i krótszy ślad, latarka mocniejszy i dłuższy. Przeszkoda osłania powierzchnię. |
| T09 | Proceduralne audio bazowe | blok audio po mechanikach i kamerze; T04, T06 | Oddech narasta podczas sprintu i cichnie podczas regeneracji. Po wyczerpaniu baterii słychać klik. |
| T10 | Korytarz i trzy pokoje | odbiór T02–T09 | Dwie trasy oraz narożnik umożliwiają powtórzenie próby percepcji. |
| T11 | Słuch istoty | T10 | Sprint przyciąga z większej odległości niż skradanie, także przy ściszonym masterze. |
| T12 | Dwie reakcje na światło | T10, T06 | Jeden profil istoty cofa się, drugi bada światło. Pełna ściana osłania cel. |
| T13 | Podłoża i krzaki | po akceptacji podstaw | W ślepej próbie tester rozróżnia dwa rodzaje kroków i wejście w krzaki. |
| T14 | Próba wyboru trasy i pojedynczego strzału | T11, T12 | Tester porównuje przejście z ograniczoną baterią i wariant z możliwością odstraszenia strzałem. |
| T15 | Pierwsza próbka wykończenia | po akceptacji mechanik | Jedno ujęcie wyznacza paletę, tekstury i skalę detalu. |
| T16 | Uruchomić lookup API na komputerze projektu | T00 | Zapytania o move_and_slide i screen_relative zwracają wpisy dla wersji gry. |
| T17 | Zdiagnozować smużenie krawędzi podczas chodzenia | T02, etap M4 | Bench: przy nieruchomej myszy idź A/D obok pionowej krawędzi i powtórz z W/S. Próba kontrolna: obracaj samą myszą w miejscu (według gracza brak efektu). Zapisz FPS, częstotliwość monitora, takt fizyki i krótki klip. Porównaj identyczny ruch przy interpolacji fizyki wyłączonej i włączonej, również przy FPS wyższym od taktu fizyki. Oceń równomierność przesunięć i ewentualny ślad w kolejnych klatkach. Jeśli ślad występuje tylko na ekranie, porównaj ustawienia overdrive. Odbiór: powtarzalna próba A/B i wskazanie źródła w surowej scenie Bench. |
| T18 | Ujednolicić etykiety wszystkich issues | T00 | Każde issue ma obszar, priorytet, stan i rodzaj w formacie typ:wartość. |
| T19 | Nazwa Blind Step i etapy rozwoju | T00 | Projekt ma spójną nazwę, a każde issue ma przypisany etap. |
| T20 | Przyspieszanie i hamowanie | T04 | Prędkość narasta i opada płynnie, tester zatrzymuje się przed przesłoną. |
| T21 | Płynna zmiana wysokości oczu | T03, T07 | Po puszczeniu Ctrl pod stropem głowa zostaje nisko. Po wyjściu kamera płynnie wraca. |
| T22 | Próba stresu podczas pogoni | T11, T12 | Sama pogoń podnosi stres nieruchomej postaci. Sam sprint w pustej sali podnosi zmęczenie. |
| T23 | Kołysanie bodycam przy biegu | T17, T20 | Przy amplitudzie zero wraca kadr kontrolny. Kołysanie boczne i pionowe wygasa po zatrzymaniu. |
| T24 | Poszerzenie pola widzenia podczas sprintu | T07, T20 | Pole widzenia płynnie rośnie w biegu i wraca podczas chodu lub kucania; sam Shift w miejscu zachowuje kadr. |
| T25 | Szybszy sprint i rezerwa | T20 | Końcówka biegu trwa dłużej, po jej wykorzystaniu regeneracja rusza później, status znika po odczekaniu. |
| T26 | Ślizg do niskiej osłony | T03, T25 | Ctrl podczas rozpędzonego biegu wprowadza postać pod niski strop, a z marszu powoduje kucanie. |
| T27 | Szkic fabularny | projekt narracji | Zarys przyjazdu, odkrycia, ucieczki i zakończeń ma osobny dokument z otwartymi decyzjami. |
| T28 | Trasa świetlna | T01 | Ciemny korytarz, boczne wnęki i przeszkody prowadzą na dziedziniec z latarką. |
