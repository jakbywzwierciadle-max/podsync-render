#!/bin/bash

echo "=== Aktualizacja $(date) ==="

DATA_DIR="/data"
CHANNELS_FILE="/app/channels.txt"
COOKIES_FILE="/app/cookies.txt"

mkdir -p "$DATA_DIR"

while IFS= read -r URL; do
    # Pomijamy puste linie i komentarze
    [[ -z "$URL" || "$URL" =~ ^# ]] && continue

    echo "Pobieram z: $URL"

    yt-dlp \
        --cookies "$COOKIES_FILE" \
        --extract-audio \
        --audio-quality 0 \
        --playlist-end 1 \
        --match-filter "!is_live" \
        --no-warnings \
        --output "$DATA_DIR/%(upload_date)s-%(title)s.%(ext)s" \
        "$URL"

done < "$CHANNELS_FILE"

echo "Generuję RSS..."
php /app/dir2cast.php /app/dir2cast.ini > "$DATA_DIR/feed.xml"

echo "=== Zakończono ==="
