#!/bin/bash

# --- KONFIGURACJA ---
CHANNELS_FILE="channels.txt"
COOKIES_FILE="cookies.txt"
DATA_DIR="downloads"
RSS_OUTPUT="feed.xml"

echo "=== Start Aktualizacji: $(date) ==="

# Tworzenie folderu na dane
mkdir -p "$DATA_DIR"

# Sprawdzenie czy plik z kanałami istnieje
if [ ! -f "$CHANNELS_FILE" ]; then
    echo "BŁĄD: Nie znaleziono pliku $CHANNELS_FILE"
    exit 1
fi

# 1. POBIERANIE WIDEO/AUDIO
while read -r URL || [ -n "$URL" ]; do
    [[ -z "$URL" || "$URL" =~ ^# ]] && continue

    echo "--- Pobieranie: $URL ---"

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

# 2. GENEROWANIE RSS
echo "Generuję RSS..."

if [ -f "/app/dir2cast.php" ]; then
    php /app/dir2cast.php /app/dir2cast.ini > "$DATA_DIR/$RSS_OUTPUT"
    echo "Plik feed.xml został zaktualizowany."
else
    echo "Błąd: Nie znaleziono /app/dir2cast.php"
fi

echo "=== Zakończono: $(date) ==="
