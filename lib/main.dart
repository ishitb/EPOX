import 'package:epox_flutter/Screens/AuthScreen/AuthScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Team: EPOX',
    initialRoute: '/',
    routes: {
      '/': (context) => AuthScreen(),
    },
    debugShowCheckedModeBanner: false,
  ));
}
