FROM ghcr.io/mrps/podsync:nightly
COPY config.yml /config.yml
CMD ["podsync", "-c", "/config.yml"]
