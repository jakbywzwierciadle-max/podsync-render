FROM ghcr.io/mxpv/podsync:latest

WORKDIR /app

# Utwórz katalog do danych
RUN mkdir -p /app/data

# Kopiujemy config do kontenera
COPY config.toml /app/config.toml

EXPOSE 8080

# Uruchamiamy Podsync
CMD ["podsync"]
