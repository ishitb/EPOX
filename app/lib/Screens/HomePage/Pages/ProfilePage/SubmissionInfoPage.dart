import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:epox_flutter/Shared/Colors.dart';
import 'package:epox_flutter/Shared/DelayedAnimation.dart';

class SubmissionInfoPage extends StatefulWidget {
  final String location, date, time, imageURL, comments;
  final double latitude, longitude, pci;
  final int status;

  SubmissionInfoPage({
    Key key,
    this.latitude,
    this.longitude,
    this.location,
    this.date,
    this.time,
    this.pci,
    this.status,
    this.imageURL,
    this.comments,
  }) : super(key: key);

  @override
  _SubmissionInfoPageState createState() => _SubmissionInfoPageState();
}

class _SubmissionInfoPageState extends State<SubmissionInfoPage>
    with SingleTickerProviderStateMixin {
  BitmapDescriptor markerIcon;

  void setCustomMapPin() async {
    BitmapDescriptor icon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/images/mapIcon.png');
    setState(() {
      markerIcon = icon;
    });
  }

  // Status Map
  List statusValue = [
    {
      'status': "Reported",
      'color': Colors.red[900],
    },
    {
      'status': "Working",
      'color': Orange,
    },
    {
      'status': "Resolved",
      'color': Colors.yellow[700],
    },
    {
      'status': "Spam",
      'color': Colors.green[800],
    },
  ];

  // Animation Stuff
  bool screenLoaded = false, severityLoader = false, startVoting = false;
  AnimationController _animationController;
  Animation _animation;

  @override
  void initState() {
    setCustomMapPin();

    _animationController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.ease,
    ));

    _animationController.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DarkBlue,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
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
                ),
              ],
            ),
            SizedBox(
              height: 15.0,
            ),
            Column(
              children: [
                DelayedAnimation(
                  delay: 600,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    margin:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                    decoration: BoxDecoration(
                      color: DarkBlue,
                      boxShadow: [
                        BoxShadow(
                          color: Black,
                          blurRadius: screenLoaded ? 10.0 : 0.0,
                          spreadRadius: screenLoaded ? 3.5 : 0.0,
                        ),
                      ],
                      border: Border.all(
                        color: Orange,
                        width: 2.0,
                      ),
                    ),
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
                  onEnd: () {
                    setState(() {
                      screenLoaded = true;
                    });
                  },
                ),
                // SizedBox(
                //   height: 10.0,
                // ),
                DelayedAnimation(
                  delay: 800,
                  onEnd: () {
                    setState(() {
                      severityLoader = true;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30.0,
                      vertical: 10.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AnimatedContainer(
                          padding: EdgeInsets.all(15.0),
                          duration: Duration(milliseconds: 500),
                          decoration: BoxDecoration(
                            color: DarkBlue,
                            boxShadow: [
                              BoxShadow(
                                color: Black,
                                blurRadius: severityLoader ? 10.0 : 0.0,
                                spreadRadius: severityLoader ? 3.5 : 0.0,
                              ),
                            ],
                            border: Border.all(
                              color: Orange,
                              width: 2.0,
                            ),
                          ),
                          height: MediaQuery.of(context).size.width / 2.5,
                          width: MediaQuery.of(context).size.width / 2.5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Severity".toUpperCase(),
                                style: TextStyle(
                                  color: Blue,
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.width / 4,
                                width: MediaQuery.of(context).size.width / 4,
                                child: Stack(
                                  children: [
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.width / 4,
                                      width:
                                          MediaQuery.of(context).size.width / 4,
                                      child: CircularProgressIndicator(
                                        value:
                                            widget.pci * _animation.value / 100,
                                        backgroundColor: DarkGrey,
                                        strokeWidth: 4.5,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          widget.pci * _animation.value < 20
                                              ? Colors.red[900]
                                              : widget.pci * _animation.value <
                                                      40
                                                  ? Orange
                                                  : widget.pci *
                                                              _animation.value <
                                                          60
                                                      ? Colors.yellow[700]
                                                      : widget.pci *
                                                                  _animation
                                                                      .value <
                                                              80
                                                          ? Colors.green[300]
                                                          : Colors.green[800],
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: Text(
                                        "${(widget.pci * _animation.value).toStringAsFixed(2)}%",
                                        style: TextStyle(
                                          fontSize: 24.0,
                                          color: widget.pci * _animation.value <
                                                  20
                                              ? Colors.red[900]
                                              : widget.pci * _animation.value <
                                                      40
                                                  ? Orange
                                                  : widget.pci *
                                                              _animation.value <
                                                          60
                                                      ? Colors.yellow[700]
                                                      : widget.pci *
                                                                  _animation
                                                                      .value <
                                                              80
                                                          ? Colors.green[300]
                                                          : Colors.green[800],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          onEnd: () {
                            _animationController.forward();
                          },
                        ),
                        AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          padding: EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                            color: DarkBlue,
                            boxShadow: [
                              BoxShadow(
                                color: Black,
                                blurRadius: severityLoader ? 10.0 : 0.0,
                                spreadRadius: severityLoader ? 3.5 : 0.0,
                              ),
                            ],
                            border: Border.all(
                              color: Orange,
                              width: 2.0,
                            ),
                          ),
                          height: MediaQuery.of(context).size.width / 2.5,
                          width: MediaQuery.of(context).size.width / 2.5,
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Icon(
                                  // FontAwesomeIcons.resolving,
                                  Icons.new_releases,
                                  size: 40.0,
                                  color: statusValue[widget.status]['color'],
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    statusValue[widget.status]['status'],
                                    style: TextStyle(
                                      color: statusValue[widget.status]
                                          ['color'],
                                      fontSize: 28.0,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    "Status of Report",
                                    style: TextStyle(
                                      color: Blue,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // SizedBox(
                //   height: 20.0,
                // ),
                DelayedAnimation(
                  delay: 1000,
                  onEnd: () {
                    setState(() {
                      startVoting = true;
                    });
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                    margin:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                    decoration: BoxDecoration(
                      color: DarkBlue,
                      boxShadow: [
                        BoxShadow(
                          color: Black,
                          blurRadius: screenLoaded ? 10.0 : 0.0,
                          spreadRadius: screenLoaded ? 3.5 : 0.0,
                        ),
                      ],
                      border: Border.all(
                        color: Orange,
                        width: 2.0,
                      ),
                    ),
                    child: Stack(
                      children: [
                        AnimatedPositioned(
                          duration: Duration(milliseconds: 400),
                          left: startVoting
                              ? 0
                              : MediaQuery.of(context).size.width,
                          // alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Icon(
                                Icons.thumb_up,
                                size: 45,
                                color: Colors.green[700],
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "69",
                                    style: TextStyle(
                                      color: OffWhite,
                                      fontSize: 24.0,
                                    ),
                                  ),
                                  Text(
                                    "Upvotes",
                                    style: TextStyle(
                                      color: Blue,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Center(
                          child: SizedBox(
                            height: 45.0,
                            width: 1.0,
                            child: Container(
                              color: Grey,
                            ),
                          ),
                        ),
                        AnimatedPositioned(
                          duration: Duration(milliseconds: 300),
                          right: startVoting
                              ? 0
                              : MediaQuery.of(context).size.width,
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "42",
                                    style: TextStyle(
                                      color: OffWhite,
                                      fontSize: 24.0,
                                    ),
                                  ),
                                  Text(
                                    "Downvotes",
                                    style: TextStyle(
                                      color: Blue,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Icon(
                                Icons.thumb_down,
                                size: 45,
                                color: Colors.red[700],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                DelayedAnimation(
                  delay: 1300,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    // padding:
                    //     EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                    margin:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                    decoration: BoxDecoration(
                      color: DarkBlue,
                      boxShadow: [
                        BoxShadow(
                          color: Black,
                          blurRadius: screenLoaded ? 10.0 : 0.0,
                          spreadRadius: screenLoaded ? 3.5 : 0.0,
                        ),
                      ],
                      border: Border.all(
                        color: Orange,
                        width: 2.0,
                      ),
                    ),
                    child: FadeInImage.assetNetwork(
                      image: widget.imageURL,
                      placeholder: 'assets/images/loader.gif',
                    ),
                  ),
                ),
                widget.comments == ""
                    ? Container()
                    : DelayedAnimation(
                        delay: 1000,
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 10.0),
                          margin: EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 10.0),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: DarkBlue,
                            boxShadow: [
                              BoxShadow(
                                color: Black,
                                blurRadius: screenLoaded ? 10.0 : 0.0,
                                spreadRadius: screenLoaded ? 3.5 : 0.0,
                              ),
                            ],
                            border: Border.all(
                              color: Orange,
                              width: 2.0,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Comments...",
                                style: TextStyle(
                                  color: Blue,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              Text(
                                widget.comments,
                                style: TextStyle(
                                  color: OffWhite,
                                  fontSize: 20.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
