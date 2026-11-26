# Światło, kamera i stanowiska testowe

F5 uruchamia ciemny korytarz. F4 otwiera panel i zwalnia kursor. Kolejne F4 wraca do rozglądania się. Panel pozwala zmienić mapę oraz wybrać zapałkę lub latarkę w dowolnym miejscu. Zmiana źródła gasi poprzednie i zachowuje zapasy. Zmiana mapy rozpoczyna próbę od punktu startowego z nowymi zapasami, zachowując profil suwaków, wybrane źródło i przełączniki do końca sesji. F3 przełącza diagnostykę.

| Parametr startowy | Zapałka | Latarka |
|---|---|---|
| Zasięg | Promień jasnej strefy 2,5 m, światło stopniowo gaśnie do 12,5 m dookoła | 15 m do przodu |
| Moc | 1,0 | 2,5 |
| Kształt światła | Wahanie 0,035, główny okres 2,8 s | Półkąt 28,6°, wygaszenie brzegu 0,5 |
| Maksymalny ślad po zgaszeniu | 8 s, bursztynowy | 30 s, chłodny |

## Zapasy

Domyślnie w obu stanowiskach włączone są nieskończone zasoby. Zatrzymują czas palenia i zużycie baterii, pozwalają korzystać z pustego pudełka i zapewniają pełną kondycję do sprintu i ślizgu. Wyłącz opcję w F4 do prób przetrwania.

Gracz zaczyna z pięcioma zapałkami, pełnym ogniwem i dwiema bateriami zapasowymi. F zapala zapałkę na 5 s. Zgaszenie przed czasem zużywa całą zapałkę. Przy wybranej latarce F przełącza snop. Jedno ogniwo starcza łącznie na 25 s. R wymienia częściowo zużyte lub puste ogniwo, odrzucając pozostały ładunek. Pełne ogniwo nie podlega wymianie. Po wyczerpaniu ogniwa latarkę trzeba ponownie włączyć.

## Pamięć powierzchni

Pełna ekspozycja trwa 2,5 s. Pierwsze około 0,25 s stopniowo ujawnia wzór, krótsze oświetlenie daje krótszy ślad. Przerwa resetuje ciągłą ekspozycję, a rozpoczęty ślad wygasa na powierzchni. Wzór ma domyślnie 10 punktów na metr na każdej osi. Dla drobnych punktów w oddali shader uśrednia pokrycie piksela, także przy patrzeniu wzdłuż podłogi.

W rdzeniu snopa latarki taka sama ekspozycja daje podłodze, ścianie i przeszkodzie ten sam czas pamięci do 75% zasięgu (11,25 m). W ostatniej ćwiartce czas płynnie spada do zera. Miękka krawędź wiązki daje słabszy zapis. Zapałka zachowuje stopniowy logarytmiczny spadek z odległością i wpływ kąta padania. Dla obu źródeł zasłonięcie od strony oka lub źródła blokuje zapis. Próbkowanie brył ma rozstaw do 0,45 m i częstotliwość 10 Hz dla zapałki oraz 30 Hz dla latarki. Shader interpoluje próbki na każdej powierzchni osobno. Światło okienne służy do oświetlenia sceny.

## Bodycam i mapy

Optyka jest domyślnie włączona. W sekcji Bodycam można ustawić pionowe pole widzenia (startowo 92°), dystorsję (0,22), winietę (0,32) i szum cieni (0,12). Wyłączenie przywraca zwykłą kamerę i jej pierwotne pole widzenia. Filtr działa przed interfejsem.

Korytarz i jego dziedziniec mają ciągły dach oraz ciemne otoczenie do próby poświaty. Sala pałacu zachowuje niski strop do ślizgu, przegrodę, wnękę i cel ze stanowiska Bench. Salę zamykają cztery ściany oraz dach. Trzy okna dają boczne światło, a żyrandol i cztery kinkiety rozświetlają ciepłymi plamami schody, boazerię i galerię. Wysokość holu wynosi 6 m. Stanowisko do ślizgu jest nadal dostępne.

## Próba odbioru

1. Wybierz latarkę i oświetl przez 2,5 s jednocześnie bok przeszkody i pobliską podłogę. Zgaś światło. Porównaj punkty wewnątrz snopa, a następnie obszary przy granicy 15 m.
2. Zmień źródło obok tej samej przeszkody. Sprawdź barwę zapałki i krótszy czas śladu.
3. Przejdź z F4 do sali pałacu. Patrząc na ramę okna włącz i wyłącz bodycam, następnie porównaj dystorsję przy tym samym polu widzenia. Wróć do korytarza i sprawdź ustawienia.

## Profil obrazu i przegląd Claude (T39)

Zapałka używa jednego OmniLight3D. Suwak jasnego promienia ustala skalę zaniku i moc źródła. Zewnętrzna granica renderowania to jasny promień plus regulowana odległość zaniku (domyślnie 2,5 + 10 m). Pamięć śledzi widoczne powierzchnie w tej samej strefie. Promienie fizyki służą wyłącznie sprawdzeniu zasłonięcia śladu.

Filtr ekranowy Francisco Cidade działa przed optyką i diagnostyką. W F4 siła PSX startuje od 0,42 i rozmiar piksela od 2. Drugi przebieg nakłada radialną projekcję obiektywu, niewielkie rozdzielenie kanałów, ziarno i miękkie obramowanie. Wyłącznik bodycam pozwala wrócić do zwykłego obrazu 3D. Zachowujemy materiały powierzchni z cieniami i pamięcią ekspozycji. Oba źródła kodu są dostępne na CC0. [Bodycam footage, cyanone](https://godotshaders.com/shader/bodycam/) · [PSX – Godot Shader, Francisco Cidade](https://store.godotengine.org/asset/fcidade/psx-godot-shader/)

Do przeglądu Claude oznaczamy PR i powiązane zadania etykietą review:claude. Na korytarzu porównać płonącą i zgaszoną zapałkę przy zbiegu ściany i podłogi, także przy promieniu 2,5 m. W rezydencji sprawdzić miękkie przejścia poza wyspami światła, ciemne wnęki, ruch po schodach i stabilność podziałów okien przy obrocie z włączoną kamerą.

## Strojenie podczas playtestu (T40)

W F4 każda sekcja narzędzia ma dwa próbniki kolorów. Pierwszy zmienia światło bezpośrednie, drugi kropki na zapamiętanych powierzchniach, również po zgaszeniu narzędzia. Zapałka ma osobno regulowaną długość zaniku poza jasnym rdzeniem (0,5–24 m) oraz tłumienie światła. Latarka ma tłumienie i udział końcowej strefy zaniku śladu w całym zasięgu (0,05–0,95; startowo 0,25).

Ciemność otoczenia reguluje wypełnienie cieni na obu mapach. 100% wyłącza wypełnienie, 0% daje maksymalne. Początkowe wartości to 100% w korytarzu i 85% w rezydencji. Ręczna zmiana przechodzi na kolejną mapę do końca sesji.

W optyce rozmiar i miękkość ramki regulują maskę obiektywu. Rozmycie brzegu (0–16 px) i początek rozmycia (ułamek promienia obrazu) zmieniają ostrość sceny na obrzeżach. Osobno można dostroić aberrację, tempo ziarna i dithering PSX. Próba: ustawić różne barwy źródła i śladu, zgasić światło, zmienić kolor pozostałych kropek, a potem porównać ustawienia przy oknie rezydencji.
