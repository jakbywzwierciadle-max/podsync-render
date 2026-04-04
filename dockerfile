FROM php:8.2-cli

# yt-dlp + narzędzia
RUN apt-get update && apt-get install -y \
    python3 python3-pip ffmpeg \
    && pip3 install yt-dlp \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Twoje pliki
COPY update.sh /app/update.sh
COPY dir2cast.php /app/dir2cast.php
COPY dir2cast.ini /app/dir2cast.ini
COPY channels.txt /app/channels.txt

RUN chmod +x /app/update.sh

# katalog na dane (Railway podmontuje tu storage)
VOLUME ["/data"]

# uruchamiamy:
# 1) pętlę update (w tle)
# 2) serwer HTTP serwujący /data (w tym feed.xml)
CMD bash -c "/app/update.sh & php -S 0.0.0.0:8080 -t /data"
