#!/bin/bash
set -e

echo "=== Starte Installation des Webhosters ==="

# 1. Überprüfen, ob Docker installiert ist
if ! command -v docker &> /dev/null; then
    echo "Fehler: Docker ist nicht installiert."
    echo "Bitte installiere Docker zuerst."
    exit 1
fi

# 2. Prüfen, ob der Data-Ordner und die benötigten PDFs existieren
# Falls nicht, legen wir Dummy-Dateien an, damit der Bau nicht fehlschlägt.
if [ ! -d "Data" ]; then
    echo "Data-Ordner nicht gefunden. Erstelle Data-Ordner..."
    mkdir -p Data
fi

for i in {1..5}; do
    if [ ! -f "Data/site${i}.pdf" ]; then
        echo "Warnung: Data/site${i}.pdf fehlt! Erstelle eine leere Platzhalter-Datei."
        echo "%PDF-1.1" > "Data/site${i}.pdf"
        echo "Platzhalter PDF für Port 800${i}" >> "Data/site${i}.pdf"
    fi
done

# 3. Docker-Image bauen
echo "Baue das Docker-Image 'pdf-webhoster'..."
docker build -t pdf-webhoster .

# 4. Alte Container aufräumen (falls vorhanden)
echo "Stoppe/Entferne alte Container..."
docker stop pdf-webhoster-container 2>/dev/null || true
docker rm pdf-webhoster-container 2>/dev/null || true

# 5. Neuen Container starten
echo "Starte neuen Container..."
docker run -d \
    --name pdf-webhoster-container \
    -p 8001:8001 \
    -p 8002:8002 \
    -p 8003:8003 \
    -p 8004:8004 \
    -p 8005:8005 \
    --restart unless-stopped \
    pdf-webhoster

# 6. Abschlussmeldung
SERVER_IP=$(hostname -I 2>/dev/null | awk '{print $1}')
if [ -z "$SERVER_IP" ]; then
    SERVER_IP="localhost"
fi

echo "=== Installation erfolgreich abgeschlossen! ==="
echo "Die Webseiten sind nun erreichbar:"
echo "Port 8001: http://${SERVER_IP}:8001 -> site1.pdf"
echo "Port 8002: http://${SERVER_IP}:8002 -> site2.pdf"
echo "Port 8003: http://${SERVER_IP}:8003 -> site3.pdf"
echo "Port 8004: http://${SERVER_IP}:8004 -> site4.pdf"
echo "Port 8005: http://${SERVER_IP}:8005 -> site5.pdf"
