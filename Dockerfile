FROM python:3.11-slim

# Instalujemy wszystkie potrzebne pakiety, w tym php-xml (DOMDocument)
RUN apt-get update && apt-get install -y \
    php-cli php-xml ffmpeg nodejs \
    && rm -rf /var/lib/apt/lists/*

# Instalujemy yt-dlp i Flask
RUN pip install yt-dlp Flask

# Ustawiamy katalog roboczy
WORKDIR /app

# Mechanizm wymuszający rebuild przy każdej zmianie
ARG CACHE_BUST=1

# Kopiujemy cały projekt — Railway nie może użyć cache
COPY . /app

# Ustawiamy prawa do skryptu aktualizującego
RUN chmod +x /app/update.sh

# Otwieramy port 3000
EXPOSE 3000

# Uruchamiamy update.sh i serwer Flask
CMD bash -c "/app/update.sh & python /app/app.py"
