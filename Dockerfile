FROM nginx:alpine

# Eigene Nginx-Konfiguration kopieren
COPY nginx.conf /etc/nginx/nginx.conf

# Data-Ordner in den Container kopieren
COPY Data/ /Data/

# Ports freigeben
EXPOSE 8001 8002 8003 8004 8005
