FROM python:3.11-slim

# 1. Instalujemy zależności systemowe, w tym NODEJS
RUN apt-get update && apt-get install -y \
    php-cli \
    php-xml \
    ffmpeg \
    curl \
    nodejs \
    && rm -rf /var/lib/apt/lists/*

# 2. Instalujemy i wymuszamy najnowszą wersję yt-dlp
RUN pip install --no-cache-dir -U yt-dlp Flask python-dotenv

WORKDIR /app

# 3. Kopiujemy pliki projektu
COPY . /app

# 4. Naprawa końcówek linii (ważne przy pracy na Windows) i uprawnienia
RUN sed -i 's/\r$//' /app/update.sh && chmod +x /app/update.sh
RUN sed -i 's/\r$//' /app/start.sh && chmod +x /app/start.sh

EXPOSE 3000

CMD ["/app/start.sh"]
