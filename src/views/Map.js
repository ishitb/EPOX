/*!

=========================================================
* Paper Dashboard React - v1.2.0
=========================================================

* Product Page: https://www.creative-tim.com/product/paper-dashboard-react
* Copyright 2020 Creative Tim (https://www.creative-tim.com)

* Licensed under MIT (https://github.com/creativetimofficial/paper-dashboard-react/blob/master/LICENSE.md)

* Coded by Creative Tim

=========================================================

* The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

*/
import React from "react";
// react plugin used to create google maps
import {
  withScriptjs,
  withGoogleMap,
  GoogleMap,
  Marker,
} from "react-google-maps";
// reactstrap components
import { Card, CardHeader, CardBody, Row, Col } from "reactstrap";
import firebaseDb from "../Firebase";
import MarkerClusterer from "react-google-maps/lib/components/addons/MarkerClusterer";

const sendtoDb = (e) => {
  var sev = Math.random() * 10;
  firebaseDb
    .collection("coords")
    .add({
      lat: e.latLng.lat(),
      lng: e.latLng.lng(),
      severity: sev,
    })
    .then(() => {
      console.log("inserted with severity=", sev);
    })
    .catch((err) => {
      if (err) console.log(err);
    });
};

// ! Remove later
const options = {
  imagePath:
    "https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/m",
};

function createKey(location) {
  return location.lat + location.lng;
}

// ! -------------------------->

const MapWrapper = withScriptjs(
  withGoogleMap((props) => (
    <GoogleMap
      onClick={(e) => sendtoDb(e)}
      defaultZoom={5}
      defaultCenter={{ lat: 20.593684, lng: 78.96288 }}
      defaultOptions={{
        scrollwheel: true, //we disable de scroll over the map, it is a really annoing when you scroll through page
        // styles: [
        //   {
        //     featureType: "water",
        //     stylers: [
        //       {
        //         saturation: 43,
        //       },
        //       {
        //         lightness: -11,
        //       },
        //       {
        //         hue: "#0088ff",
        //       },
        //     ],
        //   },
        //   {
        //     featureType: "road",
        //     elementType: "geometry.fill",
        //     stylers: [
        //       {
        //         hue: "#ff0000",
        //       },
        //       {
        //         saturation: -100,
        //       },
        //       {
        //         lightness: 99,
        //       },
        //     ],
        //   },
        //   {
        //     featureType: "road",
        //     elementType: "geometry.stroke",
        //     stylers: [
        //       {
        //         color: "#808080",
        //       },
        //       {
        //         lightness: 54,
        //       },
        //     ],
        //   },
        //   {
        //     featureType: "landscape.man_made",
        //     elementType: "geometry.fill",
        //     stylers: [
        //       {
        //         color: "#ece2d9",
        //       },
        //     ],
        //   },
        //   {
        //     featureType: "poi.park",
        //     elementType: "geometry.fill",
        //     stylers: [
        //       {
        //         color: "#ccdca1",
        //       },
        //     ],
        //   },
        //   {
        //     featureType: "road",
        //     elementType: "labels.text.fill",
        //     stylers: [
        //       {
        //         color: "#767676",
        //       },
        //     ],
        //   },
        //   {
        //     featureType: "road",
        //     elementType: "labels.text.stroke",
        //     stylers: [
        //       {
        //         color: "#ffffff",
        //       },
        //     ],
        //   },
        //   {
        //     featureType: "poi",
        //     stylers: [
        //       {
        //         visibility: "off",
        //       },
        //     ],
        //   },
        //   {
        //     featureType: "landscape.natural",
        //     elementType: "geometry.fill",
        //     stylers: [
        //       {
        //         visibility: "on",
        //       },
        //       {
        //         color: "#b8cb93",
        //       },
        //     ],
        //   },
        //   {
        //     featureType: "poi.park",
        //     stylers: [
        //       {
        //         visibility: "on",
        //       },
        //     ],
        //   },
        //   {
        //     featureType: "poi.sports_complex",
        //     stylers: [
        //       {
        //         visibility: "on",
        //       },
        //     ],
        //   },
        //   {
        //     featureType: "poi.medical",
        //     stylers: [
        //       {
        //         visibility: "on",
        //       },
        //     ],
        //   },
        //   {
        //     featureType: "poi.business",
        //     stylers: [
        //       {
        //         visibility: "simplified",
        //       },
        //     ],
        //   },
        // ],
      }}
    >
      {/* {
        <MarkerClusterer options={options}>
          {(clusterer) =>
            Object.keys(props.markers).map((id) => (
              <Marker
                key={createKey(props.markers[id])}
                position={(props.markers[id].lat, props.markers[id].lng)}
                clusterer={clusterer}
              />
            ))
          }
        </MarkerClusterer>
      } */}
      {Object.keys(props.markers).map((id) => (
        <Marker
          key={id}
          position={{ lat: props.markers[id].lat, lng: props.markers[id].lng }}
          icon={
            props.markers[id].severity < 5
              ? "https://projects.voanews.com/south-china-sea/img/map/icon-larger_dot--green.png"
              : "https://fossdroid.com/images/icons/com.eibriel.reddot.3.png"
          }
        ></Marker>
      ))}
    </GoogleMap>
  ))
);

class Map extends React.Component {
  constructor() {
    super();
    this.state = {
      markers: {},
    };
  }

  componentDidMount() {
    // firebaseDb.child("coords").on("value", (snapshot) => {
    //   var markers = { ...snapshot.val() };
    //   this.setState({
    //     markers: markers,
    //   });
    //   if (snapshot.val()) {
    //     Object.keys(markers).map((id) => {
    //       // console.log("lat:", markers[id].lat, " lng:", markers[id].lng);
    //     });
    //     // console.log("--------------------------------------------");
    //     // console.log(snapshot.val());
    //     // this.setState({markers: Object.keys(snapshot.val())})
    //   }
    // });
    firebaseDb
      .collection("coords")
      .get()
      .then((Snapshot) => {
        const coordData = Snapshot.docs.map((doc) => doc.data());
        // console.log(coordData);
        this.setState({ markers: coordData });
      });
  }

  render() {
    return (
      <>
        <div className="map-content">
          <Row>
            <Col md="12">
              {/* <Card>
                <CardHeader>Google maps</CardHeader>
                <CardBody> */}
              <div
                id="map"
                className="map"
                style={{
                  position: "relative",
                  height: "90vh",
                  // width: "100vw",
                  overflow: "hidden",
                }}
              >
                <MapWrapper
                  // googleMapURL="https://maps.googleapis.com/maps/api/js?key=AIzaSyBdyFZobgX03No-ewZbBjVxhuSx4yBW49U"
                  googleMapURL={
                    // "https://maps.googleapis.com/maps/api/js?key=AIzaSyC4R6AN7SmujjPUIGKdyao2Kqitzr1kiRg&v=3.exp&libraries=geometry,drawing,places&key=AIzaSyAyesbQMyKVVbBgKVi2g6VX7mop2z96jBo"
                    "https://maps.googleapis.com/maps/api/js?key=AIzaSyCrnGdAm_9aNxViu_CCMMyKvy7eKFtljwo&v=3.exp&libraries=geometry,drawing,places&key=AIzaSyCrnGdAm_9aNxViu_CCMMyKvy7eKFtljwo"
                  }
                  loadingElement={<div style={{ height: `100%` }} />}
                  containerElement={<div style={{ height: `100%` }} />}
                  mapElement={<div style={{ height: `100%` }} />}
                  markers={this.state.markers}
                />
              </div>
              {/* </CardBody>
              </Card> */}
            </Col>
          </Row>
        </div>
      </>
    );
  }
}

export default Map;
