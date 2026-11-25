# Roadmapa prototypu

M0 uruchamia pustą scenę testową. M1 kończy się odbiorem ruchu, kamery i audio przez autora gry. Dopiero wtedy M2 dodaje budynek i przeciwnika. M3 bada propozycję pętli. Wspinaczka po ścianie czeka na ocenę pierwszej istoty.

## M0 · Utworzyć projekt i salę testową

Bench, game/project.godot. Podłoga z kolizją, próg, niskie nadproże, światło i kamera.

**Odbiór** — F5 otwiera salę. Zapisano wersję silnika i kadr odniesienia.

## M1 · Dostroić chód, skradanie i kondycję

Bench, scena Player. WASD, mysz, Ctrl do kucania, Shift do sprintu. Parametry prędkości i regeneracji dostępne w Inspectorze.

**Odbiór** — Gracz mieści się pod niskim nadprożem tylko kucając, nie wstaje w suficie. Sprint wyczerpuje się, wraca po odpoczynku. Ruch po skosie nie przyspiesza.

## M1 · Dostroić latarkę i obraz bodycam

Bench, Camera3D, SpotLight3D, profil postprocessu. F przełącza latarkę. Stały punkt zdjęcia przy progu.

**Odbiór** — Zapisano ten sam kadr z latarką i bez, zaraz po zgaszeniu i po adaptacji. Tester odnajduje drzwi, a latarka odkrywa dodatkowy szczegół. Obrót kamery pozwala przejść przez drzwi bez dyskomfortu.

## M1 · Zsyntezować kroki, oddech i tło

Bench, generator audio i magistrale. Dwie powierzchnie, klik, dron i zadyszka. Kroki emituje przebycie dystansu.

**Odbiór** — W ślepej próbie słychać różnicę między marszem i sprintem. W bezruchu kroki ustają. Sprawdzono brak przerw w dźwięku i przesterowania.

## M2 · Zbudować korytarz i trzy pokoje

Po odbiorze M1. Osobna scena budynku, boczna droga, ślepy narożnik i dwa materiały podłogi.

**Odbiór** — Dwie trasy prowadzą do przełącznika. Z ustalonego punktu jedna trasa jest widoczna, druga osłonięta.

## M2 · Sprawdzić słuch i reakcję istoty na światło

Jedna istota, zdarzenie hałasu z pozycją i siłą. Test wiązki uwzględnia kierunek, zasięg i przesłonięcie. Stany patrol, badanie bodźca, pogoń, szukanie.

**Odbiór** — Z tej samej odległości bieg przyciąga, a skradanie może pozostać niewykryte. Światło w otwartych drzwiach wywołuje reakcję, pełna ściana zasłania wiązkę. Po utracie tropu istota bada ostatnią znaną pozycję. Głośność master nie wpływa na percepcję AI.

## M3 · Porównać próbę ucieczki i próbę ze strzałem

Przejście do przełącznika i powrót. Jedna możliwość odstraszenia istoty w grze z kosztem hałasu.

**Odbiór** — Dwa przejścia tego samego układu. Zanotowano, gdzie tester zmienił trasę, użył latarki lub strzału i dlaczego. Na tej podstawie właściciel wybiera następny eksperyment.
