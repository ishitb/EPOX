import 'package:epox_flutter/Services/Authentication/AuthProvider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:epox_flutter/Shared/Colors.dart';

class ProfileAppBar extends StatelessWidget {
  final PageController mainPageController;

  const ProfileAppBar({Key key, this.mainPageController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthProvider _auth = AuthProvider();

    return SafeArea(
      child: Container(
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FlatButton.icon(
              onPressed: () {
                _auth.signOut();
              },
              icon: FaIcon(
                Icons.arrow_back,
                color: OffWhite,
                size: 30,
              ),
              label: Text(
                "Logout",
                style: TextStyle(
                  color: OffWhite,
                  fontSize: 18,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: InkWell(
                onTap: () {
                  print("Back");
                  mainPageController.animateToPage(
                    1,
                    duration: Duration(milliseconds: 400),
                    curve: Curves.easeIn,
                  );
                },
                child: Row(
                  children: [
                    Text(
                      "Camera",
                      style: TextStyle(
                        color: OffWhite,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Icon(
                      // FontAwesomeIcons.cameraRetro,
                      Icons.switch_camera,
                      color: OffWhite,
                      size: 30,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
