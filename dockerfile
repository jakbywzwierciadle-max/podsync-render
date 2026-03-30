FROM ghcr.io/mxpv/podsync:latest

COPY config.toml /app/config.toml

WORKDIR /app

# Utwórz katalog do danych
RUN mkdir -p /app/data

EXPOSE 8080

CMD ["podsync"]
# Uruchamiamy Podsync
CMD ["podsync"]
