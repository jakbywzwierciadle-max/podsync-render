FROM ghcr.io/mxpv/podsync:latest
COPY config.toml /app/config.toml
WORKDIR /app
CMD ["podsync", "--config", "/app/config.toml"]
