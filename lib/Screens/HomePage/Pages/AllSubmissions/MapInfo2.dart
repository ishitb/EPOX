import 'package:epox_flutter/Services/Databases/SubmissionProvider.dart';
import 'package:epox_flutter/Shared/Colors.dart';
import 'package:flutter/material.dart';

class MapInfoCard2 extends StatefulWidget {
  final String location, date, id, uid;
  final List userUpVoted, userDownVoted;

  const MapInfoCard2(
      {Key key,
      this.location,
      this.date,
      this.userUpVoted,
      this.id,
      this.uid,
      this.userDownVoted})
      : super(key: key);

  @override
  _MapInfoCard2State createState() => _MapInfoCard2State();
}

class _MapInfoCard2State extends State<MapInfoCard2> {
  String voted = "";

  @override
  void initState() {
    super.initState();
    if (widget.userUpVoted.contains(widget.uid)) {
      setState(() {
        voted = "up";
      });
    } else if (widget.userDownVoted.contains(widget.uid)) {
      setState(() {
        voted = "down";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SubmissionProvider submissionProvider = SubmissionProvider();
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
                Wrap(children: [
                  Text(
                    widget.location.split(',')[0].substring(
                        0, (widget.location.split(',')[0].length / 3).floor()),
                    style: TextStyle(
                      color: Orange,
                      fontSize: 22,
                    ),
                  ),
                ]),
                Text(
                  "Location",
                  style: TextStyle(
                    color: OffWhite,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                voted == "" || voted == "down"
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            voted = "up";
                          });
                          submissionProvider.vote(widget.uid, widget.id, "up");
                        },
                        icon: Icon(
                          Icons.thumb_up,
                          color: OffWhite,
                        ),
                      )
                    : Icon(
                        Icons.thumb_up,
                        color: voted == "up" ? Colors.greenAccent : OffWhite,
                      ),
                voted == "" || voted == "up"
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            voted = "down";
                          });
                          submissionProvider.vote(
                              widget.uid, widget.id, "down");
                        },
                        icon: Icon(
                          Icons.thumb_down,
                          color: OffWhite,
                        ),
                      )
                    : Icon(
                        Icons.thumb_down,
                        color: voted == "down" ? Colors.redAccent : OffWhite,
                      ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  widget.date,
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
