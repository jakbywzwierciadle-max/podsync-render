#!/bin/bash

echo "=== DIAGNOSTYKA ŚRODOWISKA RAILWAY ==="
echo "Data: $(date)"

# 1. Sprawdzenie FFmpeg
echo -e "\n[1/3] Sprawdzanie FFmpeg:"
if command -v ffmpeg >/dev/null 2>&1; then
    ffmpeg -version | head -n 1
    echo "STATUS: FFmpeg jest zainstalowany."
else
    echo "STATUS: BŁĄD - Brak FFmpeg! Bez tego yt-dlp nie stworzy pliku MP3."
fi

# 2. Sprawdzenie wersji yt-dlp
echo -e "\n[2/3] Sprawdzanie yt-dlp:"
yt-dlp --version
python3 -m pip install --upgrade yt-dlp --root-user-action=ignore > /dev/null 2>&1
echo "Po aktualizacji:"
yt-dlp --version

# 3. Test formatów dla konkretnego filmu
# Używamy filmu, który sprawiał problemy
TEST_ID="9OMhmX7nf6I"
COOKIES_FILE="/app/cookies.txt"

echo -e "\n[3/3] Próba odczytu formatów dla $TEST_ID:"

if [ -f "$COOKIES_FILE" ]; then
    echo "Plik cookies.txt znaleziony. Próbuję z ciasteczkami..."
    yt-dlp --cookies "$COOKIES_FILE" --list-formats "$TEST_ID"
else
    echo "UWAGA: Brak pliku $COOKIES_FILE! Próbuję bez ciasteczek..."
    yt-dlp --list-formats "$TEST_ID"
fi

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
