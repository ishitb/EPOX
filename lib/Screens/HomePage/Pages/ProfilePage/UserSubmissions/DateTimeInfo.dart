import 'package:flutter/material.dart';

import 'package:epox_flutter/Shared/Colors.dart';

class DateTimeInfo extends StatelessWidget {
  final bool screenLoaded;
  final String date, time;

  const DateTimeInfo({Key key, this.screenLoaded, this.date, this.time})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
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
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    size: 30,
                    color: Orange,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    date,
                    style: TextStyle(
                      fontSize: 20,
                      color: OffWhite,
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Text(
                    time,
                    style: TextStyle(
                      fontSize: 20,
                      color: OffWhite,
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Icon(
                    Icons.access_time,
                    size: 30,
                    color: Orange,
                  )
                ],
              ),
            ],
          ),
          Divider(
            height: 30,
            color: Grey,
          ),
          Text(
            "Reported on",
            style: TextStyle(
              color: Blue,
              fontSize: 24,
            ),
          ),
        ],
      ),
    );
  }
}
