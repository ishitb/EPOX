import 'package:flutter/material.dart';

import 'Colors.dart';

InputDecoration textInputDecoration = InputDecoration(
  labelStyle: TextStyle(
    color: Blue,
  ),
  hintStyle: TextStyle(
    color: Blue,
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.redAccent,
      width: 1.5,
    ),
    borderRadius: BorderRadius.circular(10),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.redAccent,
      width: 1.5,
    ),
    borderRadius: BorderRadius.circular(10),
  ),
  errorStyle: TextStyle(
    fontSize: 0,
    height: 0.00001,
  ),
  enabled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Grey,
      width: 1.5,
    ),
    borderRadius: BorderRadius.circular(10),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Blue,
      width: 1.5,
    ),
    borderRadius: BorderRadius.circular(10),
  ),
);

BoxShadow onboardButtonShadow = BoxShadow();
