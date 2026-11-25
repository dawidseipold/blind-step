# Etapy rozwoju Blind Step

Każde issue przypisujemy do jednego kamienia milowego na GitHubie. Nowy etap zaczynamy, gdy jego poprzednik przeszedł próbę w grze. Terminy ustalimy po pierwszych playtestach.

| Etap | Zakres | Warunek przejścia |
|---|---|---|
| M0 · Projekt i warsztat | #1, #2, #17, #20, #22 | F5 uruchamia Bench z czystej kopii repozytorium, a zadanie można przekazać kolejnemu agentowi. |
| M1 · Podstawy gracza | #3, #4, #5, #6, #7, #8, #9, #10 | Na bryłach można przejść pod stropem, wyczerpać kondycję i baterię oraz odnaleźć drogę po zgaśnięciu impulsu. Kamera i audio mają wersję testową. |
| M2 · Percepcja istoty | #11, #12, #13 | W tym samym układzie korytarza można powtórzyć test hałasu, widocznego impulsu i osłony za ścianą. |
| M3 · Próba pętli survivalowej | #15 | Dwa przejścia tej samej trasy ujawniają koszt użycia światła i strzału. Po obserwacji wybieramy pętlę albo kolejny eksperyment. |
| M4 · Wykończenie | #14, #16, #19 | Po wyborze pętli porównujemy kadr wzorcowy, płynność w ruchu i odsłuch podłoży. Właściciel akceptuje wygląd oraz brzmienie. |

## Kolejność pracy

W M1 po chodzie testujemy kucanie, następnie sprint z regeneracją. Potem dochodzi sam impuls latarki i osobno koszt baterii. Optykę oraz dźwięk oceniamy w tej fazie tylko pod względem orientacji i informacji potrzebnej graczowi. Jeden test kończy się jednym obserwowalnym wynikiem.

W M2 budujemy korytarz na bryłach i dodajemy pojedyncze reakcje istoty. M3 sprawdza, czy te reakcje tworzą decyzje warte powtarzania. Po każdej próbie zapisz w issue wybór testera, powód i zmianę do kolejnego przejścia. Lokację fabularną wybierzemy po tej decyzji.

Tekstury, dopracowanie shaderów, ruchu kamery i brzmień trafiają do M4. Jeśli usterka uniemożliwia wiarygodny test bieżącej mechaniki, opisz blokowaną próbę i przenieś issue do aktywnego etapu. Smużenie podczas chodu (#19) pozostaje w kolejce wykończenia; do diagnozy zachowujemy surową scenę Bench.
