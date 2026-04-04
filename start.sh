#!/bin/bash

PLAYLIST_URL="https://www.youtube.com/channel/UCO6_hwMtQZ0SLElfDMaqJGQ"

mkdir -p /data

echo "=== Start RSS server ==="
python app.py &

while true; do
  echo "=== Pobieranie ==="

  yt-dlp \
    --cookies /app/cookies.txt \
    --sleep-requests 2 \
    --sleep-interval 2 \
    --max-sleep-interval 5 \
    -f "bestaudio[language=pl]" \
    -x --audio-format mp3 \
    --download-archive /data/archive.txt \
    -o "/data/%(upload_date)s-%(title)s.%(ext)s" \
    "$PLAYLIST_URL"

  echo "=== Czyszczenie (2 najnowsze) ==="
  ls -t /data/*.mp3 2>/dev/null | tail -n +3 | xargs -r rm --

  echo "=== Sleep 1h ==="
  sleep 3600
done
