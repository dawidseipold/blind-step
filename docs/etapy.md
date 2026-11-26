# Etapy rozwoju Blind Step

Każde issue przypisujemy do jednego kamienia milowego na GitHubie. Nowy etap zaczynamy, gdy jego poprzednik przeszedł próbę w grze. Terminy ustalimy po pierwszych playtestach.

| Etap | Zakres | Warunek przejścia |
|---|---|---|
| M0 · Projekt i warsztat | #1, #2, #17, #20, #22 | F5 uruchamia scenę główną z czystej kopii repozytorium, a zadanie można przekazać kolejnemu agentowi. |
| M1 · Podstawy gracza | #3, #4, #5, #6, #7, #8, #9, #10, #26, #27, #30, #32, #33, #37 | Na bryłach można przejść pod stropem, wyczerpać kondycję i zapas zapałek oraz odnaleźć drogę po zgaśnięciu źródła. Kamera i audio mają wersję testową. |
| M2 · Percepcja istoty | #11, #12, #13 | W tym samym układzie korytarza można powtórzyć test hałasu, widocznego światła i osłony za ścianą. |
| M3 · Próba pętli survivalowej | #15, #28 | Dwa przejścia tej samej trasy ujawniają koszt użycia światła i strzału. Po obserwacji wybieramy pętlę albo kolejny eksperyment. |
| M4 · Wykończenie | #14, #16, #19, #29 | Po wyborze pętli porównujemy kadr wzorcowy, płynność w ruchu i odsłuch podłoży. Właściciel akceptuje wygląd oraz brzmienie. |

## Kolejność pracy

W M1 pracujemy w trzech blokach. Każdy zaczyna się od osobnej próby na stanowisku ruchu Bench lub na trasie świetlnej LightCourse.

1. **Mechaniki.** Chód, kucanie, sprint, kondycja i płynne przyspieszanie oraz hamowanie (#26). Szybszy sprint, rezerwę i ślizg (#32, #33) testujemy jako jeden manewr ucieczki. Na trasie świetlnej (#37) testujemy zapałki (#6), widoczność w cieniu i za osłoną (#53). Odczyty F3 pokazują stan bez angażowania kamery i dźwięku.
2. **Kamera.** Najpierw bazowy profil fisheye (#8) na nieruchomym ujęciu oraz podczas przejścia. Na zatwierdzonym profilu sprawdzamy niezależnie płynne obniżanie oczu (#27), zmianę FOV podczas sprintu (#30) oraz czytelność krawędzi po zgaśnięciu obu źródeł. Kołysanie pozostaje próbą wykończeniową po diagnostyce smużenia.
3. **Audio.** Próby audio czekają na zakończenie testów światła i skradania. Dźwięki podłoży i roślin pozostają w M4.

W M2 budujemy korytarz na bryłach i dodajemy pojedyncze reakcje istoty. M3 sprawdza, czy te reakcje tworzą decyzje warte powtarzania. Po każdej próbie zapisz w issue wybór testera, powód i zmianę do kolejnego przejścia. Lokację fabularną wybierzemy po tej decyzji.

Tekstury, dopracowanie shaderów, ruchu kamery i brzmień trafiają do M4. Jeśli usterka uniemożliwia wiarygodny test bieżącej mechaniki, opisz blokowaną próbę i przenieś issue do aktywnego etapu. Smużenie podczas chodu (#19) pozostaje w kolejce wykończenia; do diagnozy zachowujemy surową scenę Bench.

Stres (#28) testujemy w M3 dopiero przy działającej pogoni. Porównujemy sprint w pustej sali z pozostaniem w miejscu podczas zagrożenia. Wysiłek i stres mają oddzielne odczyty. Kołysanie kamery (#29) czeka na zakończenie próby smużenia w M4: najpierw zapisujemy przejazd referencyjny, potem porównujemy z ruchem bocznym i pionowym przy tej samej prędkości.
