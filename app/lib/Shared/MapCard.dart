import 'package:epox_flutter/Screens/HomePage/Pages/AllSubmissions/MapInfo2.dart';
import 'package:epox_flutter/Screens/HomePage/Pages/ProfilePage/MapInfoCard.dart';
import 'package:epox_flutter/Screens/HomePage/Pages/ProfilePage/UserSubmissions/SubmissionInfoPage.dart';
import 'package:flutter/material.dart';

import 'package:epox_flutter/Shared/Colors.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapCard extends StatefulWidget {
  final double longitude, latitude, pci;
  final int status, upvotes, downvotes;
  final String imageURL, location, date, comments, time, id, uid;
  final bool all;
  final List userUpVoted, userDownVoted;

  MapCard({
    Key key,
    this.longitude,
    this.latitude,
    this.pci,
    this.status,
    this.imageURL,
    this.location,
    this.date,
    this.time,
    this.comments,
    this.all,
    this.upvotes,
    this.downvotes,
    this.userUpVoted,
    this.id,
    this.uid,
    this.userDownVoted,
  }) : super(key: key);

  @override
  _MapCardState createState() => _MapCardState();
}

class _MapCardState extends State<MapCard> {
  BitmapDescriptor markerIcon;

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 345,
      height: 300,
      decoration: BoxDecoration(
        border: Border.all(
          color: Blue,
          width: 2.5,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(13),
              child: Stack(
                children: [
                  GoogleMap(
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
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      splashColor: Orange,
                      onTap: () async {
                        FocusScope.of(context).unfocus();
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return SubmissionInfoPage(
                            latitude: widget.latitude,
                            longitude: widget.longitude,
                            location: widget.location,
                            date: widget.date,
                            time: widget.time,
                            pci: widget.pci,
                            status: widget.status,
                            imageURL: widget.imageURL,
                            comments: widget.comments,
                            upvotes: widget.upvotes,
                            downvotes: widget.downvotes,
                          );
                        }));
                      },
                      // child: Ink(
                      //     // height: _height / 3.5,
                      //     // width: _width,
                      //     ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: widget.all
                  ? MapInfoCard2(
                      date: widget.date,
                      location: widget.location,
                      userUpVoted: widget.userUpVoted,
                      userDownVoted: widget.userDownVoted,
                      id: widget.id,
                      uid: widget.uid,
                    )
                  : MapInfoCard(
                      date: widget.date,
                      location: widget.location,
                    ),
            )
          ],
        ),
      ),
    );
  }
}
