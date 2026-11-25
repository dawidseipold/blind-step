# Taśma 00

Roboczy prototyp pierwszoosobowego survival horroru na PC. Pierwszy cel to sprawdzić, czy przejście kilku metrów od światła w ciemność jest interesujące jeszcze przed dodaniem przeciwnika.

## Utworzenie projektu

W menedżerze Godota 4 wybierz Create. Wpisz nazwę **Taśma 00**, włącz **Create Folder** i ustaw końcową ścieżkę na podfolder **game** tego repozytorium. Sprawdź podgląd ścieżki, bo zmiana nazwy projektu może ją przeliczyć. Wybierz **Forward+**, **Git**, **Edit Now** i **Create**. Projekt będzie w `game/project.godot`. Zapisz dokładną wersję z Help → About Godot w tym pliku przy pierwszym commicie gry. Na razie wersja czeka na odczyt z edytora.

W edytorze kliknij **3D Scene**, nazwij korzeń **Bench**, zapisz scenę jako `res://bench.tscn`. F6 uruchamia bieżącą scenę. Przy pierwszym F5 wybierz Bench jako scenę główną. Sama pusta scena jeszcze niczego nie pokaże. Pierwszy test wymaga podłogi z kolizją, gracza z kamerą i jednego źródła światła.

## Materiały

- [Założenia i kierunek artystyczny](DESIGN.md)
- [Lista potrzebnych zasobów](ASSETS.md)
- [Roadmapa i warunki odbioru zadań](ROADMAP.md)
- [Zasady pracy agentów](AGENTS.md)

Przy pierwszym teście zapisz rozdzielczość okna, model GPU i czas klatki. Porównuj kolejne wersje z tego samego punktu i przy tym samym ustawieniu latarki.
