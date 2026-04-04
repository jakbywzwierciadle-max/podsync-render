#!/bin/bash

echo "=== Aktualizacja $(date) ==="

DATA_DIR="/data"
CHANNELS_FILE="/app/channels.txt"
COOKIES_FILE="/app/cookies.txt"

mkdir -p "$DATA_DIR"

# Aktualizacja bez ostrzeżeń o koncie root
echo "Aktualizacja yt-dlp..."
pip install --upgrade yt-dlp --root-user-action=ignore

if [ ! -f "$CHANNELS_FILE" ]; then
    echo "Błąd: Plik $CHANNELS_FILE nie istnieje!"
    exit 1
fi

while read -r URL || [ -n "$URL" ]; do
    URL=$(echo "$URL" | tr -d '\r' | xargs)
    [[ -z "$URL" || "$URL" =~ ^# ]] && continue

    echo "--- Przetwarzam: $URL ---"

    # CAŁA KOMENDA W JEDNEJ LINII - to gwarantuje brak błędów "command not found"
    yt-dlp --cookies "$COOKIES_FILE" --user-agent "Mozilla/5.0 (iPhone; CPU iPhone OS 17_4 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4 Mobile/15E148 Safari/604.1" --extractor-args "youtube:player-client=android,ios;skip=webpage_signature" --force-ipv4 --no-check-certificate --match-filter "live_status != upcoming" -f "ba/b" --extract-audio --audio-format mp3 --audio-quality 0 --playlist-end 2 --no-warnings --ignore-errors --no-mtime --download-archive "$DATA_DIR/downloaded.txt" --output "$DATA_DIR/%(upload_date)s-%(title)s.%(ext)s" "$URL"

done < "$CHANNELS_FILE"

echo "Generuję RSS..."
if [ -f "/app/dir2cast.php" ]; then
    php /app/dir2cast.php /app/dir2cast.ini > "$DATA_DIR/feed.xml"
    echo "RSS wygenerowany pomyślnie."
fi

echo "=== Zakończono: $(date) ==="
