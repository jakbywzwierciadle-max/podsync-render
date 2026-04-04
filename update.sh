#!/usr/bin/env bash
set -e

DATA_DIR=/data
MAX_SIZE_MB=400
CHANNELS_FILE=/app/channels.txt

mkdir -p "$DATA_DIR"

download_new() {
  while read -r line; do
    [[ -z "$line" || "$line" =~ ^# ]] && continue

    echo "Pobieram z: $line"

    yt-dlp \
      -f "ba[language=pl]/bestaudio[language=pl]/bestaudio" \
      --playlist-end 2 \
      --max-downloads 2 \
      --dateafter now-7days \
      --extractor-args "youtube:player_client=android" \
      --ignore-errors \
      --no-overwrites \
      --add-metadata \
      --embed-thumbnail \
      -o "$DATA_DIR/%(upload_date)s - %(title)s.%(ext)s" \
      "$line"

  done < "$CHANNELS_FILE"
}

cleanup_old() {
  echo "Sprawdzam rozmiar katalogu..."
  while :; do
    SIZE_MB=$(du -sm "$DATA_DIR" | cut -f1)
    if [ "$SIZE_MB" -le "$MAX_SIZE_MB" ]; then
      echo "Rozmiar OK: ${SIZE_MB}MB <= ${MAX_SIZE_MB}MB"
      break
    fi

    OLDEST_FILE=$(ls -1t "$DATA_DIR" | tail -n 1)
    echo "Za dużo (${SIZE_MB}MB). Usuwam: $OLDEST_FILE"
    rm -f "$DATA_DIR/$OLDEST_FILE"
  done
}

generate_feed() {
  echo "Generuję RSS..."
  php /app/dir2cast.php /app/dir2cast.ini > "$DATA_DIR/feed.xml"
}

main_loop() {
  while :; do
    echo "=== Aktualizacja $(date) ==="
    download_new
    cleanup_old
    generate_feed
    echo "Czekam 30 minut..."
    sleep 1800
  done
}

main_loop
