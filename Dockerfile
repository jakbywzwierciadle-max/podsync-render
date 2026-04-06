FROM python:3.11-slim

# Instalujemy zależności systemowe: PHP, FFmpeg, Curl i Node.js
RUN apt-get update && apt-get install -y \
    php-cli \
    php-xml \
    ffmpeg \
    curl \
    && curl -sL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

# Instalujemy i aktualizujemy yt-dlp oraz Flask
RUN pip install --no-cache-dir -U yt-dlp Flask python-dotenv

WORKDIR /app

# Kopiujemy pliki projektu
COPY . /app

# Kluczowe: Naprawa końcówek linii i uprawnienia
RUN sed -i 's/\r$//' /app/update.sh && chmod +x /app/update.sh

# Tworzymy folder na pliki mp3
RUN mkdir -p /app/downloads

EXPOSE 3000

# Startujemy Flask i skrypt w tle
# Używamy gunicorn (jeśli masz zainstalowany) lub python3
CMD bash -c "python3 /app/app.py & (sleep 10 && /app/update.sh)"
