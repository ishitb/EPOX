import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:epox_flutter/Shared/Colors.dart';

class MapBar extends StatelessWidget {
  final double latitude, longitude;
  final BitmapDescriptor markerIcon;
  final String location;
  final bool screenLoaded;

  const MapBar(
      {Key key,
      this.latitude,
      this.longitude,
      this.markerIcon,
      this.location,
      this.screenLoaded})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 2.5,
          child: GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(latitude, longitude),
              zoom: 16,
            ),
            zoomControlsEnabled: false,
            onMapCreated: (GoogleMapController controller) {},
            markers: Set<Marker>.of(
              <Marker>[
                Marker(
                  markerId: MarkerId("random"),
                  position: LatLng(latitude, longitude),
                  icon: markerIcon,
                )
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 500),
            height: screenLoaded ? 70 : 0,
            // height: _animation.value * 100,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Blue.withOpacity(0.9),
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(15),
              ),
              border: Border.all(
                color: DarkBlue,
                width: 2.5,
              ),
            ),
            // padding: EdgeInsets.only(left: 15.0),
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Center(
                child: Wrap(
                  alignment: WrapAlignment.start,
                  children: [
                    Text(
                      "Location:  ",
                      style: TextStyle(
                        color: LightGrey,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      location,
                      style: TextStyle(
                        color: OffWhite,
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
