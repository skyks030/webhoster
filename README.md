
```bash
git clone https://github.com/GITHUB_USERNAME/REPO_NAME.git webhoster && cd webhoster && chmod +x install.sh && ./install.sh
```

### Was macht der Befehl?
1. Lädt das Repository auf deinen Server in den Ordner `webhoster` herunter.
2. Wechselt in das Verzeichnis.
3. Macht das Installationsskript (`install.sh`) ausführbar.
4. Führt das Skript aus, welches das Docker-Image baut und den Docker-Container auf den Ports 8001-8005 startet.

## Aktualisierung / PDFs austauschen
Wenn du die PDFs im `Data` Ordner änderst, musst du den Docker-Container neu bauen. Führe dazu im Verzeichnis wieder aus:
```bash
./install.sh
```
Das Skript stoppt automatisch den alten Container und startet die aktualisierte Version.
