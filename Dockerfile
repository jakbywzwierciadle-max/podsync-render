FROM python:3.11-slim

# Instalujemy zależności: PHP, FFmpeg, Curl oraz NODEJS
RUN apt-get update && apt-get install -y \
    php-cli \
    php-xml \
    ffmpeg \
    curl \
    nodejs \
    && rm -rf /var/lib/apt/lists/*

# Aktualizacja yt-dlp
RUN pip install --no-cache-dir -U yt-dlp Flask python-dotenv

WORKDIR /app
COPY . /app

RUN sed -i 's/\r$//' /app/update.sh && chmod +x /app/update.sh
RUN sed -i 's/\r$//' /app/start.sh && chmod +x /app/start.sh

EXPOSE 3000
CMD ["/app/start.sh"]
