import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:location/location.dart' as MainLocation;
import 'package:flutter_google_places/flutter_google_places.dart';

import 'package:epox_flutter/Shared/Colors.dart';

class MapPage extends StatefulWidget {
  final LatLng initialPosition;

  const MapPage({Key key, this.initialPosition}) : super(key: key);

  @override
  State<MapPage> createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  MainLocation.Location _location = MainLocation.Location();
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController _mapController;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  BitmapDescriptor markerIcon;

  LatLng markPos = LatLng(0.0, 0.0);

  bool _loading = false;

  @override
  void initState() {
    super.initState();

    setCustomMapPin();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void setCustomMapPin() async {
    markerIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/images/mapIcon.png');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Hero(
            tag: 'map',
            child: GoogleMap(
              zoomControlsEnabled: false,
              initialCameraPosition: CameraPosition(
                target: widget.initialPosition,
                zoom: 16,
              ),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
                setState(() {
                  _mapController = controller;
                });
                setState(() {
                  markPos = widget.initialPosition;
                });
              },
              markers: Set<Marker>.of(
                <Marker>[
                  Marker(
                    markerId: MarkerId("random"),
                    position: markPos,
                    icon: markerIcon,
                    // draggable: true,
                    infoWindow: InfoWindow(
                      title: "Location of the road",
                    ),
                    onDragEnd: (value) {
                      print(value);
                    },
                  )
                ],
              ),
              myLocationEnabled: false,
              onCameraMove: (position) {
                setState(() {
                  markPos = position.target;
                });
              },
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 30.0,
                horizontal: 10.0,
              ),
              child: Align(
                alignment: Alignment.topCenter,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: _searchLocation,
                    splashColor: Grey,
                    child: Ink(
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: DarkBlue,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Orange,
                          width: 2,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Search Location...",
                            style: TextStyle(
                              color: Orange,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _findSelf,
            backgroundColor: DarkBlue,
            foregroundColor: Orange,
            child: Icon(
              Icons.location_searching,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          FloatingActionButton(
            onPressed: _submit,
            backgroundColor: Orange,
            foregroundColor: DarkBlue,
            child: Icon(
              Icons.send,
            ),
          ),
        ],
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }

  void _findSelf() async {
    setState(() {
      _loading = true;
    });

    _location.getLocation().then((l) {
      _mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(
              l.latitude,
              l.longitude,
            ),
            zoom: 16,
          ),
        ),
      );
    });

    setState(() {
      _loading = false;
    });
  }

  void _changeLocation({double latitude, double longitude}) async {
    await _mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(
            latitude,
            longitude,
          ),
          zoom: 16,
        ),
      ),
    );
  }

  Future<void> _searchLocation() async {
    setState(() {
      _loading = true;
    });

    Prediction _prediction = await PlacesAutocomplete.show(
      context: context,
      apiKey: "AIzaSyCrnGdAm_9aNxViu_CCMMyKvy7eKFtljwo",
      mode: Mode.overlay,
      language: 'en',
      components: [
        new Component(
          Component.country,
          'in',
        ),
      ],
    ).whenComplete(() => null);

    if (_prediction != null) {
      PlacesDetailsResponse response = await GoogleMapsPlaces(
        apiKey: "AIzaSyCrnGdAm_9aNxViu_CCMMyKvy7eKFtljwo",
      ).getDetailsByPlaceId(_prediction.placeId);

      // print(response.result.geometry.location);
      _changeLocation(
        latitude: response.result.geometry.location.lat,
        longitude: response.result.geometry.location.lng,
      );
    }

    setState(() {
      _loading = false;
    });
  }

  void _submit() async {
    // _mapController.getVisibleRegion().then(
    //   (value) {
    //     double finalLat =
    //         (value.northeast.latitude + value.southwest.latitude) / 2;
    //     double finalLong =
    //         (value.northeast.longitude + value.southwest.longitude) / 2;
    //     print({finalLat, finalLong});
    //   },
    // );
    // await SubmissionModel(
    //   comments: "",
    //   latitude: 0.0,
    //   longitude: 120.04,
    //   date: "",
    //   time: "",
    //   severity: "",
    //   status: "",
    // ).newSubmission("uid");
    // print("done");
    Navigator.pop(context, markPos);
  }
}
