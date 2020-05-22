from bokeh.models import Circle, ColumnDataSource, Plot, HoverTool, Legend, LegendItem
from bokeh.plotting import figure
from bokeh.tile_providers import Vendors, get_provider
from bokeh.resources import CDN
import pyproj
import requests

def merc(lon,lat):

    epsg3857 = pyproj.Proj(init='epsg:3857')
    wgs84 = pyproj.Proj(init='EPSG:4326')

    x, y = pyproj.transform(wgs84,epsg3857,lon,lat)
    
    return x,y

def get_map():
    x0, y0, xend, yend = [32.4], [0.01], [32.8], [0.5]
    mercx0, mercy0 = merc(x0, y0)
    mercxend, mercyend = merc(xend, yend)

    url = "https://europe-west3-airqo-250220.cloudfunctions.net/get_locations"

    locations = requests.get(url).json()

    locations["boda"]["x"], locations["boda"]["y"] = merc(locations["boda"]["longitude"], locations["boda"]["latitude"])
    locations["static"]["x"], locations["static"]["y"] = merc(locations["static"]["longitude"], locations["static"]["latitude"])

    # Get map tiles
    tile_provider = get_provider(Vendors.CARTODBPOSITRON)

    # Create ColumnDataSource from coordinates, sizes and predicted means
    boda_source = ColumnDataSource(dict(boda_id = locations["boda"]["id"],
                               boda_x = locations["boda"]["x"],
                               boda_y = locations["boda"]["y"],
                               boda_lon = locations["boda"]["longitude"],
                               boda_lat = locations["boda"]["latitude"]
                               ))

    static_source = ColumnDataSource(dict(static_id = locations["static"]["id"],
                               static_x = locations["static"]["x"],
                               static_y = locations["static"]["y"],
                               static_lon = locations["static"]["longitude"],
                               static_lat = locations["static"]["latitude"]))

    # Hover tools
    boda_hover = HoverTool(names=["boda"],
                           tooltips = [("Type", "Mobile"),
                                       ("Sensor ID", "@boda_id"),
                                       ("Lat/long", "@boda_lat, @boda_lon")])

    static_hover = HoverTool(names=["static"],
                             tooltips = [("Type", "Static"),
                                         ("Sensor ID", "@static_id"),
                                         ("Lat/long", "@static_lat, @static_lon")])

    # Plot figure and add tiles 
    scaled_map = figure(title=None, 
                        x_range=(mercx0[0], mercxend[0]), 
                        y_range=(mercy0[0], mercyend[0]),
                        x_axis_type="mercator", 
                        y_axis_type="mercator", 
                        tools = ["pan,wheel_zoom,box_zoom,reset", boda_hover, static_hover])

    scaled_map.add_tile(tile_provider)


    # Create and plot glyphs for predictions
    boda_glyph = Circle(x="boda_x", y="boda_y", size= 10, line_color="white", fill_color="green", fill_alpha=0.8, line_width=1, 
                    line_alpha=1)
    static_glyph = Circle(x="static_x", y="static_y", size= 10, line_color="white", fill_color="red", fill_alpha=0.8, line_width=1, 
                    line_alpha=1)

    r_boda = scaled_map.add_glyph(boda_source, boda_glyph, name="boda")
    r_static = scaled_map.add_glyph(static_source, static_glyph, name="static")
    
    # Create legend items and add to plot

    li = []
    li += [LegendItem(label='Mobile', renderers=[r_boda])]
    li += [LegendItem(label='Static', renderers=[r_static])]
    _legend = Legend(items = li)
    scaled_map.add_layout(_legend)
    scaled_map.legend.click_policy="hide"
    
    
    return scaled_map