FROM nginx:alpine

# Eigene Nginx-Konfiguration kopieren
COPY nginx.conf /etc/nginx/nginx.conf

# HTML und Data-Ordner in den Container kopieren
COPY html/ /html/
COPY data/ /data/

# Ports freigeben
EXPOSE 8001 8002 8003 8004 8005
