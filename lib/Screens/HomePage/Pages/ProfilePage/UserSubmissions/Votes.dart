import 'package:flutter/material.dart';

import 'package:epox_flutter/Shared/Colors.dart';

class Votes extends StatelessWidget {
  final bool startVoting, screenLoaded;

  const Votes({Key key, this.startVoting, this.screenLoaded}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: DarkBlue,
        boxShadow: [
          BoxShadow(
            color: Black,
            blurRadius: screenLoaded ? 10.0 : 0.0,
            spreadRadius: screenLoaded ? 3.5 : 0.0,
          ),
        ],
        border: Border.all(
          color: Orange,
          width: 2.0,
        ),
      ),
      child: Stack(
        children: [
          AnimatedPositioned(
            duration: Duration(milliseconds: 400),
            left: startVoting ? 0 : MediaQuery.of(context).size.width,
            // alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Icon(
                  Icons.thumb_up,
                  size: 45,
                  color: Colors.green[700],
                ),
                SizedBox(
                  width: 10.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "0",
                      style: TextStyle(
                        color: OffWhite,
                        fontSize: 24.0,
                      ),
                    ),
                    Text(
                      "Upvotes",
                      style: TextStyle(
                        color: Blue,
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Center(
            child: SizedBox(
              height: 45.0,
              width: 1.0,
              child: Container(
                color: Grey,
              ),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 300),
            right: startVoting ? 0 : MediaQuery.of(context).size.width,
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "0",
                      style: TextStyle(
                        color: OffWhite,
                        fontSize: 24.0,
                      ),
                    ),
                    Text(
                      "Downvotes",
                      style: TextStyle(
                        color: Blue,
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 10.0,
                ),
                Icon(
                  Icons.thumb_down,
                  size: 45,
                  color: Colors.red[700],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
