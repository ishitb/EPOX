import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epox_flutter/Screens/Wrapper.dart';
import 'package:epox_flutter/Services/Authentication/AuthProvider.dart';
import 'package:epox_flutter/Services/Authentication/UserModel.dart';
import 'package:epox_flutter/Services/Databases/UserDatabase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:camera/camera.dart';
import 'package:provider/provider.dart';

import 'Screens/HomePage/HomePage.dart';
import 'package:epox_flutter/Screens/Authorization/OnBoarding.dart';
import 'Services/Localization/AppLocalizations.dart';

List<CameraDescription> cameras;

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print(e);
  }

  final AuthProvider _auth = AuthProvider();

  runApp(
    MultiProvider(
      providers: [
        StreamProvider<UserModel>(
          create: (_) => AuthProvider().user,
        ),
        StreamProvider<QuerySnapshot>(
          create: (_) => UserDatabase().userData,
        )
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
