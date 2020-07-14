import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';

class CameraProvider with ChangeNotifier {
  List<CameraDescription> cameras;

  CameraProvider({this.cameras});

  void setCameras() async {
    try {
      cameras = await availableCameras();
    } on CameraException catch (e) {
      print(e);
    }
    notifyListeners();
  }

  List<CameraDescription> getCameras() {
    return cameras;
  }
}
