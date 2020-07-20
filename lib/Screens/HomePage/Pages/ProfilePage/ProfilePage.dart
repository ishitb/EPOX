import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';

import 'package:epox_flutter/Services/Authentication/AuthProvider.dart';
import 'package:epox_flutter/Services/Authentication/UserModel.dart';

import 'package:epox_flutter/Shared/Colors.dart';

class ProfilePage extends StatefulWidget with WidgetsBindingObserver {
  ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  double longitude = 0, latitude = 0;
  bool loading = false, locationServicesEnabled = true;

  final AuthProvider _auth = AuthProvider();

  Future<Position> _getCurrentLocation() async {
    setState(() {
      loading = true;
    });
    bool geoLocationStatus = await Geolocator().isLocationServiceEnabled();

    if (geoLocationStatus) {
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

      setState(() {
        longitude = position.longitude;
        latitude = position.latitude;
        loading = false;
      });
      return position;
    } else {
      locationServicesEnabled = false;
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    // _getCurrentLocation();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    final snapshots = Provider.of<QuerySnapshot>(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: Scaffold(
            body: Center(
          child: loading
              ? CircularProgressIndicator()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Latitude: $latitude, Longitude: $longitude"),
                    RaisedButton(
                      child: Text(
                        "Get Location",
                        style: TextStyle(
                          color: OffWhite,
                          fontSize: 24,
                        ),
                      ),
                      color: Theme.of(context).accentColor,
                      onPressed: () async {
                        _getCurrentLocation();
                      },
                    ),
                    RaisedButton(
                      child: Text("LogOut"),
                      onPressed: () {
                        _auth.signOut();
                      },
                    ),
                    Text(user.email)
                    // TextField(
                    //   onTap: () async {
                    //     Prediction p = await PlacesAutocomplete.show(
                    //       context: context,
                    //       apiKey: 'AIzaSyBVS0np5RpJWLFxEcIY78uHgA23tP4IZZ0',
                    //       mode: Mode.overlay, // Mode.fullscreen
                    //       language: "en",
                    //       components: [
                    //         new Component(Component.country, "in"),
                    //       ],
                    //     );
                    //     print(p);
                    //   },
                    // ),
                  ],
                ),
        )),
      ),
    );
  }
}
