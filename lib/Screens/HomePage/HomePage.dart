import 'package:flutter/material.dart';

import 'package:epox_flutter/Screens/HomePage/Pages/MainPage/MainPage.dart';
import 'package:epox_flutter/Screens/HomePage/Pages/ProfilePage/ProfilePage.dart';

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
      body: Stack(
        children: [
          Container(
            child: PageView(
              controller: _pageController,
              children: [
                ProfilePage(),
                MainPage(cameras: widget.cameras),
                // MapPage(),
              ],
            ),
          ),
          // SafeArea(
          //   child: Container(
          //     height: 50,
          //     color: OffWhite,
          //     width: MediaQuery.of(context).size.height,
          //   ),
          // ),
        ],
      ),
    );
  }
}
