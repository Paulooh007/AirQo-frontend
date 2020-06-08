import React from "react";
import "./App.css";
import Header from "./components/Header";
import MapContainer from "./components/MapContainer";
import Filter from "./components/Filter";
import axios from "axios";
import "react-loader-spinner/dist/loader/css/react-spinner-loader.css";
import Loader from "react-loader-spinner";

class App extends React.Component {
  state = {
    earthquakeData: [],
    isLoaded: false,
  };
  fetchData = () => {
    axios
      .get(
        "https://analytcs-bknd-service-dot-airqo-250220.uc.r.appspot.com/api/v1/dashboard/monitoringsites?organisation_name=KCCA"
      )
      .then(({ data: { airquality_monitoring_sites } }) => {
        const selectedData = airquality_monitoring_sites.map((values) => {
          return {
            magnitude: values.Last_Hour_PM25_Value,
            place: values.Parish,
            time: values.LastHour,
            code: values.LocationCode,
            position:[
              values.Latitude,
              values.Longitude,
            ],    
            id: values.DeviceCode,
          };
        });

        this.setState({ earthquakeData: selectedData, isLoaded: true });
      });
  };

  componentDidMount = () => {
    this.fetchData();
  };

  fetchFilteredData = (magnitude) => {
    this.setState({ isLoaded: false }, () => {
      axios
        .get(
          `https://analytcs-bknd-service-dot-airqo-250220.uc.r.appspot.com/api/v1/dashboard/monitoringsites?organisation_name=KCCA`,
          {
            params: {
              magnitude: magnitude,
            },
          }
        )
        .then(({ data: { airquality_monitoring_sites } }) => {
          const selectedData = airquality_monitoring_sites.map((values) => {
            return {
              magnitude: values.Last_Hour_PM25_Value,
              place: values.Parish,
              time: values.LastHour,
              code: values.LocationCode,
              position: [
                values.Latitude,
                values.Longitude,
              ],
              id: values.DeviceCode,
            };
          });

          this.setState({ earthquakeData: selectedData, isLoaded: true });
        });
    });
  };


  render() {
    return (
      <main className="main">
        <div className="header-container">
          <Header />
        </div>
        <div className="map-container-main">
          <MapContainer earthquakeData={this.state.earthquakeData} />
          <Filter fetchFilteredData={this.fetchFilteredData} />
        </div>
        {this.state.isLoaded ? null : (
          <div className="loadingScreen">
            <h3 className="loadingScreen__h3">Loading...</h3>
            <Loader
              className="spinner"
              type="Circles"
              color="rgba(244, 157, 110, 1)"
            />
          </div>
        )}
      </main>
    );
  }
}

export default App;
