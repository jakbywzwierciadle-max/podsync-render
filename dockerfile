# pobranie źródła podsync
RUN git clone https://github.com/mxpv/podsync.git .

# build
RUN go build -o podsync

# etap końcowy (lekki obraz)
FROM alpine:latest

WORKDIR /app

# kopiujemy binarkę
COPY --from=builder /app/podsync /app/podsync

# kopiujemy config
COPY config.yml /config.yml

# port
EXPOSE 8080

CMD ["/app/podsync", "-c", "/config.yml"]
