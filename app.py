from flask import Flask, send_from_directory
import os

app = Flask(__name__)
DATA_DIR = "/data"

@app.route("/feed.xml")
def feed():
    return send_from_directory(DATA_DIR, "feed.xml", mimetype="application/rss+xml")

@app.route("/<path:filename>")
def files(filename):
    return send_from_directory(DATA_DIR, filename)

@app.route("/")
def index():
    return "RSS: /feed.xml\n"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=3000)
