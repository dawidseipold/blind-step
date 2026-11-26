# Światło i pamięć terenu

## Sterowanie i zapasy

F5 otwiera LightCourse. Gracz zaczyna we wnętrzu z pięcioma zapałkami. F zapala jedną i od razu odejmuje ją z pudełka. Płomień gaśnie po 7 sekundach albo zaraz po ponownym F. Wcześniejsze zgaszenie nie zwraca zapałki. Po wypaleniu ostatniej można nadal przejść trasę po ciemku. F3 pokazuje zapas i czas palenia.

Pierwsze przekroczenie progu dziedzińca wyposaża gracza w latarkę z pełnym ogniwem i dwiema bateriami zapasowymi. Jest to skrót do testu przyszłej sekcji plenerowej. Latarka zostaje przy graczu także przy powrocie. F przełącza światło. Ogniwo zapewnia łącznie 25 s świecenia; częste włączanie i wyłączanie zachowuje pozostały czas. Przy zerze światło gaśnie. R wymienia rozładowaną lub częściowo zużytą baterię na pełną, odrzucając resztę starej. Pełna bateria nie zużywa zapasowej przy R. Przy wymianie w trakcie świecenia snop pozostaje włączony; po całkowitym rozładowaniu trzeba ponownie wcisnąć F.

| Źródło | Kształt światła | Pamięć powierzchni |
|---|---|---|
| Zapałka | Ciepła poświata dookoła, zasięg 3,6 m | Słabszy ślad do 1,8 s |
| Latarka | Wąski stożek w kierunku patrzenia, półkąt 24°, zasięg 15 m | Mocniejszy ślad do 3,5 s |

## Co pamięta gracz

Pamięć jest przypisana do powierzchni. Odejście, obrót głowy lub zgaszenie źródła pozwala porównać ostatnio oświetlone fragmenty z ciemnym tłem. Każdy fragment wygasa od swojej ostatniej ekspozycji. Przeszkoda blokuje zapis po przeciwnej stronie. Ślad słabnie przy granicy zasięgu, a dla latarki również na brzegu snopa.

W prototypie regularna siatka punktów na bryłach (odstęp do 0,45 m) próbuje światło do 10 razy na sekundę. Promień do źródła sprawdza zasłonięcie. Shader dla każdego piksela miesza wygasające próbki z sąsiedztwa 4 × 4 na tej samej ścianie lub podłodze. Dzięki temu granica śladu łagodnie zanika. Drobne detale cienia są przybliżone. Po wygaśnięciu śladu przeszkody mają ginąć w ciemności. Przy wyjściu pozostaje słaba wskazówka świetlna w promieniu 2,2 m. Ślad jest efektem percepcji gracza. Ewentualne wykrywanie przez istoty powinno korzystać z działającego źródła.

## Próba w grze

1. W korytarzu znajdź przejście obok skrzyni. Zgaś zapałkę, odwróć się i od razu spójrz z powrotem. Zapamiętana strona skrzyni powinna jeszcze odcinać się od otoczenia.
2. Miń dwie boczne wnęki, omijając regał i skrzynie. Przy niskiej półce można przykucnąć lub ją obejść. Słabe światło przy wyjściu wskazuje dziedziniec.
3. Na dworze krótko oświetl słupek, przesuń snop i zgaś światło. Sprawdź dłuższy ślad, stan ogniwa po przerwie i wymianę przez R.
4. F5 od początku przywraca wszystkie zapasy. Jasna plansza do prób ruchu pozostaje dostępna przez otwarcie bench.tscn i F6.
