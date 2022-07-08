import React from "react";
import MarkerManager from "../../util/marker_manager";

class BenchMap extends React.Component{

    componentDidMount() {
        console.log("component did mount")
        // set the map to show SF
        const mapOptions = {
            center: { lat: 37.7758, lng: -122.435 }, // this is SF
            zoom: 13
        };

        // wrap this.mapNode in a Google Map
        this.map = new google.maps.Map(this.mapNode, mapOptions);

        // this.map = new google.maps.Map(mapDOMNode, mapOptions);
        this.MarkerManager = new MarkerManager(this.map);
        this.MarkerManager.updateMarkers(this.props.benches)
    }

    componentDidUpdate(){
        console.log("component did update")
        this.MarkerManager.updateMarkers(this.props.benches)
    }

    render(){
        return (

                <div id='map-container' ref={map => this.mapNode = map}></div>
        )

    }

}
export default BenchMap;