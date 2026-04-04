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
    # Usuwanie znaków Windows (\r) i zbędnych spacji
    URL=$(echo "$URL" | tr -d '\r' | xargs)
    [[ -z "$URL" || "$URL" =~ ^# ]] && continue

    echo "--- Przetwarzam: $URL ---"

    # KOMENDA W JEDNEJ LINII (Naprawia błąd "command not found")
    # Zmieniony player-client na ios,android (lepiej omija błędy formatu)
    yt-dlp --update --cookies "$COOKIES_FILE" --user-agent "Mozilla/5.0 (iPhone; CPU iPhone OS 17_4 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4 Mobile/15E148 Safari/604.1" --extractor-args "youtube:player-client=ios,android,web" --force-ipv4 --match-filter "live_status != upcoming" -f "ba/b" --extract-audio --audio-format mp3 --audio-quality 0 --playlist-end 2 --no-warnings --ignore-errors --no-mtime --download-archive "$DATA_DIR/downloaded.txt" --output "$DATA_DIR/%(upload_date)s-%(title)s.%(ext)s" "$URL"

done < "$CHANNELS_FILE"

echo "Generuję RSS..."
if [ -f "/app/dir2cast.php" ]; then
    php /app/dir2cast.php /app/dir2cast.ini > "$DATA_DIR/feed.xml"
    echo "RSS wygenerowany pomyślnie."
fi

echo "=== Zakończono: $(date) ==="

echo "Generuję RSS..."
# Upewnij się, że ścieżki w php są poprawne
php /app/dir2cast.php /app/dir2cast.ini > "$DATA_DIR/feed.xml"

echo "=== Zakończono ==="
