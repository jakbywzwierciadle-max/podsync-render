FROM python:3.11-slim

RUN apt-get update && apt-get install -y \
    ffmpeg \
    curl \
    nodejs \
    && rm -rf /var/lib/apt/lists/*

RUN pip install yt-dlp flask feedgen

WORKDIR /app

COPY start.sh .
COPY app.py .
COPY cookies.txt .

RUN chmod +x start.sh

RUN mkdir /data

EXPOSE 3000

CMD ["./start.sh"]
