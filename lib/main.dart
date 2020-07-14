import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:camera/camera.dart';
import 'package:epox_flutter/Screens/Authorization/OnBoarding.dart';

import 'Screens/HomePage/HomePage.dart';
import 'Services/Localization/AppLocalizations.dart';

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
        '/home-page': (context) => HomePage(
              cameras: cameras,
            )
      },
      debugShowCheckedModeBanner: false,

      // Language Changing
      supportedLocales: [
        Locale('hi', 'IN'),
        Locale('en', 'US'),
      ],
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocal in supportedLocales) {
          if (supportedLocal.toString() == locale.toString()) {
            return supportedLocal;
          }
        }
        return supportedLocales.first;
      }));
}
