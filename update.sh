#!/bin/bash

echo "=== Aktualizacja $(date) ==="

# Konfiguracja ścieżek
DATA_DIR="/data"
CHANNELS_FILE="/app/channels.txt"
COOKIES_FILE="/app/cookies.txt"

# Tworzenie folderu danych, jeśli nie istnieje
mkdir -p "$DATA_DIR"

# 1. AKTUALIZACJA NARZĘDZI
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
    
    # Pominięcie pustych linii i komentarzy
    [[ -z "$URL" || "$URL" =~ ^# ]] && continue

    echo "--- Przetwarzam: $URL ---"

    # KOMENDA ZOPTYMALIZOWANA:
    # 1. extractor-args: dodano 'web', aby uniknąć błędów rozpoznawania tablicy filmów
    # 2. user-agent: zmieniony na bardziej standardowy dla lepszej kompatybilności
    yt-dlp \
        --cookies "$COOKIES_FILE" \
        --user-agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.
