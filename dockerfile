
FROM ghcr.io/mxpv/podsync:latest

WORKDIR /app

# Utwórz katalog danych w obrazie
RUN mkdir -p /app/data

# Skopiuj config do kontenera
COPY config.toml /app/config.toml

EXPOSE 8080

CMD ["podsync"]
