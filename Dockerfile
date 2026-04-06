FROM python:3.11-slim

# Instalujemy zależności systemowe
# Dodajemy curl, aby móc pobrać nowszą wersję Node.js jeśli zajdzie potrzeba
RUN apt-get update && apt-get install -y \
    php-cli \
    php-xml \
    ffmpeg \
    curl \
    && curl -sL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

# Instalujemy yt-dlp i Flask
# Dodajemy python-dotenv na prośbę z logów
RUN pip install --no-cache-dir yt-dlp Flask python-dotenv

WORKDIR /app

# Kopiujemy pliki projektu
COPY . /app

# Naprawa końcówek linii (bardzo ważne, jeśli edytujesz na Windows/Telefonie)
# Usuwa ukryte znaki \r, które psują skrypty bash
RUN sed -i 's/\r$//' /app/update.sh && chmod +x /app/update.sh

EXPOSE 3000

# Poprawiony start: najpierw Flask (żeby Railway nie ubił kontenera za brak bindowania portu),
# a potem update w tle po krótkiej pauzie.
CMD bash -c "python3 /app/app.py & (sleep 5 && /app/update.sh)"
