#!/bin/bash

echo "=== Aktualizacja $(date) ==="

DATA_DIR="/data"
CHANNELS_FILE="/app/channels.txt"
COOKIES_FILE="/app/cookies.txt"

mkdir -p "$DATA_DIR"

# Sprawdź czy pliki istnieją, żeby uniknąć błędów na starcie
[ ! -f "$CHANNELS_FILE" ] && echo "Błąd: Brak pliku $CHANNELS_FILE" && exit 1

while IFS= read -r URL || [ -n "$URL" ]; do
    [[ -z "$URL" || "$URL" =~ ^# ]] && continue

    echo "Pobieram z: $URL"

    # ZMIANY:
    # 1. Poprawiony format: "bestaudio/best" bez zbędnych spacji.
    # 2. Usunięto sztywne ID (18, 22), które często nie pasują do audio-only.
    # 3. Dodano --update, aby yt-dlp zawsze był aktualny (kluczowe przy błędach pobierania).
    
    yt-dlp \
        --update \
        --cookies "$COOKIES_FILE" \
        --user-agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/123.0 Safari/537.36" \
        --extractor-args "youtube:player-client=web,android,ios" \
        --force-ipv4 \
        -f "bestaudio/best" \
        --extract-audio \
        --audio-format mp3 \
        --audio-quality 0 \
        --playlist-end 1 \
        --no-warnings \
        --ignore-errors \
        --no-mtime \
        --output "$DATA_DIR/%(upload_date)s-%(title)s.%(ext)s" \
        "$URL"

done < "$CHANNELS_FILE"

echo "Generuję RSS..."
# Upewnij się, że ścieżki w php są poprawne
php /app/dir2cast.php /app/dir2cast.ini > "$DATA_DIR/feed.xml"

echo "=== Zakończono ==="
