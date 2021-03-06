import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';

class BottomPopup {
  final BuildContext context;

  BottomPopup({this.context});

  Future showErrorFlushBar(String error) {
    Flushbar(
      icon: Icon(Icons.error_outline, color: Colors.redAccent),
      leftBarIndicatorColor: Colors.redAccent,
      message: error,
      duration: Duration(seconds: 3),
      isDismissible: true,
    )..show(context);
    return null;
  }

  Future showSuccessFlushBar(String message) {
    Flushbar(
      icon: Icon(Icons.tag_faces, color: Colors.greenAccent),
      leftBarIndicatorColor: Colors.greenAccent,
      message: message,
      duration: Duration(seconds: 3),
      isDismissible: true,
    )..show(context);
    return null;
  }
}
