import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:epox_flutter/Services/Authentication/UserModel.dart';

import 'package:epox_flutter/Screens/Authorization/OnBoarding.dart';
import 'package:epox_flutter/Screens/HomePage/HomePage.dart';
import 'package:epox_flutter/Screens/HomePage/Pages/Temp/TempPage.dart';

class Wrapper extends StatelessWidget {
  final cameras;

  const Wrapper({Key key, this.cameras}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);

    return user == null
        ? OnBoarding()
        // : HomePage(
        //     cameras: cameras,
        //   );
        : TempPage();
  }
}
