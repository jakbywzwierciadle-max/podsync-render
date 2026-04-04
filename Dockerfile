
FROM python:3.11-slim

# system deps
RUN apt-get update && apt-get install -y \
    php-cli ffmpeg nodejs \
    && rm -rf /var/lib/apt/lists/*

# yt-dlp
RUN pip install yt-dlp Flask

WORKDIR /app

# Twoje pliki
COPY update.sh /app/update.sh
COPY dir2cast.php /app/dir2cast.php
COPY dir2cast.ini /app/dir2cast.ini
COPY channels.txt /app/channels.txt
COPY app.py /app/app.py

RUN chmod +x /app/update.sh

VOLUME ["/data"]

EXPOSE 3000

CMD bash -c "/app/update.sh & python /app/app.py"
