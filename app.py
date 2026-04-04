from flask import Flask, Response, send_from_directory
from feedgen.feed import FeedGenerator
import os

app = Flask(__name__)
DATA_DIR = "/data"

@app.route("/")
def index():
    return "RSS działa 🚀"

@app.route("/rss.xml")
def rss():
    fg = FeedGenerator()
    fg.title("YouTube Podcast")
    fg.link(href="http://localhost:3000/rss.xml", rel="self")
    fg.description("Auto RSS z YouTube (PL audio)")

    files = sorted(
        [f for f in os.listdir(DATA_DIR) if f.endswith(".mp3")],
        reverse=True
    )

    for file in files:
        fe = fg.add_entry()
        fe.title(file)

        url = f"{get_base_url()}/audio/{file}"
        fe.enclosure(url, 0, "audio/mpeg")

    return Response(fg.rss_str(pretty=True), mimetype="application/rss+xml")


@app.route("/audio/<path:filename>")
def audio(filename):
    return send_from_directory(DATA_DIR, filename)


def get_base_url():
    return "https://" + os.environ.get("RAILWAY_STATIC_URL", "localhost:3000")


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=3000)
