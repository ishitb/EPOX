import 'dart:io';

import 'package:epox_flutter/Services/Databases/UserDatabase.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:epox_flutter/Screens/HomePage/Pages/Map/MapPage.dart';
import 'package:epox_flutter/Services/Authentication/UserModel.dart';
import 'package:epox_flutter/Services/Databases/SubmissionProvider.dart';
import 'package:epox_flutter/Shared/Colors.dart';
import 'package:epox_flutter/Shared/Decorations.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as MainLocation;

class SubmitionPage extends StatefulWidget {
  final File imageFile;

  SubmitionPage({
    Key key,
    this.imageFile,
  }) : super(key: key);

  @override
  _SubmitionPageState createState() => _SubmitionPageState();
}

class _SubmitionPageState extends State<SubmitionPage> {
  LatLng userPos;
  GoogleMapController _mapController;
  BitmapDescriptor markerIcon;
  bool _loading = true, _uploading = false;
  String comments = "";

  void _findSelf() async {
    MainLocation.Location _location = MainLocation.Location();

    _location.getLocation().then((l) {
      setState(() {
        userPos = LatLng(l.latitude, l.longitude);
      });
    });

    setState(() {
      _loading = false;
    });
  }

  void setCustomMapPin() async {
    BitmapDescriptor icon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/images/mapIcon.png');
    setState(() {
      markerIcon = icon;
    });
  }

  @override
  void initState() {
    _findSelf();
    setCustomMapPin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);

    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;

    return StreamBuilder<UserDataModel>(
        stream: UserDatabase(uid: user.uid).userData,
        builder: (context, snapshot) {
          return Scaffold(
            backgroundColor: DarkGrey,
            appBar: AppBar(
              backgroundColor: DarkBlue.withOpacity(0.8),
              title: Text(
                "Submit new query",
                style: TextStyle(
                  color: Orange,
                  fontSize: 26.0,
                ),
              ),
              elevation: 0.0,
            ),
            body: !snapshot.hasData
                ? Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Orange,
                      ),
                    ),
                  )
                : SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15.0,
                        horizontal: 20.0,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Image.file(
                              widget.imageFile,
                              height: _height / 4,
                            ),
                            TextField(
                              decoration: textInputDecoration.copyWith(
                                hintText: "Comments...",
                              ),
                              style: TextStyle(
                                color: OffWhite,
                                fontSize: 18.0,
                              ),
                              maxLines: 5,
                              onChanged: (value) {
                                setState(() {
                                  comments = value;
                                });
                              },
                            ),
                            Hero(
                              tag: 'map',
                              child: Container(
                                height: _height / 3.5,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Blue,
                                    width: 2.5,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(13),
                                  child: Stack(
                                    children: [
                                      userPos == null
                                          ? Center(
                                              child: CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(Orange),
                                              ),
                                            )
                                          : GoogleMap(
                                              initialCameraPosition:
                                                  CameraPosition(
                                                target: userPos,
                                                zoom: 15,
                                              ),
                                              zoomControlsEnabled: false,
                                              onMapCreated: (GoogleMapController
                                                  controller) {
                                                setState(() {
                                                  _mapController = controller;
                                                });
                                              },
                                              markers: Set<Marker>.of(
                                                <Marker>[
                                                  Marker(
                                                    markerId:
                                                        MarkerId("random"),
                                                    position: userPos,
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

                                            var changed_pos = await showDialog(
                                              context: context,
                                              builder: (context) => MapPage(
                                                initialPosition: userPos,
                                              ),
                                            );

                                            await _mapController.animateCamera(
                                              CameraUpdate.newCameraPosition(
                                                CameraPosition(
                                                  target:
                                                      changed_pos ?? userPos,
                                                  zoom: 15,
                                                ),
                                              ),
                                            );
                                            setState(() {
                                              userPos = changed_pos ?? userPos;
                                            });
                                          },
                                          child: Ink(
                                            height: _height / 3.5,
                                            width: _width,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Material(
                              color: Orange,
                              borderRadius: BorderRadius.circular(15),
                              child: _uploading
                                  ? Container(
                                      height: 55,
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  DarkBlue),
                                        ),
                                      ),
                                    )
                                  : InkWell(
                                      splashColor: DarkBlue,
                                      borderRadius: BorderRadius.circular(15),
                                      onTap: () async {
                                        setState(() {
                                          _uploading = true;
                                        });

                                        UserDataModel userData = snapshot.data;

                                        DocumentReference newSubmissionID =
                                            await _submitQuery(
                                          user.uid,
                                          widget.imageFile,
                                          user.email,
                                          userData.name,
                                        );

                                        await _updateUserInfo(
                                          user.uid,
                                          newSubmissionID,
                                          userData,
                                        );
                                        Navigator.pop(context);
                                      },
                                      child: Ink(
                                        height: 55,
                                        width: _width,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: Orange,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Submit",
                                              // "Go Back",
                                              style: TextStyle(
                                                color: OffWhite,
                                                fontSize: 18,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Icon(
                                              Icons.send,
                                              color: OffWhite,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
          );
        });
  }

  Future<DocumentReference> _submitQuery(
      String uid, File imageFile, String userEmail, String userName) async {
    DocumentReference docID = await SubmissionProvider().newSubmission(
      uid: uid,
      userEmail: userEmail,
      username: userName,
      comments: comments,
      latitude: userPos.latitude,
      longitude: userPos.longitude,
      imageFile: imageFile,
    );
    return docID;
  }

  Future<void> _updateUserInfo(
      String uid, DocumentReference docID, UserDataModel userData) async {
    await SubmissionProvider().updateUserInfo(
      uid,
      docID,
      userData,
    );
    setState(() {
      _uploading = false;
    });
  }
}
