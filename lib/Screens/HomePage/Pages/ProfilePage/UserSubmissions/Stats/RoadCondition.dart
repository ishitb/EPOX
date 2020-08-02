import 'package:flutter/material.dart';

import 'package:epox_flutter/Shared/Colors.dart';

class RoadCondition extends StatelessWidget {
  final bool severityLoader;
  final double pci;
  final Animation animation;
  final AnimationController animationController;

  const RoadCondition(
      {Key key,
      this.severityLoader,
      this.pci,
      this.animation,
      this.animationController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      padding: EdgeInsets.all(15.0),
      duration: Duration(milliseconds: 500),
      decoration: BoxDecoration(
        color: DarkBlue,
        boxShadow: [
          BoxShadow(
            color: Black,
            blurRadius: severityLoader ? 10.0 : 0.0,
            spreadRadius: severityLoader ? 3.5 : 0.0,
          ),
        ],
        border: Border.all(
          color: Orange,
          width: 2.0,
        ),
      ),
      height: MediaQuery.of(context).size.width / 2.5,
      width: MediaQuery.of(context).size.width / 2.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Road Condition".toUpperCase(),
            style: TextStyle(
              color: Blue,
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width / 4,
            width: MediaQuery.of(context).size.width / 4,
            child: Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.width / 4,
                  width: MediaQuery.of(context).size.width / 4,
                  child: CircularProgressIndicator(
                    value: pci * animation.value / 100,
                    backgroundColor: DarkGrey,
                    strokeWidth: 4.5,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      pci * animation.value < 20
                          ? Colors.red[900]
                          : pci * animation.value < 40
                              ? Orange
                              : pci * animation.value < 60
                                  ? Colors.yellow[700]
                                  : pci * animation.value < 80
                                      ? Colors.green[300]
                                      : Colors.green[800],
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    "${(pci * animation.value).toStringAsFixed(2)}%",
                    style: TextStyle(
                      fontSize: 24.0,
                      color: pci * animation.value < 20
                          ? Colors.red[900]
                          : pci * animation.value < 40
                              ? Orange
                              : pci * animation.value < 60
                                  ? Colors.yellow[700]
                                  : pci * animation.value < 80
                                      ? Colors.green[300]
                                      : Colors.green[800],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      onEnd: () {
        animationController.forward();
      },
    );
  }
}
