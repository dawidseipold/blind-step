# Praca w repozytorium

Jedno aktywne zadanie i jeden autor zmian naraz, niezależnie od konta. Kod gry w game/, GDScript i Godot 4. Dokładną wersję odczytaj z README. Założenia wizualne w DESIGN.md. Buduj wyłącznie zakres bieżącego issue. HUD, dodatki, frameworki agentowe i zmiany kierunku artystycznego wymagają osobnego zadania uzgodnionego z autorem gry.

1. Sprawdź git status i aktualną gałąź. Otwórz wskazane issue, ostatnie przekazanie oraz pliki wymienione w zadaniu. Szukaj symboli przez rg. Rozszerzaj kontekst tylko w miarę potrzeby.
2. Nowe zadanie zacznij na gałęzi issue-<numer>-<temat>. Przy zmianie konta w trakcie zadania kontynuuj tę samą gałąź i sprawdź ostatni commit. Zachowaj cudze zmiany.
3. Do weryfikacji użyj sceny i warunku odbioru z issue. Kiedy godot jest w PATH, z katalogu repo wykonaj godot --headless --path game --import, a następnie godot --headless --path game --quit-after 10. Ruch, obraz i odsłuch sprawdź także w edytorze. Podaj, co faktycznie sprawdzono.
4. Przy przekazaniu zapisz commit roboczy i wypchnij gałąź, jeśli kolejne konto używa innej kopii. W issue zostaw gałąź i SHA, rezultat, test, otwarty problem i następny krok. Zamknij zadanie po odbiorze i scaleniu.
5. Użyj jednego porównania A/B do zmian wyglądu. Dodawaj tylko ujęcie z uzgodnionego miejsca lub krótki klip potrzebny do decyzji. Cache .godot/ pomijaj, pliki .uid zasobów zachowuj w Git.

Przykład zlecenia dla następnego konta: „Kontynuuj issue numer X od SHA Y. Sprawdź warunek odbioru w scenie Bench. Ostatni problem i pliki są w komentarzu przekazania”.
