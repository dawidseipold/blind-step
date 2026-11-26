# Zapałki i skradanie w cieniu

Na obu stanowiskach F zapala lub gasi zapałkę. Pudełko ma 5 sztuk, płomień pali się domyślnie 5 s. Wcześniejsze zgaszenie zużywa całą sztukę. Domyślny tryb testowy F4 zapewnia nieskończone zapasy, czas palenia i kondycję. Wyłącz go do próby przejścia trasy. Zgaszenie usuwa wkład płomienia w oświetlenie w tej samej klatce. Trasa zachowuje zwykłe światło sceny.

## Gradient

Jedno ciepłe OmniLight3D z cieniami oświetla otoczenie dłoni. Jasny promień domyślnie wynosi 2,5 m, długość zaniku 10 m. Długość zaniku określa nachylenie krzywej: dla typowych ustawień po przejściu takiej odległości od jasnego promienia bezpośredni wkład spada do około 1/16. Wykładnik jest ograniczony do 0,5–4. Silnik wygasza najsłabszy ogon dopiero przy jasnym promieniu plus trzykrotna długość zaniku. Kształt powierzchni, jej barwa i przeszkody wpływają na ostateczny obraz.

## Strojenie i kamera

F4 zwalnia mysz i otwiera wybór mapy, ciemność otoczenia, ustawienia zapałki oraz bodycam i PSX. Każdy suwak ma pole liczbowe z dokładnością do 0,001. Kliknij liczbę, wpisz np. 99.8 przy ciemności i zatwierdź Enterem. Wybrane wartości przechodzą na kolejną mapę do końca sesji. Zmiana mapy rozpoczyna próbę z nowym pudełkiem. Optyka, winieta, ziarno i rozmycie działają na obraz gracza. Próg widoczności dotyczy świata przed obróbką kamery.

## Ukrycie przed wzrokiem

Gracz ma wybór między ciemną trasą wymagającą orientacji i krótkim przejściem przez światło. Na razie wzrok wuja reprezentuje jeden nieruchomy punkt na każdej mapie. Co 0,1 s sprawdzamy linię widzenia do głowy oraz tułowia na aktualnej wysokości postaci. Pełna przeszkoda daje stan „Za osłoną”. Przy odsłoniętej sylwetce ekspozycja uwzględnia światło otoczenia, bezpośrednie źródła, ich kierunek, odległość i zasłonięcie przez kolizję. Płonąca zapałka również oświetla gracza.

F3 pokazuje stan i licznik zauważenia. Poniżej roboczego progu 0,16 gracz jest w cieniu. Powyżej progu licznik rośnie od 40 do 90 punktów procentowych na sekundę zależnie od światła. Powrót w cień lub za osłonę zmniejsza licznik o 65 punktów na sekundę. Limit 100% oznacza wykrycie w próbie. Pościg, obrót głowy i kąt widzenia należą do późniejszej pracy nad wujem. Cienie od dekoracji bez kolizji mogą różnić się od wyniku sondy.

## Próba odbioru

Na ciemnym korytarzu wyjdź na linię wzroku obserwatora, zapal zapałkę i schowaj się za pełnym regałem. Porównaj trzy stany F3. W rezydencji powtórz próbę przy kinkiecie i we wnęce. Zgaś płomień na obu mapach i porównaj kadr z tym sprzed zapalenia.

Wersję z latarką, bateriami i zapamiętywaniem powierzchni zachowuje [archiwum w Git](https://github.com/dawidseipold/blind-step/tree/archive/flashlight-surface-memory). Źródła optyki są opisane w nagłówkach shaderów. [Bodycam footage](https://godotshaders.com/shader/bodycam/) · [PSX – Godot Shader](https://store.godotengine.org/asset/fcidade/psx-godot-shader/)
