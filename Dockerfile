FROM golang:1.22-alpine AS builder

WORKDIR /app
RUN apk add --no-cache git

RUN git clone https://github.com/mxpv/podsync.git .
RUN go build -o podsync

FROM alpine:latest

WORKDIR /app

COPY --from=builder /app/podsync /app/podsync
COPY config.yml /config.yml

EXPOSE 8080

CMD ["/app/podsync", "-c", "/config.yml"]
