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
import React, { useState } from "react";
// react plugin used to create google maps
import {
  withScriptjs,
  withGoogleMap,
  GoogleMap,
  Marker,
  InfoWindow,
} from "react-google-maps";

// react-loading
import ReactLoading from "react-loading";

// reactstrap components
import { Card, CardHeader, CardBody, Row, Col } from "reactstrap";

// Custom components
import firebaseDb from "../Firebase";
import MarkerClusterer from "react-google-maps/lib/components/addons/MarkerClusterer";

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
  withGoogleMap((props) => {
    const [selectedMark, setMark] = useState();

    return (
      <GoogleMap
        // onClick={(e) => sendtoDb(e)}
        defaultZoom={5}
        defaultCenter={{ lat: 20.593684, lng: 78.96288 }}
        defaultOptions={{
          scrollwheel: true,
          // styles: [mapStyles],
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
        {props.markers.map((mark) => {
          return (
            <Marker
              key={mark.id}
              position={{
                lat: mark.latitude,
                lng: mark.longitude,
              }}
              icon={
                mark.pci < 5
                  ? "https://projects.voanews.com/south-china-sea/img/map/icon-larger_dot--green.png"
                  : "https://fossdroid.com/images/icons/com.eibriel.reddot.3.png"
              }
              onClick={() => {
                setMark(mark);
              }}
            ></Marker>
          );
        })}
        {selectedMark && (
          <InfoWindow
            position={{
              lat: selectedMark.latitude,
              lng: selectedMark.longitude,
            }}
            onCloseClick={() => setMark(null)}
          >
            {/* {console.log(selectedMark)} */}
            <div
              style={{
                width: "150px",
                height: "auto",
              }}
            >
              <p style={{ textAlign: "center", fontWeight: "700" }}>
                {selectedMark.username}
              </p>
              <a
                href={selectedMark.imageURL}
                target="_blank"
                rel="noopener noreferrer"
              >
                <img
                  src={selectedMark.imageURL}
                  style={{
                    maxWidth: "100%",
                    height: "auto",
                  }}
                />
              </a>
              <p style={{ textAlign: "center", marginTop: "10px" }}>
                {selectedMark.comments}
              </p>
            </div>
          </InfoWindow>
        )}
      </GoogleMap>
    );
  })
);

class Map extends React.Component {
  constructor() {
    super();
    this.state = {
      markers: [],
      selectedMarker: null,
    };
  }

  getMarkers = () => {
    firebaseDb
      .collection("submissions")
      .get()
      .then((Snapshot) => {
        const subData = Snapshot.docs.map((doc) => ({
          id: doc.id,
          ...doc.data(),
        }));
        // console.log("subdata is ", subData);
        this.setState({ markers: subData });
      });
  };

  componentDidMount() {
    this.getMarkers();
  }

  render() {
    return (
      <>
        <div className="map-content">
          <Row>
            <Col md="12">
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
            </Col>
          </Row>
        </div>
      </>
    );
  }
}

export default Map;
