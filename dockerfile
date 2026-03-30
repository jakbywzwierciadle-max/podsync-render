FROM ghcr.io/mxpv/podsync:latest

# Kopiujemy config do kontenera
COPY config.toml /app/config.toml

WORKDIR /app

# Utwórz katalog do danych
RUN mkdir -p /app/data

EXPOSE 8080

# Uruchamiamy Podsync
CMD ["podsync"]
