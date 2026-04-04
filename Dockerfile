FROM python:3.11-slim

RUN apt-get update && apt-get install -y \
    php-cli ffmpeg nodejs \
    && rm -rf /var/lib/apt/lists/*

RUN pip install yt-dlp Flask

WORKDIR /app

# kluczowa zmiana: kopiujemy cały projekt
COPY . /app

RUN chmod +x /app/update.sh

EXPOSE 3000

CMD bash -c "/app/update.sh & python /app/app.py"
