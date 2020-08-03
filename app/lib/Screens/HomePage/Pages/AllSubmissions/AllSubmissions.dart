import 'package:epox_flutter/Services/Authentication/UserModel.dart';
import 'package:epox_flutter/Services/Databases/SubmissionProvider.dart';
import 'package:epox_flutter/Services/Databases/UserDatabase.dart';
import 'package:epox_flutter/Shared/DelayedAnimation.dart';
import 'package:epox_flutter/Shared/MapCard.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

import 'package:epox_flutter/Shared/Colors.dart';
import 'package:provider/provider.dart';

class AllSubmissions extends StatefulWidget {
  @override
  _AllSubmissionsState createState() => _AllSubmissionsState();
}

class _AllSubmissionsState extends State<AllSubmissions> {
  List temp = [1, 2, 3, 4, 5, 6, 7];
  bool loading = true;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 700)).then((value) {
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);

    return user == null
        ? Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Orange),
            ),
          )
        : StreamBuilder<UserDataModel>(
            stream: UserDatabase(uid: user.uid).userData,
            builder: (context, snapshot) {
              return !snapshot.hasData
                  ? Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Orange),
                      ),
                    )
                  : Scaffold(
                      backgroundColor: DarkBlue,
                      body: SafeArea(
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height / 4,
                                  child: FlareActor(
                                    'assets/flare/all-submissions.flr',
                                    animation: 'AllSubmissions',
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  child: DelayedAnimation(
                                    child: AnimatedContainer(
                                      duration: Duration(milliseconds: 500),
                                      height: 50,
                                      // height: _animation.value * 100,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        color: Blue.withOpacity(0.9),
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(15),
                                        ),
                                        border: Border.all(
                                          color: DarkBlue,
                                          width: 2.5,
                                        ),
                                      ),
                                      // padding: EdgeInsets.only(left: 15.0),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 15.0),
                                        child: Row(
                                          children: [
                                            Text(
                                              "All Reports",
                                              style: TextStyle(
                                                color: OffWhite,
                                                fontSize: 26.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                child: StreamBuilder<List<Map>>(
                                    stream: SubmissionProvider(
                                      userReportedSubmissions: snapshot
                                          .data.submissions
                                          .map((submission) =>
                                              submission.documentID)
                                          .toList(),
                                    ).allSubmissions,
                                    builder: (context, submissionSnapshot) {
                                      // print(submissionSnapshot.data);

                                      return loading
                                          ? Center(
                                              child: CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(Orange),
                                              ),
                                            )
                                          : Column(
                                              children: submissionSnapshot.data
                                                  .map((submission) {
                                                return Column(
                                                  children: [
                                                    MapCard(
                                                      all: true,
                                                      longitude: submission[
                                                          'longitude'],
                                                      latitude: submission[
                                                          'latitude'],
                                                      date: submission['date'],
                                                      location: submission[
                                                              'location'] ??
                                                          'Jasola Vihar',
                                                      time: submission['time'],
                                                      pci: submission['pci'],
                                                      status:
                                                          submission['status'],
                                                      imageURL: submission[
                                                          'imageURL'],
                                                      comments: submission[
                                                          'comments'],
                                                      userUpVoted: submission[
                                                          'userUpVoted'],
                                                      userDownVoted: submission[
                                                          'userDownVoted'],
                                                      id: submission['id'],
                                                      uid: user.uid,
                                                      upvotes: submission['upvotes'],
                                                      downvotes: submission['downvotes'],
                                                    ),
                                                    SizedBox(
                                                      height: 20.0,
                                                    ),
                                                  ],
                                                );
                                              }).toList(),
                                            );
                                    }),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
            });
  }
}
