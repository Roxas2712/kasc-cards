# KASC Cards 1.3.4 aktualisieren

Die neuen Cards binden KASC 6.7.18 und VASC 3.0.36 ein. Alte versiegelte Cards bleiben an ihre alten Mod-Versionen gebunden; deshalb auch die Card selbst aktualisieren.

1. Spiel vollständig schließen. Spielstände und `mod_storage`/Vermächtnisbank behalten und sichern.
2. Unter „Find mods“ die Quelle https://raw.githubusercontent.com/Roxas2712/kasc-cards/main/kasc-card-index.json hinzufügen oder aktualisieren. Auch die frühere Quelle im KASC-Branch `codex/kasc-6.7-card-distribution` wird aktualisiert.
3. [Card 1.3.4 für Rot, Blau oder Gelb](https://github.com/Roxas2712/kasc-cards/releases/tag/v1.3.4) importieren. Die vorhandene Card derselben Edition aktualisieren; ihre ID bleibt gleich.
4. Beide gebundenen Mods installieren/aktualisieren: KASC 6.7.18 und VASC 3.0.36. Spiel vollständig neu starten.

IDs, Bilder, Optionen, Ladereihenfolge, Versiegelung und Speicherbereiche bleiben erhalten. Keine Card-Spielstände, Bankdaten oder vorhandenen optionalen Sprite-Pakete löschen. Es wird weiterhin die eigene passende ROM benötigt. Normale Spielstände außerhalb einer Card werden nicht automatisch in deren Speicherbereich übernommen.

Bei manueller Installation die Mod-ZIPs aus den verlinkten Releases verwenden, nicht GitHubs „Source code“-Archive. Die optionalen Desktop-Installer „Preserve-Installed-Sprites“ sichern bestehende Mod-Ordner und erhalten ausgelassene optionale Grafiken. Details stehen in den jeweiligen Release-Hinweisen.
