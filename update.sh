#!/bin/bash

echo "=== Aktualizacja $(date) ==="

DATA_DIR="/data"
CHANNELS_FILE="/app/channels.txt"
COOKIES_FILE="/app/cookies.txt"

mkdir -p "$DATA_DIR"

while IFS= read -r URL; do
    [[ -z "$URL" || "$URL" =~ ^# ]] && continue

    echo "Pobieram z: $URL"


        yt-dlp \
        --cookies "$COOKIES_FILE" \
        --user-agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/123.0 Safari/537.36" \
        --force-ipv4 \
        -f "bestaudio[ext=m4a]/bestaudio/best" \
        --extract-audio \
        --audio-format mp3 \
        --audio-quality 0 \
        --playlist-end 1 \
        --match-filter "!is_live & !was_live & duration > 30" \
        --no-warnings \
        --ignore-errors \
        --add-header "Accept-Language:en-US,en;q=0.9" \
        --output "$DATA_DIR/%(upload_date)s-%(title)s.%(ext)s" \
        "$URL"
    

done < "$CHANNELS_FILE"

echo "Generuję RSS..."
php /app/dir2cast.php /app/dir2cast.ini > "$DATA_DIR/feed.xml"

echo "=== Zakończono ==="
