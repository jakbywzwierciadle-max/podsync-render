#!/bin/bash

# --- KONFIGURACJA ---
CHANNELS_FILE="channels.txt"
COOKIES_FILE="cookies.txt"
DATA_DIR="downloads"         # Sprawdź czy używasz 'downloads' czy 'data'
RSS_OUTPUT="feed.xml"

echo "=== Start Aktualizacji: $(date) ==="

# Tworzenie folderu na dane, jeśli nie istnieje
mkdir -p "$DATA_DIR"

# Sprawdzenie czy plik z kanałami istnieje
if [ ! -f "$CHANNELS_FILE" ]; then
    echo "BŁĄD: Nie znaleziono pliku $CHANNELS_FILE"
    exit 1
fi

# 1. POBIERANIE WIDEO/AUDIO
while read -r URL || [ -n "$URL" ]; do
    # Pomijaj puste linie i komentarze
    [[ -z "$URL" || "$URL" =~ ^# ]] && continue

    echo "--- Pobieranie: $URL ---"

    # Uruchomienie yt-dlp z poprawionymi flagami
    yt-dlp \
        --cookies "$COOKIES_FILE" \
        --user-agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36" \
        --extractor-args "youtube:player-client=web,mweb" \
        --force-ipv4 \
        --no-check-certificate \
        --match-filter "live_status != upcoming & live_status != was_live" \
        --extract-audio \
        --audio-format mp3 \
        --audio-quality 0 \
        --playlist-end 3 \
        --ignore-errors \
        --no-mtime \
        --add-metadata \
        --restrict-filenames \
        --download-archive "$DATA_DIR/downloaded.txt" \
        --output "$DATA_DIR/%(upload_date)s-%(title)s.%(ext)s" \
        "$URL"

done < "$CHANNELS_FILE"

# 2. GENEROWANIE RSS (Python lub PHP - wybierz właściwe dla swojego projektu)
echo "Generuję RSS..."

# Jeśli używasz skryptu Python:
if [ -f "gen_rss.py" ]; then
    python3 gen_rss.py
    echo "RSS wygenerowany przez Python."
fi

# Jeśli używasz dir2cast (PHP):
if [ -f "/app/dir2cast.php" ]; then
    php /app/dir2cast.php /app/dir2cast.ini > "$DATA_DIR/$RSS_OUTPUT"
    echo "RSS wygenerowany przez dir2cast (PHP)."
fi

echo "=== Zakończono: $(date) ==="
        --no-check-certificate \
        --no-cache-dir \
        --match-filter "live_status != upcoming & live_status != was_live" \
        -f "ba/b" \
        --extract-audio \
        --audio-format mp3 \
        --audio-quality 0 \
        --playlist-end 3 \
        --ignore-errors \
        --no-warnings \
        --no-mtime \
        --add-metadata \
        --restrict-filenames \
        --download-archive "$DATA_DIR/downloaded.txt" \
        --output "$DATA_DIR/%(upload_date)s-%(title)s.%(ext)s" \
        "$URL"

done < "$CHANNELS_FILE"

# 3. GENEROWANIE RSS DLA PODCASTU
echo "Generuję RSS..."
if [ -f "/app/dir2cast.php" ]; then
    # Uruchomienie skryptu PHP
    php /app/dir2cast.php /app/dir2cast.ini > "$DATA_DIR/feed.xml"
    echo "Plik feed.xml został zaktualizowany."
else
    echo "Błąd: Nie znaleziono /app/dir2cast.php"
fi

echo "=== Zakończono: $(date) ==="
    yt-dlp \
        --cookies "$COOKIES_FILE" \
        --user-agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36" \
        --extractor-args "youtube:player-client=web,mweb" \
        --force-ipv4 \
        --no-check-certificate \
        --match-filter "live_status != upcoming & live_status != was_live" \
        -f "ba/b" \
        --extract-audio \
        --audio-format mp3 \
        --audio-quality 0 \
        --playlist-end 3 \
        --ignore-errors \
        --no-warnings \
        --no-mtime \
        --add-metadata \
        --restrict-filenames \
        --download-archive "$DATA_DIR/downloaded.txt" \
        --output "$DATA_DIR/%(upload_date)s-%(title)s.%(ext)s" \
        "$URL"

done < "$CHANNELS_FILE"

# 3. GENEROWANIE RSS DLA PODCASTU
echo "Generuję RSS..."
if [ -f "/app/dir2cast.php" ]; then
    # Uruchomienie skryptu PHP i zapisanie wyniku do feed.xml
    php /app/dir2cast.php /app/dir2cast.ini > "$DATA_DIR/feed.xml"
    echo "Plik feed.xml został zaktualizowany."
else
    echo "Błąd: Nie znaleziono /app/dir2cast.php"
fi

echo "=== Zakończono: $(date) ==="
    # - Zmieniono player-client na web,mweb (ios często powoduje brak formatów przy audio)
    # - Dodano --restrict-filenames dla bezpieczeństwa RSS
    yt-dlp \
        --cookies "$COOKIES_FILE" \
        --user-agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36" \
        --extractor-args "youtube:player-client=web,mweb" \
        --force-ipv4 \
        --no-check-certificate \
        --match-filter "live_status != upcoming & live_status != was_live" \
        -f "ba/b" \
        --extract-audio \
        --audio-format mp3 \
        --audio-quality 0 \
        --playlist-end 3 \
        --ignore-errors \
        --no-warnings \
        --no-mtime \
        --add-metadata \
        --restrict-filenames \
        --download-archive "$DATA_DIR/downloaded.txt" \
        --output "$DATA_DIR/%(upload_date)s-%(title)s.%(ext)s" \
        "$URL"

done < "$CHANNELS_FILE"

# 3. GENEROWANIE RSS DLA PODCASTU
echo "Generuję RSS..."
if [ -f "/app/dir2cast.php" ]; then
    # Uruchomienie skryptu PHP i przekierowanie wyjścia do pliku feed
    # Upewnij się, że dir2cast jest skonfigurowany pod folder /data
    php /app/dir2cast.php /app/dir2cast.ini > "$DATA_DIR/feed.xml"
    echo "Plik feed.xml został zaktualizowany."
else
    echo "Błąd: Nie znaleziono /app/dir2cast.php"
fi

echo "=== Zakończono: $(date) ==="
