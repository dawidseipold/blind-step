# Lokalny lookup Godota

Na komputerze projektu uruchom z PowerShella:

```powershell
& "$env:USERPROFILE/Documents/Codex/_tools/godot-api.cmd" CharacterBody3D move_and_slide
```

Podaj klasę i właściwość albo metodę. Dla podręcznika użyj np. `--docs move_and_slide`. Wszystkie sesje na tym koncie Windows używają tego samego katalogu _tools i cache godot-ref. Pierwsza konfiguracja jest już wykonana.

Wersja gry to 4.7.2.stable.steam. Cache klas pochodzi z tagu 4.7.2-stable, podręcznik z gałęzi 4.7, a skrypt lookupu z rewizji ef0467539bc14c8593996549956f28eb52749040. Lookup działa poza projektem gry. W innej instalacji można uruchomić tools/godot_api.py z Pythona 3 według instrukcji upstream.

[Kod użytej wersji](https://github.com/Danm72/ai-gamedev-kit/blob/ef0467539bc14c8593996549956f28eb52749040/tools/godot_api.py)
