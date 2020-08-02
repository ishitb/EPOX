import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:epox_flutter/Shared/Colors.dart';

class SubmissionInfoPage extends StatefulWidget {
  final String location, date, time;
  final double latitude, longitude;

  SubmissionInfoPage(
      {Key key,
      this.latitude,
      this.longitude,
      this.location,
      this.date,
      this.time})
      : super(key: key);

  @override
  _SubmissionInfoPageState createState() => _SubmissionInfoPageState();
}

class _SubmissionInfoPageState extends State<SubmissionInfoPage> {
  BitmapDescriptor markerIcon;
  bool screenLoaded = false;

  void setCustomMapPin() async {
    BitmapDescriptor icon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/images/mapIcon.png');
    setState(() {
      markerIcon = icon;
    });
  }

  @override
  void initState() {
    setCustomMapPin();

    Future.delayed(Duration(milliseconds: 700)).then((value) {
      setState(() {
        screenLoaded = true;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DarkBlue,
      body: Column(
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 400),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Blue,
                  width: 2.5,
                ),
              ),
            ),
            height:
                screenLoaded ? MediaQuery.of(context).size.height / 2.5 : 0.0,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(widget.latitude, widget.longitude),
                zoom: 16,
              ),
              zoomControlsEnabled: false,
              onMapCreated: (GoogleMapController controller) {},
              markers: Set<Marker>.of(
                <Marker>[
                  Marker(
                    markerId: MarkerId("random"),
                    position: LatLng(widget.latitude, widget.longitude),
                    icon: markerIcon,
                  )
                ],
              ),
            ),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 500),
            height: screenLoaded ? 70 : 0,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Blue,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(15),
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
                      widget.location,
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
          SizedBox(
            height: 15.0,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            decoration: BoxDecoration(
                border: Border.all(
              color: Orange,
              width: 2.0,
            )),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: 30,
                          color: Orange,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          widget.date,
                          style: TextStyle(
                            fontSize: 20,
                            color: OffWhite,
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          widget.time,
                          style: TextStyle(
                            fontSize: 20,
                            color: OffWhite,
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Icon(
                          Icons.access_time,
                          size: 30,
                          color: Orange,
                        )
                      ],
                    ),
                  ],
                ),
                Divider(
                  height: 30,
                  color: Grey,
                ),
                Text(
                  "Reported on",
                  style: TextStyle(
                    color: Blue,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
