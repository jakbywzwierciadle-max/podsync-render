#!/bin/bash

echo "=== Aktualizacja $(date) ==="

DATA_DIR="/data"
CHANNELS_FILE="/app/channels.txt"
COOKIES_FILE="/app/cookies.txt"

mkdir -p "$DATA_DIR"

if [ ! -f "$CHANNELS_FILE" ]; then
    echo "Błąd: Plik $CHANNELS_FILE nie istnieje!"
    exit 1
fi

while read -r URL || [ -n "$URL" ]; do
    URL=$(echo "$URL" | tr -d '\r' | xargs)
    [[ -z "$URL" || "$URL" =~ ^# ]] && continue

    echo "--- Przetwarzam: $URL ---"

    # ZMIANA: Wywalamy 'web' z klientów, zostawiamy tylko urządzenia mobilne i TV
    # Dodajemy --no-check-certificate na wypadek problemów z SSL na Railway
    yt-dlp --update-to nightly \
        --cookies "$COOKIES_FILE" \
        --user-agent "Mozilla/5.0 (Android 14; Mobile; rv:124.0) Gecko/124.0 Firefox/124.0" \
        --extractor-args "youtube:player-client=android,ios,tv;skip=webpage_signature" \
        --force-ipv4 \
        --no-check-certificate \
        --match-filter "live_status != upcoming" \
        -f "bestaudio/best" \
        --extract-audio \
        --audio-format mp3 \
        --audio-quality 0 \
        --playlist-end 2 \
        --no-warnings \
        --ignore-errors \
        --no-mtime \
        --download-archive "$DATA_DIR/downloaded.txt" \
        --output "$DATA_DIR/%(upload_date)s-%(title)s.%(ext)s" \
        "$URL"

done < "$CHANNELS_FILE"

echo "Generuję RSS..."
if [ -f "/app/dir2cast.php" ]; then
    php /app/dir2cast.php /app/dir2cast.ini > "$DATA_DIR/feed.xml"
    echo "RSS wygenerowany pomyślnie."
fi

echo "=== Zakończono: $(date) ==="

echo "=== Zakończono: $(date) ==="
