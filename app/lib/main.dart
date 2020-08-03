import 'package:epox_flutter/Screens/Wrapper.dart';
import 'package:epox_flutter/Services/Authentication/AuthProvider.dart';
import 'package:epox_flutter/Services/Authentication/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:camera/camera.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Services/Localization/AppLocalizations.dart';

List<CameraDescription> cameras;

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print(e);
  }

  SharedPreferences prefs = await SharedPreferences.getInstance();

  if (!prefs.containsKey('customDocID')) {
    await prefs.setInt('customDocID', 9999999999);
  }

  runApp(
    MultiProvider(
      providers: [
        StreamProvider<UserModel>(
          create: (_) => AuthProvider().user,
        ),
      ],
      child: MaterialApp(
        title: 'Team: EPOX',
        home: Wrapper(
          cameras: cameras,
        ),
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
        },
      ),
    ),
  );
}
