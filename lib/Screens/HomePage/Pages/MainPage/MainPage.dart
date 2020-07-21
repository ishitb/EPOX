import 'dart:io';

import 'package:epox_flutter/Screens/HomePage/Pages/Temp/TempPage.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';

import 'package:epox_flutter/Shared/Colors.dart';

class MainPage extends StatefulWidget {
  final List<CameraDescription> cameras;
  const MainPage({Key key, this.cameras}) : super(key: key);
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with WidgetsBindingObserver {
  CameraController controller;
  List<CameraDescription> cameras;
  int selectedCameraIndex;
  String imagePath;
  bool _capturing = false;

  File _image;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    controller = CameraController(
      widget.cameras[0],
      ResolutionPreset.ultraHigh,
    );
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // App state changed before we got the chance to initialize.
    if (controller == null || !controller.value.isInitialized) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      controller?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      if (controller != null) {
        controller.initialize().then((_) {
          if (!mounted) {
            return;
          }
          setState(() {});
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        child: imagePath == null
            ? Stack(
                children: [
                  AnimatedContainer(
                      duration: Duration(
                        milliseconds: 300,
                      ),
                      height: _height,
                      child: AspectRatio(
                        aspectRatio: controller.value.aspectRatio,
                        child: CameraPreview(
                          controller,
                        ),
                      )),
                  SafeArea(
                    child: Container(
                      height: _height,
                      width: _width,
                      padding: EdgeInsets.only(bottom: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  _capturing = true;
                                });
                                _clickImage().then((imagePath) {
                                  print(imagePath);
                                });
                              },
                              splashColor: OffWhite,
                              borderRadius: BorderRadius.circular(100),
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 350),
                                curve: Curves.bounceOut,
                                height: _capturing ? 100 : 75,
                                width: _capturing ? 100 : 75,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border:
                                        Border.all(color: OffWhite, width: 4)),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Material(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(100),
                                  splashColor: Orange,
                                  child: Ink(
                                    padding: EdgeInsets.all(10),
                                    child: Icon(
                                      Icons.image,
                                      size: 40,
                                      color: OffWhite,
                                    ),
                                  ),
                                  onTap: getImageFromGallery,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            : Stack(
                children: [
                  Container(
                    color: Black,
                    // height: _height,
                    child: Image.file(
                      // imagePath,
                      _image,
                      height: _height,
                      width: _width,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20.0,
                      horizontal: 40.0,
                    ),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Material(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(100),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(100),
                              child: Icon(
                                Icons.cancel,
                                color: OffWhite,
                                size: 50,
                              ),
                              onTap: () {
                                setState(() {
                                  _image = null;
                                  imagePath = null;
                                  _capturing = false;
                                  controller.initialize();
                                });
                              },
                            ),
                          ),
                          Material(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(100),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(100),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: OffWhite,
                                size: 60,
                              ),
                              onTap: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => TempPage(),
                                //   ),
                                // );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }

  Future<String> _clickImage() async {
    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/Pictures/flutter_test';
    await Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${timestamp()}.jpg';

    if (controller.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      await controller.takePicture(filePath);
    } on CameraException catch (e) {
      print(e);
      return null;
    }
    setState(() {
      imagePath = filePath;
      _image = File(filePath);
    });
    return filePath;
  }

  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  Future getImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        imagePath = pickedFile.path;
        _image = File(pickedFile.path);
      });
      print(imagePath);
    } else
      print("nothing selected!");
  }
}
