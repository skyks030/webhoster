# PDF Webhoster

Dieses Projekt stellt einen simplen Docker-Container bereit, der auf 5 verschiedenen Ports (8001-8005) parallel 5 verschiedene PDF-Dateien hostet. 

## Vorbereitung

Bevor du das Projekt ausrollst, solltest du deine eigenen PDF-Dateien in den `data` Ordner legen. 
Die Dateien müssen folgende Namen haben:
- `site1.pdf` (wird auf Port 8001 angezeigt)
- `site2.pdf` (wird auf Port 8002 angezeigt)
- `site3.pdf` (wird auf Port 8003 angezeigt)
- `site4.pdf` (wird auf Port 8004 angezeigt)
- `site5.pdf` (wird auf Port 8005 angezeigt)

*(Falls du dies am Anfang vergisst oder testweise startest, erstellt das Installationsskript automatisch Platzhalter-Dateien).*

## Installation auf einem Linux-Server

Lade dieses Repository zunächst in dein GitHub hoch.
Um das Projekt danach auf deinem Linux-Server zu installieren und automatisch zu starten, kopiere einfach folgenden Befehl in dein Server-Terminal:

```bash
git clone https://github.com/skyks030/webhoster.git webhoster && cd webhoster && chmod +x install.sh && ./install.sh
```

### Was macht der Befehl?
1. Lädt das Repository auf deinen Server in den Ordner `webhoster` herunter.
2. Wechselt in das Verzeichnis.
3. Macht das Installationsskript (`install.sh`) ausführbar.
4. Führt das Skript aus, welches das Docker-Image baut und den Docker-Container auf den Ports 8001-8005 startet.

## Aktualisierung / PDFs austauschen
Wenn du die PDFs im `data` Ordner änderst, musst du den Docker-Container neu bauen. Führe dazu im Verzeichnis wieder aus:
```bash
./install.sh
```
Das Skript stoppt automatisch den alten Container und startet die aktualisierte Version.

## Lokales Testen (Mac/Windows mit Docker Desktop)
Wenn du die Container lokal auf deinem Rechner (z.B. einem Mac) überprüfen willst, kannst du das beiliegende Test-Skript nutzen.
Stelle sicher, dass **Docker Desktop** installiert ist und läuft.
Führe dann im Terminal aus:
```bash
./test_local.sh
```
Das Skript baut den Container lokal und macht ihn über `http://localhost:8001` bis `8005` in deinem Browser verfügbar.
