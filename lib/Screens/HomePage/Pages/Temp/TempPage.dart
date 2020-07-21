import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:location/location.dart' as MainLocation;
import 'package:flutter_google_places/flutter_google_places.dart';

import 'package:epox_flutter/Shared/Colors.dart';

class TempPage extends StatefulWidget {
  @override
  State<TempPage> createState() => TempPageState();
}

class TempPageState extends State<TempPage> {
  LatLng _initialPosition = LatLng(0, 0);
  MainLocation.Location _location = MainLocation.Location();
  Completer<GoogleMapController> _controller = Completer();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            zoomControlsEnabled: false,
            initialCameraPosition: CameraPosition(
              target: _initialPosition,
              zoom: 10,
            ),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            // myLocationEnabled: true,
            myLocationButtonEnabled: false,
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20.0,
                horizontal: 30,
              ),
              child: Align(
                alignment: Alignment.topCenter,
                child: Material(
                  child: InkWell(
                    onTap: _searchLocation,
                    splashColor: Grey,
                    child: Ink(
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      color: OffWhite,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Search Location...",
                            style: TextStyle(
                              color: LightGrey,
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
      floatingActionButton: FloatingActionButton(
        onPressed: _findSelf,
        backgroundColor: DarkBlue,
        foregroundColor: Orange,
        child: Icon(Icons.location_searching),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }

  void _findSelf() async {
    GoogleMapController _mapsController = await _controller.future;

    _location.onLocationChanged.listen((l) {
      _mapsController.animateCamera(
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
  }

  void _changeLocation({double latitude, double longitude}) async {
    GoogleMapController _mapsController = await _controller.future;

    _mapsController.animateCamera(
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
    );
    PlacesDetailsResponse response = await GoogleMapsPlaces(
      apiKey: "AIzaSyCrnGdAm_9aNxViu_CCMMyKvy7eKFtljwo",
    ).getDetailsByPlaceId(_prediction.placeId);

    // print(response.result.geometry.location);
    _changeLocation(
      latitude: response.result.geometry.location.lat,
      longitude: response.result.geometry.location.lng,
    );
  }
}
