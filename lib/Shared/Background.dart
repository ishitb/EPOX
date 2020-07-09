import 'package:epox_flutter/Shared/Colors.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          width: 160,
          height: 300,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Orange.withOpacity(0.05),
          ),
        ),
        Container(
          width: 260,
          height: 400,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Orange.withOpacity(0.05),
          ),
        ),
        Container(
          width: 360,
          height: 500,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Orange.withOpacity(0.05),
          ),
        ),
        Container(
          width: 460,
          height: 600,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Orange.withOpacity(0.05),
          ),
        ),
        Container(
          width: 560,
          height: 700,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Orange.withOpacity(0.05),
          ),
        ),
        Container(
          width: 660,
          height: 800,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Orange.withOpacity(0.05),
          ),
        ),
        Container(
          width: 760,
          height: 900,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Orange.withOpacity(0.05),
          ),
        ),
        Container(
          width: 860,
          height: 1000,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Orange.withOpacity(0.05),
          ),
        ),
        Container(
          width: 960,
          height: 1100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Orange.withOpacity(0.05),
          ),
        ),
        Container(
          width: 1060,
          height: 1200,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Orange.withOpacity(0.05),
          ),
        )
      ],
    );
  }
}
