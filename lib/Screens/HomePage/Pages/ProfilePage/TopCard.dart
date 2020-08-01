import 'package:flutter/material.dart';
import 'package:epox_flutter/Shared/Colors.dart';

class TopCard extends StatelessWidget {
  final double width, height;
  final String name, username, emailID;

  const TopCard(
      {Key key,
      this.width,
      this.height,
      this.name,
      this.username,
      this.emailID})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -200,
          child: Container(
            height: width,
            width: width,
            decoration: BoxDecoration(
              color: DarkGrey.withOpacity(0.6),
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(100),
                bottomLeft: Radius.circular(100),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15.0,
          ),
          child: Container(
            height: width - 200,
            width: width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    color: Blue,
                    fontSize: 42,
                  ),
                ),
                SizedBox(height: 5.0),
                RichText(
                  text: TextSpan(
                      text: "Username:  ",
                      style: TextStyle(
                        fontSize: 18,
                        color: Grey,
                      ),
                      children: [
                        TextSpan(
                          text: username,
                          style: TextStyle(color: Orange),
                        ),
                      ]),
                ),
                SizedBox(height: 5.0),
                RichText(
                  text: TextSpan(
                      text: "Email Address:  ",
                      style: TextStyle(
                        fontSize: 18,
                        color: Grey,
                      ),
                      children: [
                        TextSpan(
                          text: emailID,
                          style: TextStyle(color: Orange),
                        ),
                      ]),
                ),
                SizedBox(height: 30.0),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
