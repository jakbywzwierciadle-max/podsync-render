# Używamy obrazu Podsync z GitHub Container Registry
FROM ghcr.io/mxpv/podsync:latest

# Kopiujemy config do kontenera
COPY config.toml /app/config.toml

# Ustawiamy katalog roboczy
WORKDIR /app

# Otwieramy port 8080
EXPOSE 8080

# Uruchamiamy Podsync
CMD ["podsync"]