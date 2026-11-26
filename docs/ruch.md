# Ruch gracza — bieżące założenia

Parametry prób w Bench, Godot 4.7.2. Przy zmianie zachowania aktualizujemy ten opis w tym samym PR co implementację. Parametry eksportowane można dostrajać w Inspectorze; tabela podaje wartości startowe.

| Mechanika | Reguła i próba odbioru |
|---|---|
| Chód | WASD względem kierunku patrzenia, 3 m/s. Skos ma tę samą prędkość. Przyspieszenie 20 m/s², hamowanie 30 m/s². Mysz reaguje od razu. |
| Kucanie | Przytrzymanie Ctrl w marszu obniża kapsułę z 1,8 do 1 m i prędkość do 1,5 m/s. Po zwolnieniu Ctrl postać może wstać, gdy ma miejsce nad głową. Wygładzanie ruchu oczu jest planowane w bloku kamery. |
| Sprint | Shift i ruch na stojąco. Prędkość maksymalna 8 m/s. Bieg po ziemi zużywa zapas, postój z Shift i naciskanie na ścianę po zatrzymaniu pozwalają odpocząć. |
| Kondycja | Start 100 punktów. Od 100 do 20 ciągły sprint trwa około 4,8 s. Ostatnie 20 punktów zużywa się dwukrotnie wolniej i daje około 2,4 s. Łącznie około 7,2 s biegu. |
| Regeneracja | Zwykle zaczyna się po 1,25 s i oddaje 25 punktów/s. Po dojściu do 20 punktów lub niżej pojawia się status rezerwy. Po zakończeniu wysiłku trzeba odczekać 2,5 s. Wtedy status znika i wraca zwykłe tempo 25 punktów/s, także poniżej 20. Ponowny sprint w rezerwie włącza status i liczy przerwę od nowa. Po wyczerpaniu trzeba puścić Shift przy zapasie co najmniej 25 punktów, żeby ponownie biec. |
| Ślizg | Wciśnij Ctrl podczas rzeczywistego biegu na ziemi po osiągnięciu co najmniej 75% prędkości sprintu (domyślnie 6 m/s). Potrzeba 8 punktów, zużywanych raz na początku. Postać natychmiast przyjmuje niską sylwetkę i przez maksymalnie 0,65 s wytraca prędkość w kierunku wejścia. Mysz pozwala się rozglądać. Zderzenie ze ścianą lub utrata podparcia kończy ślizg. Pod niskim stropem postać pozostaje pochylona. Przy pełnej prędkości ślizg daje około 3,1 m na płaskiej powierzchni. |
| Diagnostyka | F3 przełącza odczyt kondycji, ślizgu i kosztu rezerwy na Bench. |

Próba w grze: rozpędź się przed prześwitem, wciśnij Ctrl i puść go pod stropem. Powtórz od marszu — w drugim przypadku otrzymasz zwykłe kucanie. W osobnej próbie porównaj regenerację po zatrzymaniu powyżej i poniżej 20 punktów. Poszerzenie FOV i proceduralny oddech mają własne zadania w późniejszych blokach.
