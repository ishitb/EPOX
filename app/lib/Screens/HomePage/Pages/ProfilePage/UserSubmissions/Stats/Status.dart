import 'package:flutter/material.dart';

import 'package:epox_flutter/Shared/Colors.dart';

class Status extends StatelessWidget {
  final bool severityLoader;
  final int status;

  Status({Key key, this.severityLoader, this.status}) : super(key: key);

// Status Map
  List statusValue = [
    {
      'status': "Reported",
      'color': Colors.red[900],
    },
    {
      'status': "Working",
      'color': Orange,
    },
    {
      'status': "Resolved",
      'color': Colors.yellow[700],
    },
    {
      'status': "Spam",
      'color': Colors.green[800],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      padding: EdgeInsets.all(20.0),
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
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Icon(
              // FontAwesomeIcons.resolving,
              Icons.new_releases,
              size: 40.0,
              color: statusValue[status]['color'],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                statusValue[status]['status'],
                style: TextStyle(
                  color: statusValue[status]['color'],
                  fontSize: 28.0,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "Status of Report",
                style: TextStyle(
                  color: Blue,
                  fontSize: 20.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
