#!/bin/bash

echo "=== Aktualizacja $(date) ==="

# Konfiguracja ścieżek
DATA_DIR="/data"
CHANNELS_FILE="/app/channels.txt"
COOKIES_FILE="/app/cookies.txt"

# Tworzenie folderu danych, jeśli nie istnieje
mkdir -p "$DATA_DIR"

# 1. WYMUSZONA AKTUALIZACJA (Naprawia błędy "tab page" i "pip version")
# Używamy --root-user-action=ignore, aby uniknąć ostrzeżeń o uprawnieniach
echo "Aktualizacja yt-dlp do najnowszej wersji..."
pip install --upgrade pip yt-dlp --root-user-action=ignore > /dev/null 2>&1

# Sprawdzenie czy plik z kanałami istnieje
if [ ! -f "$CHANNELS_FILE" ]; then
    echo "Błąd: Plik $CHANNELS_FILE nie istnieje!"
    exit 1
fi

# 2. PĘTLA PRZETWARZAJĄCA KANAŁY
while read -r URL || [ -n "$URL" ]; do
    # Usuwanie znaków Windows (\r) i zbędnych spacji
    URL=$(echo "$URL" | tr -d '\r' | xargs)
    [[ -z "$URL" || "$URL" =~ ^# ]] && continue

    echo "--- Przetwarzam: $URL ---"

    # KOMENDA W JEDNEJ LINII (Kluczowe na Railway, zapobiega błędom składni)
    # Parametry: 
    # - player-client=android,ios (omija blokady formatów audio)
    # - compat-options no-youtube-unavailable-videos (stabilizuje listy odtwarzania)
    # - ba/b (najlepsze audio lub najmniejsze wideo jako zapas)
    yt-dlp --cookies "$COOKIES_FILE" --user-agent "Mozilla/5.0 (iPhone; CPU iPhone OS 17_4 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4 Mobile/15E148 Safari/604.1" --extractor-args "youtube:player-client=android,ios;skip=webpage_signature" --compat-options no-youtube-unavailable-videos --force-ipv4 --no-check-certificate --match-filter
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
