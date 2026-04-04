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
    # Usuń znaki powrotu karetki (Windows) i pomijaj komentarze
    URL=$(echo "$URL" | tr -d '\r' | xargs)
    [[ -z "$URL" || "$URL" =~ ^# ]] && continue

    echo "--- Przetwarzam: $URL ---"

    # CAŁA KOMENDA W JEDNEJ LINII - to kluczowe na Railway
    yt-dlp --update --cookies "$COOKIES_FILE" --user-agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/123.0 Safari/537.36" --extractor-args "youtube:player-client=android,ios,web" --force-ipv4 --match-filter "live_status != upcoming" -f "ba/b" --extract-audio --audio-format mp3 --audio-quality 0 --playlist-end 2 --no-warnings --ignore-errors --no-mtime --download-archive "$DATA_DIR/downloaded.txt" --output "$DATA_DIR/%(upload_date)s-%(title)s.%(ext)s" "$URL"

done < "$CHANNELS_FILE"

echo "Generuję RSS..."
if [ -f "/app/dir2cast.php" ]; then
    php /app/dir2cast.php /app/dir2cast.ini > "$DATA_DIR/feed.xml"
    echo "RSS wygenerowany pomyślnie."
fi

echo "=== Zakończono: $(date) ==="

echo "Generuję RSS..."
if [ -f "/app/dir2cast.php" ]; then
    php /app/dir2cast.php /app/dir2cast.ini > "$DATA_DIR/feed.xml"
    echo "RSS wygenerowany pomyślnie."
fi

echo "=== Zakończono: $(date) ==="
        "$URL"

done < "$CHANNELS_FILE"

echo "Generuję RSS..."
# Generowanie pliku XML dla czytników podcastów
if [ -f "/app/dir2cast.php" ]; then
    php /app/dir2cast.php /app/dir2cast.ini > "$DATA_DIR/feed.xml"
    echo "RSS wygenerowany pomyślnie."
else
    echo "Błąd: Nie znaleziono dir2cast.php"
fi

echo "=== Zakończono: $(date) ==="
        --no-mtime \
        --output "$DATA_DIR/%(upload_date)s-%(title)s.%(ext)s" \
        "$URL"

done < "$CHANNELS_FILE"

echo "Generuję RSS..."
# Upewnij się, że ścieżki w php są poprawne
php /app/dir2cast.php /app/dir2cast.ini > "$DATA_DIR/feed.xml"

echo "=== Zakończono ==="
