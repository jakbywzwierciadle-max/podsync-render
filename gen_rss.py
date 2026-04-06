import os
import datetime

# Konfiguracja
DOWNLOAD_DIR = "downloads"
RSS_FILE = "feed.xml"
BASE_URL = "http://twoja-domena-na-railway.app/downloads/" # Zmień na swój adres Railway

rss_template = """<?xml version="1.0" encoding="UTF-8"?>
<rss version="2.0">
<channel>
    <title>Mój Podcast z Youtube</title>
    <link>{url}</link>
    <description>Automatyczny kanał RSS ze Spiżarni Wiary</description>
    {items}
</channel>
</rss>"""

item_template = """
    <item>
        <title>{title}</title>
        <enclosure url="{file_url}" length="{size}" type="audio/mpeg"/>
        <pubDate>{pub_date}</pubDate>
        <guid>{file_url}</guid>
    </item>"""

items_html = ""
if os.path.exists(DOWNLOAD_DIR):
    for filename in os.listdir(DOWNLOAD_DIR):
        if filename.endswith(".mp3"):
            file_path = os.path.join(DOWNLOAD_DIR, filename)
            file_url = BASE_URL + filename.replace(" ", "%20")
            size = os.path.getsize(file_path)
            # Data utworzenia pliku
            utime = os.path.getmtime(file_path)
            pub_date = datetime.datetime.fromtimestamp(utime).strftime('%a, %d %b %Y %H:%M:%S +0000')
            
            items_html += item_template.format(
                title=filename.replace(".mp3", ""),
                file_url=file_url,
                size=size,
                pub_date=pub_date
            )

with open(RSS_FILE, "w", encoding="utf-8") as f:
    f.write(rss_template.format(url=BASE_URL, items=items_html))

print("RSS Generated successfully.")
