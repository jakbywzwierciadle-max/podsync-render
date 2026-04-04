FROM python:3.11-slim

# system deps
RUN apt-get update && apt-get install -y \
    ffmpeg \
    curl \
    nodejs \
    && rm -rf /var/lib/apt/lists/*

# yt-dlp
RUN pip install yt-dlp

# dir2cast (konkretna wersja - stabilna)
RUN curl -L https://github.com/ben-xo/dir2cast/releases/download/v0.3.0/dir2cast-linux-amd64 \
    -o /usr/local/bin/dir2cast \
    && chmod +x /usr/local/bin/dir2cast

WORKDIR /app

COPY start.sh .
COPY cookies.txt .

RUN chmod +x start.sh

# dane
RUN mkdir /data

EXPOSE 3000

CMD ["./start.sh"]
