#!/bin/bash

PLAYLIST_URL="https://www.youtube.com/channel/UCO6_hwMtQZ0SLElfDMaqJGQ"

mkdir -p /data

# uruchom RSS server w tle
dir2cast /data --port 3000 &

# loop
while true; do
  echo "=== Pobieranie ==="

  yt-dlp -f "bestaudio[language=pl]" \
    -x --audio-format mp3 \
    --download-archive /data/archive.txt \
    -o "/data/%(upload_date)s-%(title)s.%(ext)s" \
    "$PLAYLIST_URL"

  echo "=== Czyszczenie ==="

  ls -t /data/*.mp3 2>/dev/null | tail -n +21 | xargs -r rm --

  echo "=== Sleep ==="
  sleep 3600
done
