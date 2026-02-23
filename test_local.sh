#!/bin/bash
set -e

echo "=== Starte lokalen Test des Webhosters auf dem Mac ==="

# 1. Überprüfen, ob Docker installiert ist
if ! command -v docker &> /dev/null; then
    echo "Fehler: Docker ist nicht installiert."
    echo "Bitte installiere die Docker Desktop App für Mac und starte sie."
    exit 1
fi

# 2. Prüfen, ob der Docker Daemon (Docker Desktop) läuft
if ! docker info &> /dev/null; then
    echo "Fehler: Docker läuft aktuell nicht."
    echo "Bitte öffne die 'Docker' App (Docker Desktop) auf deinem Mac und warte, bis sie gestartet ist."
    exit 1
fi

# 3. Prüfen, ob der Data-Ordner und die benötigten PDFs existieren
if [ ! -d "data" ]; then
    echo "data-Ordner nicht gefunden. Erstelle data-Ordner..."
    mkdir -p data
fi

for i in {1..5}; do
    if [ ! -f "data/site${i}.pdf" ]; then
        echo "Warnung: data/site${i}.pdf fehlt! Erstelle eine leere Platzhalter-Datei."
        echo "%PDF-1.1" > "data/site${i}.pdf"
        echo "Platzhalter PDF für Port 800${i}" >> "data/site${i}.pdf"
    fi
done

# 4. Docker-Image bauen
echo "Baue das Docker-Image 'pdf-webhoster-local'..."
docker build -t pdf-webhoster-local .

# 5. Alte lokale Container aufräumen (falls vorhanden)
echo "Stoppe und entferne alten lokalen Container falls vorhanden..."
docker stop pdf-webhoster-local-container 2>/dev/null || true
docker rm pdf-webhoster-local-container 2>/dev/null || true

# 6. Neuen Container starten
echo "Starte neuen Container lokal..."
docker run -d \
    --name pdf-webhoster-local-container \
    -p 8001:8001 \
    -p 8002:8002 \
    -p 8003:8003 \
    -p 8004:8004 \
    -p 8005:8005 \
    pdf-webhoster-local

echo ""
echo "=== Lokaler Test erfolgreich gestartet! ==="
echo "Du kannst die Webseiten nun in deinem Browser aufrufen:"
echo "Port 8001: http://localhost:8001 -> site1.pdf"
echo "Port 8002: http://localhost:8002 -> site2.pdf"
echo "Port 8003: http://localhost:8003 -> site3.pdf"
echo "Port 8004: http://localhost:8004 -> site4.pdf"
echo "Port 8005: http://localhost:8005 -> site5.pdf"
echo ""
echo "Um den Test-Container in Docker wieder zu stoppen, führe folgenden Befehl aus:"
echo "docker stop pdf-webhoster-local-container"
echo "=== === === === === === === === === === ==="
