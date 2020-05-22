from interpolate import interp, lonlat, getgrid
from flask import Flask, jsonify, request, render_template
from getmap import getmap
import numpy as np
from bokeh.embed import file_html
from bokeh.resources import CDN
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

@app.route('/')
def showmap():
    map = getmap()
    return file_html(map, CDN, "Kampala")

#app.run(host='localhost',port=5000)

#if __name__ == "__main__":
 #app.run(host='localhost',port=5000)