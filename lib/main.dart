import 'package:epox_flutter/Screens/Authorization/OnBoarding.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Team: EPOX',
    initialRoute: '/',
    routes: {
      '/': (context) => OnBoarding(),
    },
    debugShowCheckedModeBanner: false,
  ));
}
