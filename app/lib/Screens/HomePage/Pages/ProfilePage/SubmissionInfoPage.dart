import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:epox_flutter/Shared/Colors.dart';

class SubmissionInfoPage extends StatefulWidget {
  final String location, date, time;
  final double latitude, longitude, pci;

  SubmissionInfoPage(
      {Key key,
      this.latitude,
      this.longitude,
      this.location,
      this.date,
      this.time,
      this.pci})
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

    Future.delayed(Duration(milliseconds: 1000)).then((value) {
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
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Blue,
                  width: 2.5,
                ),
              ),
            ),
            height: MediaQuery.of(context).size.height / 2.5,
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
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30.0,
              vertical: 10.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  padding: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    color: DarkBlue,
                    boxShadow: [
                      BoxShadow(
                        color: DarkGrey,
                        blurRadius: screenLoaded ? 10.0 : 0.0,
                        spreadRadius: screenLoaded ? 5.0 : 0.0,
                      ),
                    ],
                  ),
                  height: 150,
                  width: 150,
                  child: Stack(
                    children: [
                      SizedBox(
                        height: 125,
                        width: 125,
                        child: CircularProgressIndicator(
                          value: 1 - widget.pci / 100,
                          backgroundColor: DarkGrey,
                          strokeWidth: 2.5,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            widget.pci < 20
                                ? Colors.red[900]
                                : widget.pci < 40
                                    ? Orange
                                    : widget.pci < 60
                                        ? Colors.yellow[700]
                                        : widget.pci < 80
                                            ? Colors.green[300]
                                            : Colors.green[800],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Severity".toUpperCase(),
                          style: TextStyle(
                            color: LightGrey,
                            fontSize: 22.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  padding: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    color: DarkBlue,
                    boxShadow: [
                      BoxShadow(
                        color: DarkGrey,
                        blurRadius: screenLoaded ? 10.0 : 0.0,
                        spreadRadius: screenLoaded ? 5.0 : 0.0,
                      ),
                    ],
                  ),
                  height: 150,
                  width: 150,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.bug_report,
                            color: Orange,
                            size: 30.0,
                          ),
                          Text(
                            "Reported",
                            style: TextStyle(
                              color: OffWhite,
                              fontSize: 22.0,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "Status of Report",
                        style: TextStyle(color: Blue, fontSize: 18.0),
                      ),
                    ],
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
