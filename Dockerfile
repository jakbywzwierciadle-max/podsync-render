FROM tdeutsch/podsync:v0.2.0
WORKDIR /app
COPY config.toml /config.toml
EXPOSE 8080
CMD ["podsync", "-c", "/config.toml"]
