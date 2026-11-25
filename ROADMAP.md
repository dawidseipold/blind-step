# Backlog prototypu

Każdy wiersz jest osobnym szkicem issue. Identyfikatory Txx służą do powiązania z GitHubem po publikacji. W issue zachowuj numer zadania zależnego. Każdy test zaczyna się z tego samego miejsca.

| ID | Zadanie | Po | Odbiór |
|---|---|---|---|
| T00 | Git Flow, autorstwo i zasady prototypu | — | Oba typy agentów mają wspólne reguły, wskazaną gałąź docelową i instrukcję przekazania. |
| T01 | Plansza z brył | — | Bench otwiera się jako scena główna. Stanowiska do biegu, kucania i badania wiązki mają kolizję. |
| T02 | Chód i obrót myszy | T01 | Gracz przechodzi prostą i zatrzymuje się przy ścianie. Ruch po skosie zachowuje prędkość. |
| T03 | Kucanie | T02 | Gracz przechodzi pod niskim stropem i może wstać dopiero po wyjściu. |
| T04 | Sprint i kondycja | T02 | Sprint wyczerpuje zapas, który wraca po odpoczynku. |
| T05 | Impuls latarki | T02 | Jedno naciśnięcie rozjaśnia wnękę, snop płynnie wygasa, kolejne naciśnięcie w trakcie impulsu nie przedłuża światła. |
| T06 | Bateria | T05 | Po N impulsach latarka jest pusta. Pominięte wejścia nie zużywają zapasu. Reset odtwarza warunki próby. |
| T07 | Optyka bodycam | T02 | Z jednego miejsca porównano dwa ustawienia dystorsji i stabilność środka przy obrocie. |
| T08 | Adaptacja po impulsie | T05, T07 | Po zgaśnięciu tester odróżnia duże kształty, a ponowny impuls odsłania szczegół. |
| T09 | Proceduralne audio bazowe | T04, T06 | Odsłuch potwierdza czytelny oddech po sprincie i klik pustej latarki. |
| T10 | Korytarz i trzy pokoje | odbiór T02–T09 | Dwie trasy oraz narożnik umożliwiają powtórzenie próby percepcji. |
| T11 | Słuch istoty | T10 | Sprint przyciąga z większej odległości niż skradanie, także przy ściszonym masterze. |
| T12 | Dwie reakcje na impuls | T10, T06 | W tym samym stanowisku jeden profil istoty cofa się, drugi bada błysk. Pełna ściana osłania cel. |
| T13 | Podłoża i krzaki | po akceptacji podstaw | W ślepej próbie tester rozróżnia dwa rodzaje kroków i wejście w krzaki. |
| T14 | Próba wyboru trasy i pojedynczego strzału | T11, T12 | Tester porównuje przejście z ograniczoną baterią i wariant z możliwością odstraszenia strzałem. |
| T15 | Pierwsza próbka wykończenia | po akceptacji mechanik | Jedno ujęcie wyznacza paletę, tekstury i skalę detalu. |
| T16 | Uruchomić lookup API na komputerze projektu | T00 | Zapytania o move_and_slide i screen_relative zwracają wpisy dla wersji gry. |
| T17 | Zdiagnozować smużenie krawędzi przy obrocie myszy | T02, przed T07 | Bench: stań przed pionową krawędzią przesłony i obracaj widok na boki, najpierw w miejscu, potem idąc. Porównaj nagranie klatka po klatce z obrazem na monitorze. Zapisz FPS, częstotliwość monitora i ustawienia AA. Dla migotania konturu porównaj MSAA wyłączone i 2×; dla poziomego rozdarcia sprawdź VSync; dla śladu widocznego wyłącznie na monitorze porównaj ustawienia overdrive. Odbiór: ustalona przyczyna i powtarzalna próba A/B potwierdzająca poprawę przed dodaniem filtrów bodycam. |
| T18 | Ujednolicić etykiety wszystkich issues | T00 | Każde issue ma obszar, priorytet, stan i rodzaj w formacie typ:wartość. |
