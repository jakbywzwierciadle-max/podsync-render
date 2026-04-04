#!/bin/bash

# Uruchamiamy aktualizację w tle
/app/update.sh &

# Uruchamiamy serwer Flask
python /app/app.py
