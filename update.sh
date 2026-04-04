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
        --extractor-args "youtube:player_client=web,web_creator,android,ios,tv" \
        --force-ipv4 \
        -f "bestaudio* / bestaudio / best / 18 / 22" \
        --extract-audio \
        --audio-format mp3 \
        --audio-quality 0 \
        --playlist-end 1 \
        --no-warnings \
        --ignore-errors \
        --output "$DATA_DIR/%(upload_date)s-%(title)s.%(ext)s" \
        "$URL"

done < "$CHANNELS_FILE"

echo "Generuję RSS..."
php /app/dir2cast.php /app/dir2cast.ini > "$DATA_DIR/feed.xml"

echo "=== Zakończono ==="
