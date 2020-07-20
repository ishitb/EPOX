import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epox_flutter/Services/Databases/SubmissionModel.dart';
// import 'package:epox_flutter/Services/Databases/SubmissionModel.dart';

class UserDatabase {
  final String uid;
  UserDatabase({this.uid});

  final CollectionReference learningCollection =
      Firestore.instance.collection("users");

  Future<void> registerUserData(
      String emailID, String username, String name) async {
    print("SENDING DATA TO FIRESTORE");
    SubmissionModel newSubmition = SubmissionModel(
        latitude: 11,
        longitude: 12,
        status: "status",
        date: "date",
        time: "time",
        severity: "severity");
    List submissions = List();
    submissions.add(newSubmition.returnJSON());
    return await learningCollection.document(uid).setData({
      'emailID': emailID,
      'username': username,
      'name': name,
      'noOfSubmissions': 0,
      'credibilityScore': 0,
      'submissions': submissions
    });
  }

  Stream<QuerySnapshot> get userData {
    return learningCollection.snapshots();
  }

  // , int noOfSubmissions, int credibilityScore, List<SubmissionModel> submissions
}
