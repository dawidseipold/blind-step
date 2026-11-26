# Światło i pamięć terenu

## Sterowanie i zapasy

F5 otwiera LightCourse. Gracz zaczyna we wnętrzu z pięcioma zapałkami. F zapala jedną i od razu odejmuje ją z pudełka. Płomień gaśnie po 5 sekundach albo zaraz po ponownym F. Wcześniejsze zgaszenie nie zwraca zapałki. Po wypaleniu ostatniej można nadal przejść trasę po ciemku. F3 pokazuje zapas i czas palenia.

Pierwsze przekroczenie progu dziedzińca wyposaża gracza w latarkę z pełnym ogniwem i dwiema bateriami zapasowymi. Jest to skrót do testu przyszłej sekcji plenerowej. Latarka zostaje przy graczu także przy powrocie. F przełącza światło. Ogniwo zapewnia łącznie 25 s świecenia; częste włączanie i wyłączanie zachowuje pozostały czas. Przy zerze światło gaśnie. R wymienia rozładowaną lub częściowo zużytą baterię na pełną, odrzucając resztę starej. Pełna bateria nie zużywa zapasowej przy R. Przy wymianie w trakcie świecenia snop pozostaje włączony; po całkowitym rozładowaniu trzeba ponownie wcisnąć F.

| Źródło | Kształt światła | Pamięć powierzchni |
|---|---|---|
| Zapałka | Ciepła poświata dookoła, zasięg 2,7 m | Bursztynowe punkty do 7 s |
| Latarka | Wąski stożek w kierunku patrzenia, półkąt 28,63°, energia 3,4, zasięg 15 m, radialnie wygaszone brzegi | Punktowa pamięć do 10 s |

## Co pamięta gracz

Punkty pojawiają się na oświetlonej powierzchni, a ich trwałość zależy od czasu ciągłej ekspozycji. Pierwsze ćwierć sekundy buduje widoczność wzoru. Przy trzech sekundach skutecznej ekspozycji w jasnym centrum osiągany jest limit czasu śladu. Granice snopa, odległość i kąt padania zmniejszają siłę zapisu. Odwrócenie źródła lub zgaszenie przerywa gromadzenie; krótki powrót nie kasuje silniejszego zapisu. Cienie blokują zapis.

W prototypie regularna siatka punktów na bryłach (odstęp do 0,45 m) próbkuje zapałkę do 10 razy na sekundę, a latarkę do 30 razy na sekundę. Promień do źródła sprawdza zasłonięcie. Shader dla każdego piksela miesza wygasające próbki z sąsiedztwa 4 × 4 na tej samej ścianie lub podłodze. Dzięki temu granica śladu łagodnie zanika. Drobne detale cienia są przybliżone. Po wygaśnięciu śladu przeszkody mają ginąć w ciemności. Ślad jest efektem percepcji gracza. Ewentualne wykrywanie przez istoty powinno korzystać z działającego źródła.

Zapałka zostawia bursztynowe punkty, a latarka chłodne. Mają różne progi ekspozycji: kolejne zapalają się w miarę zapamiętywania fragmentu. Nowe punkty krótko się rozjaśniają. Po zgaszeniu światła wzór zostaje na bryle, rzednie i znika. To informacja o pamięci bohatera.

Cała trasa LightCourse ma ciągły dach, a ściany dziedzińca stykają się z jego spodem. Światło otoczenia jest wyłączone. Dziedziniec testuje zasady latarki plenerowej w kontrolowanej ciemności.

## Próba w grze

1. W korytarzu znajdź przejście obok skrzyni. Zgaś zapałkę, odwróć się i od razu spójrz z powrotem. Zapamiętana strona skrzyni powinna jeszcze odcinać się od otoczenia.
2. Miń dwie boczne wnęki, omijając regał i skrzynie. Przy niskiej półce można przykucnąć lub ją obejść. Przy wyjściu nie ma stałego źródła światła.
3. Oświetl tę samą bliską powierzchnię przez jedną i trzy sekundy, gasząc źródło po każdej próbie i czekając na wygaśnięcie. Powtórz na dziedzińcu z latarką. Sprawdź dłuższy ślad, stan ogniwa po przerwie i wymianę przez R.
4. F5 od początku przywraca wszystkie zapasy. Jasna plansza do prób ruchu pozostaje dostępna przez otwarcie bench.tscn i F6.
