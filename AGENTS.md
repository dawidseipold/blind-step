# Wspólne zasady Codex i Claude

Jedno issue na każdą zmianę, także dokumentację, poprawkę i wydanie. Jedno konto edytuje projekt w danym momencie. W issue podaj cel, scenę lub pliki, zależności i jeden obserwowalny warunek odbioru. Przy braku dostępu do GitHuba użyj wpisu Txx w ROADMAP.md i powiąż go z issue po publikacji.

- Rozpoczynaj feat/<numer>-<temat> z aktualnego development. Używaj PR do development. Po akceptacji i scaleniu zamknij powiązane issue. Dla roboczych wpisów lokalnych użyj Txx zamiast numeru.
- Przy przygotowaniu wydania utwórz release/<wersja> z development. Po testach scal release do main, oznacz wydanie tagiem v<wersja> i scal poprawki wydania z powrotem do development. Pilną poprawkę wydania przygotuj na hotfix/<numer>-<temat> z main i włącz do obu gałęzi.
- Zachowuj autora skonfigurowanego w Git. Pomijaj Co-authored-by, podpisy agentów, Generated with oraz inne stopki AI w commitach i opisach PR. Sprawdź treść przed wysłaniem.
- Kontynuuj istniejącą gałąź przy zmianie konta. Przekazanie w issue zawiera gałąź, SHA, pliki, wynik konkretnego testu i jeden następny krok. Zacznij od git status, issue i przekazania. Wyszukuj symbole przez rg.
- Projekt jest w game/new-game-project. Weryfikuj zmianę w Godocie 4.7.2. Do testu ładowania użyj godot --headless --path game/new-game-project --import, potem godot --headless --path game/new-game-project --quit-after 10. Ocenę obrazu, ruchu i odsłuch zapisuj oddzielnie od wyniku ładowania.
- Zachowaj surowe bryły do zatwierdzenia podstaw. HUD, integracja MCP, harness i docelowe assety czekają na osobne zadania. Pliki .uid przechowuj w Git, cache .godot/ pomijaj.
