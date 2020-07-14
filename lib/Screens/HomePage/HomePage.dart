import 'package:epox_flutter/Screens/HomePage/Pages/MainPage/MainPage.dart';
import 'package:epox_flutter/Screens/HomePage/Pages/ProfilePage/ProfilePage.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final List cameras;
  HomePage({Key key, this.cameras}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _pageController = PageController(initialPage: 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [ProfilePage(), MainPage(cameras: widget.cameras)],
      ),
    );
  }
}
