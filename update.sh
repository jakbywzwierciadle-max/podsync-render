#!/bin/bash

echo "=== Aktualizacja $(date) ==="

# Konfiguracja ścieżek
DATA_DIR="/data"
CHANNELS_FILE="/app/channels.txt"
COOKIES_FILE="/app/cookies.txt"

# Tworzenie folderu jeśli nie istnieje
mkdir -p "$DATA_DIR"

# 1. Cicha aktualizacja yt-dlp przez pip (rozwiązuje błąd "installed with pip")
echo "Aktualizacja narzędzi..."
pip install --upgrade pip yt-dlp --root-user-action=ignore > /dev/null 2>&1

# Sprawdzenie czy plik z kanałami istnieje
if [ ! -f "$CHANNELS_FILE" ]; then
    echo "Błąd: Plik $CHANNELS_FILE nie istnieje!"
    exit 1
fi

# 2. Pętla przetwarzająca kanały
while read -r URL || [ -n "$URL" ]; do
    # Czyszczenie URL ze znaków Windowsa i spacji
    URL=$(echo "$URL" | tr -d '\r' | xargs)
    [[ -z "$URL" || "$URL" =~ ^# ]] && continue

    echo "--- Pobieram z: $URL ---"

    # KOMENDA W JEDNEJ LINII (Zapobiega błędom "command not found" na Railway)
    # Ustawienia: android/ios (omijanie blokad), max 2 filmy, extract audio do mp3
    yt-dlp --cookies "$COOKIES_FILE" --user-agent "Mozilla/5.0 (iPhone; CPU iPhone OS 17_4 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4 Mobile/15E148 Safari/604.1" --extractor-args "youtube:player-client=android,ios;skip=webpage_signature" --force-ipv4 --no-check-certificate --match-filter "live_status != upcoming" -f "ba/b" --extract-audio --audio-format mp3 --audio-quality 0 --playlist-end 2 --no-warnings --ignore-errors --no-mtime --download-archive "$DATA_DIR/downloaded.txt" --output "$DATA_DIR/%(upload_date)s-%(title)s.%(ext)s" "$URL"

done < "$CHANNELS_FILE"

# 3. Generowanie RSS dla Podcastu
echo "Generuję RSS..."
if [ -f "/app/dir2cast.php" ]; then
    # Przekierowanie wyjścia do feed.xml
    php /app/dir2cast.php /app/dir2cast.ini > "$DATA_DIR/feed.xml"
    echo "Plik RSS został zaktualizowany."
else
    echo "Błąd: Nie znaleziono /app/dir2cast.php"
fi

echo "=== Zakończono: $(date) ==="
echo "=== Zakończono: $(date) ==="
