from flask import Flask, jsonify
from get_map import merc, get_map
from bokeh.embed import file_html
from bokeh.resources import CDN

app = Flask(__name__)

@app.route('/')
def showmap():
    map = get_map()
    return file_html(map, CDN, "Last Sensor Locations")