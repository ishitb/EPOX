import 'package:epox_flutter/Screens/Authorization/OnBoarding.dart';
import 'Screens/HomePage/Pages/MainPage/MainPage.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

List<CameraDescription> cameras;

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print(e);
  }

  runApp(MaterialApp(
    title: 'Team: EPOX',
    initialRoute: '/',
    routes: {
      '/': (context) => OnBoarding(),
      '/main-page': (context) => MainPage(
            cameras: cameras,
          )
    },
    debugShowCheckedModeBanner: false,
  ));
}
