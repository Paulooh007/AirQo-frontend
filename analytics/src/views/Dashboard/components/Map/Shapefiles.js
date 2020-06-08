import React from "react";
import axios from "axios";
import {Map,TileLayer,Marker,Popup,GeoJSON as GeoJson} from "react-leaflet";

class App extends React.Component {
  state = {
    earthquakeData: [],
    isLoaded: false,
  };
  fetchData = () => {
    axios
      .get(
        "./greater_kampala_parishes.json"
      )
      .then(({ data: { features } }) => {
        const selectedData = features.map((quake) => {
          return {
            id: quake.properties.OBJECTID,
            parish: quake.properties.PARISH,
            area:quake.properties.Shape_Area,
            type:quake.geometry.Polygon,
            cordinates:quake.geometry.coordinates
           
          };
        });
        this.setState({ earthquakeData: selectedData, isLoaded: true });
      });
  };

  componentDidMount = () => {
    this.fetchData();
  };

  render() {
    return (
        <ShapeFile earthquakeData={this.earthquakeData} onEachFeature={this.onEachFeature} isArrayBufer={true}/>
        //<MapContainer earthquakeData={this.state.earthquakeData} />
      
     
    );
  }
}

export default App;

   
   

      