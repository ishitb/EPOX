import 'package:epox_flutter/Screens/HomePage/Pages/ProfilePage/UserSubmissions/Votes.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'MapBar.dart';
import 'package:epox_flutter/Screens/HomePage/Pages/ProfilePage/UserSubmissions/DateTimeInfo.dart';
import 'package:epox_flutter/Screens/HomePage/Pages/ProfilePage/UserSubmissions/Stats/Stats.dart';
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
      body: Column(
        children: [
          MapBar(
            latitude: widget.latitude,
            longitude: widget.longitude,
            location: widget.location,
            screenLoaded: screenLoaded,
          ),
          SizedBox(
            height: 15.0,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  DelayedAnimation(
                    delay: 600,
                    child: DateTimeInfo(
                      screenLoaded: screenLoaded,
                      date: widget.date,
                      time: widget.time,
                    ),
                    onEnd: () {
                      setState(() {
                        screenLoaded = true;
                      });
                    },
                  ),
                  DelayedAnimation(
                    delay: 800,
                    onEnd: () {
                      setState(() {
                        severityLoader = true;
                      });
                    },
                    child: Stats(
                      animation: _animation,
                      animationController: _animationController,
                      pci: widget.pci,
                      status: widget.status,
                      severityLoader: severityLoader,
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
                    child: Votes(
                      screenLoaded: screenLoaded,
                      startVoting: startVoting,
                    ),
                  ),
                  DelayedAnimation(
                    delay: 1300,
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      // padding:
                      //     EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                      margin: EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 10.0),
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
              ),
            ),
          )
        ],
      ),
    );
  }
}
