#!/bin/bash

echo "=== Aktualizacja $(date) ==="

# Konfiguracja ścieżek
DATA_DIR="/data"
CHANNELS_FILE="/app/channels.txt"
COOKIES_FILE="/app/cookies.txt"

mkdir -p "$DATA_DIR"

# 1. AKTUALIZACJA NARZĘDZI
echo "Aktualizacja yt-dlp..."
python3 -m pip install --upgrade pip yt-dlp --root-user-action=ignore > /dev/null 2>&1

if [ ! -f "$CHANNELS_FILE" ]; then
    echo "Błąd: Plik $CHANNELS_FILE nie istnieje!"
    exit 1
fi

# 2. PĘTLA PRZETWARZAJĄCA KANAŁY
while read -r URL || [ -n "$URL" ]; do
    URL=$(echo "$URL" | tr -d '\r' | xargs)
    [[ -z "$URL" || "$URL" =~ ^# ]] && continue

    echo "--- Przetwarzam: $URL ---"

    # KOMENDA YT-DLP W JEDNEJ LINII (ZAPOBIEGA BŁĘDOM SKŁADNI)
    yt-dlp --cookies "$COOKIES_FILE" --user-agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36" --extractor-args "youtube:player-client=web,mweb" --force-ipv4 --no-check-certificate --match-filter "live_status != upcoming & live_status != was_live" -f "ba/b" --extract-audio --audio-format mp3 --audio-quality 0 --playlist-end 3 --ignore-errors --no-warnings --no-mtime --add-metadata --restrict-filenames --download-archive "$DATA_DIR/downloaded.txt" --output "$DATA_DIR/%(upload_date)s-%(title)s.%(ext)s" "$URL"

done < "$CHANNELS_FILE"

# 3. GENEROWANIE RSS DLA PODCASTU
echo "Generuję RSS..."
if [ -f "/app/dir2cast.php" ]; then
    php /app/dir2cast.php /app/dir2cast.ini > "$DATA_DIR/feed.xml"
    echo "Plik feed.xml został zaktualizowany."
else
    echo "Błąd: Nie znaleziono /app/dir2cast.php"
fi

echo "=== Zakończono: $(date) ==="
        --audio-format mp3 \
        --audio-quality 0 \
        --playlist-end 3 \
        --ignore-errors \
        --no-warnings \
        --no-mtime \
        --add-metadata \
        --restrict-filenames \
        --download-archive "$DATA_DIR/downloaded.txt" \
        --output "$DATA_DIR/%(upload_date)s-%(title)s.%(ext)s" \
        "$URL"

done < "$CHANNELS_FILE"

# 3. GENEROWANIE RSS
echo "Generuję RSS..."
if [ -f "/app/dir2cast.php" ]; then
    php /app/dir2cast.php /app/dir2cast.ini > "$DATA_DIR/feed.xml"
    echo "Plik feed.xml został zaktualizowany."
else
    echo "Błąd: Nie znaleziono /app/dir2cast.php"
fi

echo "=== Zakończono: $(date) ==="
echo -e "\n=== KONIEC DIAGNOSTYKI ==="
        --force-ipv4 \
        --no-check-certificate \
        --no-cache-dir \
        --match-filter "live_status != upcoming & live_status != was_live" \
        -f "ba/b" \
        --extract-audio \
        --audio-format mp3 \
        --audio-quality 0 \
        --playlist-end 3 \
        --ignore-errors \
        --no-warnings \
        --no-mtime \
        --add-metadata \
        --restrict-filenames \
        --download-archive "$DATA_DIR/downloaded.txt" \
        --output "$DATA_DIR/%(upload_date)s-%(title)s.%(ext)s" \
        "$URL"

done < "$CHANNELS_FILE"

# 3. GENEROWANIE RSS DLA PODCASTU
echo "Generuję RSS..."
if [ -f "/app/dir2cast.php" ]; then
    # Uruchomienie skryptu PHP
    php /app/dir2cast.php /app/dir2cast.ini > "$DATA_DIR/feed.xml"
    echo "Plik feed.xml został zaktualizowany."
else
    echo "Błąd: Nie znaleziono /app/dir2cast.php"
fi

echo "=== Zakończono: $(date) ==="
    yt-dlp \
        --cookies "$COOKIES_FILE" \
        --user-agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36" \
        --extractor-args "youtube:player-client=web,mweb" \
        --force-ipv4 \
        --no-check-certificate \
        --match-filter "live_status != upcoming & live_status != was_live" \
        -f "ba/b" \
        --extract-audio \
        --audio-format mp3 \
        --audio-quality 0 \
        --playlist-end 3 \
        --ignore-errors \
        --no-warnings \
        --no-mtime \
        --add-metadata \
        --restrict-filenames \
        --download-archive "$DATA_DIR/downloaded.txt" \
        --output "$DATA_DIR/%(upload_date)s-%(title)s.%(ext)s" \
        "$URL"

done < "$CHANNELS_FILE"

# 3. GENEROWANIE RSS DLA PODCASTU
echo "Generuję RSS..."
if [ -f "/app/dir2cast.php" ]; then
    # Uruchomienie skryptu PHP i zapisanie wyniku do feed.xml
    php /app/dir2cast.php /app/dir2cast.ini > "$DATA_DIR/feed.xml"
    echo "Plik feed.xml został zaktualizowany."
else
    echo "Błąd: Nie znaleziono /app/dir2cast.php"
fi

echo "=== Zakończono: $(date) ==="
    # - Zmieniono player-client na web,mweb (ios często powoduje brak formatów przy audio)
    # - Dodano --restrict-filenames dla bezpieczeństwa RSS
    yt-dlp \
        --cookies "$COOKIES_FILE" \
        --user-agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36" \
        --extractor-args "youtube:player-client=web,mweb" \
        --force-ipv4 \
        --no-check-certificate \
        --match-filter "live_status != upcoming & live_status != was_live" \
        -f "ba/b" \
        --extract-audio \
        --audio-format mp3 \
        --audio-quality 0 \
        --playlist-end 3 \
        --ignore-errors \
        --no-warnings \
        --no-mtime \
        --add-metadata \
        --restrict-filenames \
        --download-archive "$DATA_DIR/downloaded.txt" \
        --output "$DATA_DIR/%(upload_date)s-%(title)s.%(ext)s" \
        "$URL"

done < "$CHANNELS_FILE"

# 3. GENEROWANIE RSS DLA PODCASTU
echo "Generuję RSS..."
if [ -f "/app/dir2cast.php" ]; then
    # Uruchomienie skryptu PHP i przekierowanie wyjścia do pliku feed
    # Upewnij się, że dir2cast jest skonfigurowany pod folder /data
    php /app/dir2cast.php /app/dir2cast.ini > "$DATA_DIR/feed.xml"
    echo "Plik feed.xml został zaktualizowany."
else
    echo "Błąd: Nie znaleziono /app/dir2cast.php"
fi

echo "=== Zakończono: $(date) ==="
