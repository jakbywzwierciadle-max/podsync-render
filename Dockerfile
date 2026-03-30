FROM golang:1.26-alpine AS builder

WORKDIR /app
RUN apk add --no-cache git

RUN go install github.com/mxpv/podsync@latest

FROM alpine:latest

WORKDIR /app

COPY --from=builder /go/bin/podsync /app/podsync
COPY config.yml /config.yml

EXPOSE 8080

CMD ["/app/podsync", "-c", "/config.yml"]
