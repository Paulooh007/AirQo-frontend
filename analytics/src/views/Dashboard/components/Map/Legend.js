import { useLeaflet } from "react-leaflet";
import L from "leaflet";
import { useEffect } from "react";

const Legend = () => {
  const { map } = useLeaflet();
  console.log(map);

  useEffect(() => {
    // get color depending on population density value
        const legend = L.control({ position: "bottomright" });

    legend.onAdd = () => {
      const div = L.DomUtil.create("div", "legend");

    //   div.innerHTML += "<h4>Tegnforklaring</h4>";
      div.innerHTML += '<i style="background: #81202e"></img><span>Hazardous</span></i>';
      div.innerHTML += '<i style="background: #8639c0"><span>Very Unhealthy</span></i>';
      div.innerHTML += '<i style="background: #fe0023"><span>Unhealthy</span></i>';
      div.innerHTML += '<i style="background: #ee8327"><span>Unhealthy for sensitive groups</span></i>';
      div.innerHTML += '<j style="background: #f8fe39"><span>Moderate</span></j>';
      div.innerHTML += '<j style="background: #44e527"><span>Good</span></j>';
            
      //div.innerHTML += '<i class="icon" style="background-image: url(https://d30y9cdsu7xlg0.cloudfront.net/png/194515-200.png);background-repeat: no-repeat;"></i><span>Grænse</span><br>';
      return div;
    };   

    legend.addTo(map);
  });
  return null;
};

export default Legend;
