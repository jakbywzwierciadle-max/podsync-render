FROM docker.io/mrpio/podsync:latest

COPY config.yml /config.yml

CMD ["podsync", "-c", "/config.yml"]
