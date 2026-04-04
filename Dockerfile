FROM python:3.11-slim

# instalacja
RUN apt-get update && apt-get install -y ffmpeg curl

# yt-dlp
RUN pip install yt-dlp

# dir2cast (prosty serwer RSS)
RUN curl -L https://github.com/ben-xo/dir2cast/releases/latest/download/dir2cast-linux-amd64 -o /usr/local/bin/dir2cast \
    && chmod +x /usr/local/bin/dir2cast

WORKDIR /app

COPY start.sh .
RUN chmod +x start.sh

RUN mkdir /data

CMD ["./start.sh"]
