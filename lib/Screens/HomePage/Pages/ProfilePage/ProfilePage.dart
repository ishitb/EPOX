import 'package:epox_flutter/Screens/HomePage/Pages/ProfilePage/UserSubmissions/SubmissionInfoPage.dart';
import 'package:epox_flutter/Shared/DelayedAnimation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:epox_flutter/Services/Authentication/AuthProvider.dart';
import 'package:epox_flutter/Services/Authentication/UserModel.dart';
import 'package:epox_flutter/Services/Databases/UserDatabase.dart';
import 'package:epox_flutter/Services/Databases/SubmissionProvider.dart';
import 'package:epox_flutter/Services/Databases/SubmissionModel.dart';

import 'BottomCard.dart';
import 'ProfileAppBar.dart';
import 'TopCard.dart';
import 'package:epox_flutter/Shared/Colors.dart';
import 'package:epox_flutter/Shared/MapCard.dart';

class ProfilePage extends StatefulWidget with WidgetsBindingObserver {
  final PageController mainPageController;

  ProfilePage({Key key, this.mainPageController}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  double longitude = 0, latitude = 0;
  bool loading = false, locationServicesEnabled = true;

  Animation animation;
  AnimationController animationController;

  final AuthProvider _auth = AuthProvider();

  @override
  void initState() {
    super.initState();
    // _getCurrentLocation();

    animationController =
        AnimationController(duration: Duration(milliseconds: 800), vsync: this);
    animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.ease,
    ));

    animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    Size size = MediaQuery.of(context).size;

    return StreamBuilder<UserDataModel>(
      stream: UserDatabase(uid: user.uid).userData,
      builder: (context, snapshot) {
        return Scaffold(
          backgroundColor: DarkBlue,
          body: snapshot.data == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Stack(
                  children: [
                    TopCard(
                      width: size.width,
                      height: size.height,
                      username: snapshot.data.username,
                      name: snapshot.data.name,
                      emailID: snapshot.data.emailID,
                    ),
                    ProfileAppBar(
                      mainPageController: widget.mainPageController,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20.0,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 50),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Submissions Reported",
                                style: TextStyle(
                                  color: LightGrey,
                                  fontSize: 36,
                                ),
                              ),
                              Divider(
                                height: 10.0,
                                color: Grey,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        StreamBuilder<List<Map>>(
                            stream: SubmissionProvider(
                              userReportedSubmissions: snapshot.data.submissions
                                  .map((submission) => submission.documentID)
                                  .toList(),
                            ).userSubmission,
                            builder: (context, submissionSnapshot) {
                              return !submissionSnapshot.hasData
                                  ? Center(
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 300,
                                            width: 300,
                                            child: Image.asset(
                                                'undraw_empty_street_sfxm'),
                                          ),
                                          Text(
                                            "Seems pretty empty.",
                                            style: TextStyle(
                                              fontSize: 20.0,
                                              color: OffWhite,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : CarouselSlider(
                                      items: submissionSnapshot.data
                                          .map((submission) {
                                        return MapCard(
                                          all: false,
                                          upvotes: submission['upvotes'],
                                          downvotes: submission['downvotes'],
                                          longitude: submission['longitude'],
                                          latitude: submission['latitude'],
                                          date: submission['date'],
                                          location: submission['location'] ??
                                              'Jasola Vihar',
                                          time: submission['time'],
                                          pci: submission['pci'],
                                          status: submission['status'],
                                          imageURL: submission['imageURL'],
                                          comments: submission['comments'],
                                        );
                                      }).toList(),
                                      options: CarouselOptions(
                                        height: 300,
                                        // aspectRatio: 16 / 9,
                                        viewportFraction: 0.8,
                                        initialPage: 0,
                                        enableInfiniteScroll: false,
                                        reverse: false,
                                        enlargeCenterPage: true,
                                        scrollDirection: Axis.horizontal,
                                      ),
                                    );
                            }),
                      ],
                    ),
                    DelayedAnimation(
                      onEnd: () {
                        animationController.forward();
                      },
                      child: BottomCard(
                        width: size.width,
                        height: size.height,
                        credibilityScore: snapshot.data.credibilityScore,
                        noOfSubmissions: snapshot.data.noOfSubmissions,
                        animation: animation,
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
