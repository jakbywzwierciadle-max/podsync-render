# Używamy community obrazu tdeutsch/podsync
FROM tdeutsch/podsync:latest

WORKDIR /app

# Kopiujemy Twój config
COPY config.toml /config.toml

EXPOSE 8080

CMD ["podsync", "-c", "/config.toml"]
