import 'package:flutter/material.dart';

import 'package:epox_flutter/Shared/Colors.dart';

class BottomCard extends StatelessWidget {
  final double height, width;
  final int credibilityScore, noOfSubmissions;

  const BottomCard(
      {Key key,
      this.height,
      this.width,
      this.credibilityScore,
      this.noOfSubmissions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Container(
          width: width,
          height: height / 4.5,
          decoration: BoxDecoration(
            color: Blue.withOpacity(0.4),
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                spreadRadius: 5.0,
                color: DarkGrey,
              ),
            ],
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(15),
            ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 15.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.verified_user,
                      size: 40,
                      color: credibilityScore > 9
                          ? Colors.greenAccent
                          : Colors.red[(10 - (credibilityScore + 1)) * 100],
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Credibility Score",
                          style: TextStyle(
                            color: LightGrey,
                            fontSize: 18.0,
                          ),
                        ),
                        Text(
                          credibilityScore.toString(),
                          style: TextStyle(
                            color: Orange,
                            fontSize: 24.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(
                height: 50,
                color: Grey,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.confirmation_number,
                      size: 40,
                      color: Blue,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Number of Submissions Reported",
                          style: TextStyle(
                            color: LightGrey,
                            fontSize: 18.0,
                          ),
                        ),
                        Text(
                          noOfSubmissions.toString(),
                          style: TextStyle(
                            color: Orange,
                            fontSize: 24.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
