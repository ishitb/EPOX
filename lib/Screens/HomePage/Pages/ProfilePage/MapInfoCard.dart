import 'package:epox_flutter/Shared/Colors.dart';
import 'package:flutter/material.dart';

class MapInfoCard extends StatelessWidget {
  final String location, date;

  const MapInfoCard({Key key, this.location, this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        // width: 345,
        // width: MediaQuery.of(context).size.width,
        height: 70,
        padding: EdgeInsets.symmetric(
          horizontal: 10,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
          color: Blue,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  location.split(',')[0],
                  style: TextStyle(
                    color: Orange,
                    fontSize: 22,
                  ),
                ),
                Text(
                  "Location",
                  style: TextStyle(
                    color: OffWhite,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  date,
                  style: TextStyle(
                    color: Orange,
                    fontSize: 22,
                  ),
                ),
                Text(
                  "Reported On",
                  style: TextStyle(
                    color: OffWhite,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
