FROM golang:1.26-alpine AS builder

WORKDIR /app
RUN apk add --no-cache git

# instalacja poprawnej ścieżki
RUN go install github.com/mxpv/podsync/cmd/podsync@latest

FROM alpine:latest

WORKDIR /app

COPY --from=builder /go/bin/podsync /app/podsync
COPY config.toml /config.toml

EXPOSE 8080

CMD ["/app/podsync", "-c", "/config.yml"]
