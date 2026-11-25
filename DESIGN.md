# Założenia prototypu

Gracz porusza się po wnętrzu z kamerą przypiętą na wysokości klatki piersiowej. Latarka pomaga wybrać drogę, a światło i kroki mogą zdradzić położenie. Pytanie prototypu brzmi „Czy zgasisz latarkę, kiedy usłyszysz coś za ścianą?”. Fabuła, miejsce akcji, wygląd istoty i docelowa pętla rozgrywki pozostają otwarte.

## Pierwszy kadr

Przy wejściu chłodna świetlówka odbija się na małym fragmencie podłogi. Jej odbicie urywa się na progu. Za nim widać framugę i jedną pionową krawędź szafy. Dopiero światło latarki odsłania, że drzwi są uchylone. Taki kadr ma wystarczyć do oceny kierunku bez opisów i ikon.

- PSX w geometrii i materiałach. Duże płaszczyzny, oszczędna paleta, tekstury próbne 64–128 px, osobny detal przyciągający wzrok w każdym ujęciu. Przygotuj próbki rdzy, farby olejnej i wydeptanej posadzki. Dobierz wspólną gęstość tekseli na fragmencie ściany.
- Bodycam w optyce. Przetestuj dwie siły dystorsji beczkowej. Mocne wygięcie przy narożnikach, stabilny środek kadru. Koryguj proporcje obrazu przed deformacją. Obrót myszy natychmiastowy, delikatny ruch mocowania zależny od przyspieszenia i hamowania. Osobna intensywność kołysania.
- Ciemność w dwóch warstwach. Oświetlenie sceny zachowuje różnicę między progiem i ścianą. Po zgaszeniu latarki powoli rośnie widoczność dużych kształtów, cienie tracą kolor. Ziarno sensora rośnie tam, gdzie sygnał jest słaby. Optyka działa także w jasności. Prześwietlenie przy świeceniu z bliska ma być lokalne. Ujęcia porównawcze z progu zaraz po zgaszeniu i po pięciu sekundach.
- Dźwięk. Kroki z impulsu i krótkiego filtrowanego szumu, wentylacja z dwóch lekko rozstrojonych tonów, odgłos istoty z rytmu kroków powtórzonego z narastającym błędem. Parametry ekspresji to rytm, obwiednia i barwa. Kwantyzacja amplitudy tylko na wybranych głosach. Krótkie dźwięki można wygenerować w pamięci przy starcie, a ciągły dron syntezować w trakcie gry. Do porównania presetów używaj stałego ziarna losowania. Głośność master i limiter na wyjściu.
- Informacja w świecie gry. Kondycję słychać w oddechu. Położenie przeciwnika zdradza pogłos i rytm kroków. Dane diagnostyczne dostępne podczas testów. Kadr gry domyślnie wolny od nakładek, liczników i ozdobnych napisów REC.

## Pierwszy eksperyment z rozgrywką

Po zaakceptowaniu ruchu i kamery zbuduj przejście do przełącznika oraz drogę powrotną z wyborem trasy. Jedno przejście oświetlone i krótkie, drugie ciemne, z możliwością osłonięcia się za rogiem. W pierwszej próbie obserwuj, czy tester spontanicznie zmienia tempo lub użycie latarki. W drugiej dodaj pojedynczy strzał jako opcję chwilowego odstraszenia fikcyjnej istoty kosztem głośnego sygnału. Zapisz, co sprowokowało wybór. Dopiero potem wybierz docelową pętlę.
