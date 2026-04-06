FROM python:3.11-slim

# Instalujemy zależności systemowe: PHP, FFmpeg, Curl
RUN apt-get update && apt-get install -y \
    php-cli \
    php-xml \
    ffmpeg \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Instalujemy i aktualizujemy yt-dlp oraz Flask
RUN pip install --no-cache-dir -U yt-dlp Flask python-dotenv

WORKDIR /app

# Kopiujemy pliki projektu
COPY . /app

# Naprawa końcówek linii i uprawnienia
RUN sed -i 's/\r$//' /app/update.sh && chmod +x /app/update.sh
RUN sed -i 's/\r$//' /app/start.sh && chmod +x /app/start.sh

EXPOSE 3000

# Startujemy przez start.sh (najbardziej stabilne)
CMD ["/app/start.sh"]
