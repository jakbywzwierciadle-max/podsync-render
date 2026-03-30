FROM mrpio/podsync:latest

WORKDIR /app
COPY config.toml /config.toml

EXPOSE 8080

CMD ["/podsync", "-c", "/config.toml"]
