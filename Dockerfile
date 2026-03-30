FROM golang:1.22-alpine AS builder

WORKDIR /app
RUN apk add --no-cache git

# instalacja podsync (działa z modułami)
RUN go install github.com/mxpv/podsync@latest

FROM alpine:latest

WORKDIR /app

# kopiujemy binarkę z GOPATH
COPY --from=builder /go/bin/podsync /app/podsync

# config
COPY config.yml /config.yml

EXPOSE 8080

CMD ["/app/podsync", "-c", "/config.yml"]
