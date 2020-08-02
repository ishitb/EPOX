import 'package:epox_flutter/Screens/HomePage/Pages/ProfilePage/UserSubmissions/Stats/RoadCondition.dart';
import 'package:epox_flutter/Screens/HomePage/Pages/ProfilePage/UserSubmissions/Stats/Status.dart';
import 'package:flutter/material.dart';

import 'package:epox_flutter/Shared/Colors.dart';

class Stats extends StatelessWidget {
  final bool severityLoader;
  final double pci;
  final Animation animation;
  final AnimationController animationController;
  final int status;

  Stats(
      {Key key,
      this.severityLoader,
      this.pci,
      this.animation,
      this.animationController,
      this.status})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 30.0,
        vertical: 10.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RoadCondition(
            severityLoader: severityLoader,
            pci: pci,
            animation: animation,
            animationController: animationController,
          ),
          Status(
            severityLoader: severityLoader,
            status: status,
          ),
        ],
      ),
    );
  }
}
