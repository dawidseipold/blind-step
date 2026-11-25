# Punktowe sprawdzanie API

Plan włączenia samego lookupu przy pierwszym zadaniu wymagającym sprawdzenia API. Repozytorium gry nie potrzebuje zależności uruchomieniowej. Wersja silnika to 4.7.2.stable.steam, odpowiadający tag referencji to 4.7.2-stable.

1. Na komputerze agentów wybierz wspólny katalog narzędzi poza repo gry. W Git Bash z dostępnymi Git i Python 3 pobierz źródło poleceniem `git clone https://github.com/Danm72/ai-gamedev-kit.git`. Wejdź przez `cd ai-gamedev-kit`. Skrypt podczas inicjalizacji cache korzysta z programu rm, dostępnego w Git Bash.
2. Ustaw sprawdzoną rewizję przez `git checkout --detach ef0467539bc14c8593996549956f28eb52749040`. Przed pierwszym uruchomieniem obejrzyj tools/godot_api.py. Zachowaj katalog cache narzędzia oddzielnie od zasobów Godota.
3. Wykonaj `python tools/godot_api.py Light3D light_energy`. Pierwsze zapytanie pobierze referencję silnika. Sprawdź, czy wynik podaje właściwość i jej typ. Dla dziedziczonych właściwości pytaj o klasę deklarującą.
4. Uruchom drugie zapytanie `python tools/godot_api.py SpotLight3D spot_range`. Domyślny cache jest współdzielony przez sesje tego samego użytkownika systemowego. Przy osobnych użytkownikach lub maszynach każdy może zainicjalizować własną kopię.
5. Agent wczytuje tylko odpowiedź dotyczącą używanego symbolu. Do instrukcji obsługi użyj opcji --docs, która przy pierwszym wywołaniu osobno pobiera podręcznik gałęzi 4.7. Wynik użycia narzędzia potwierdź w scenie testowej. Bridge, hooki, MCP i harness odkładamy do późniejszej decyzji.

[Źródło skryptu](https://github.com/Danm72/ai-gamedev-kit/blob/ef0467539bc14c8593996549956f28eb52749040/tools/godot_api.py)
