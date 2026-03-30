FROM tdeutsch/podsync:latest

WORKDIR /app

# Tworzymy katalog dla danych
RUN mkdir -p /tmp/data

# Kopiujemy konfigurację
COPY config.toml /config.toml

EXPOSE 8080

CMD ["podsync", "-c", "/config.toml"]
