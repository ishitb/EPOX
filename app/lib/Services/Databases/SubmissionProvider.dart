import 'dart:io';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epox_flutter/Services/Authentication/UserModel.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'SubmissionModel.dart';

class SubmissionProvider {
  final CollectionReference submissionCollection =
      Firestore.instance.collection('submissions');
  final CollectionReference userCollection =
      Firestore.instance.collection("users");
  final List userReportedSubmissions;

  Future<DocumentReference> newSubmission({
    String uid,
    String userEmail,
    String username,
    String comments,
    double latitude,
    double longitude,
    File imageFile,
  }) async {
    DateTime now = DateTime.now();
    String date = now.toString().split(' ')[0];
    String time = now.toString().split(' ')[1].toString().split('.')[0];

    Map newSubmissionData = SubmissionModel(
      comments: comments,
      latitude: latitude,
      longitude: longitude,
      date: date,
      time: time,
      pci: 0.0,
      status: 0,
    ).returnJSON(
      uid,
      userEmail,
      username,
    );

    SharedPreferences sprefs = await SharedPreferences.getInstance();
    int customSubmitID = sprefs.getInt('customDocID');

    List<Placemark> placemark =
        await Geolocator().placemarkFromCoordinates(latitude, longitude);
    newSubmissionData['location'] =
        "${placemark[0].name}, ${placemark[0].subLocality} - ${placemark[0].postalCode}, ${placemark[0].locality}, ${placemark[0].administrativeArea}";
    newSubmissionData['upvotes'] = 0;
    newSubmissionData['downvotes'] = 0;
    newSubmissionData['userUpVoted'] = [];
    newSubmissionData['userDownVoted'] = [];

    await submissionCollection.document('00a9999999$customSubmitID').setData(
          newSubmissionData,
        );

    DocumentReference submissionRef =
        submissionCollection.document('00a9999999$customSubmitID');

    await submissionCollection
        .document('00a9999999$customSubmitID')
        .setData(newSubmissionData);

    List imageData = await _uploadImage(imageFile, submissionRef.documentID);
    // List imageData = await _uploadImage(imageFile, '00od928dcnweiw928sja');

    // DocumentReference submissionRef =
    //     submissionCollection.document('00od928dcnweiw928sja');

    await submissionRef.updateData({
      'imageURL': imageData[0],
      'pci': imageData[1],
    });

    customSubmitID--;

    return submissionRef;
  }

  Future<void> updateUserInfo(
    String uid,
    DocumentReference submissionID,
    UserDataModel userData,
  ) async {
    userCollection
        .document(
      uid,
    )
        .updateData(
      {
        'noOfSubmissions': userData.noOfSubmissions + 1,
        'submissions': userData.submissions + [submissionID],
      },
    );
  }

  Future<List> _uploadImage(File image, String reportID) async {
    final FirebaseStorage storage = FirebaseStorage.instance;
    StorageTaskSnapshot snapshot = await storage
        .ref()
        .child('upload-images/$reportID')
        .putFile(image)
        .onComplete;
    final String imageURL = await snapshot.ref.getDownloadURL();

    // var request = http.MultipartRequest(
    //     'POST', Uri.parse('http://2fc773642848.ngrok.io//image-upload'));
    // String fileName = '$reportID.${image.path.toString().split('.').last}';
    // request.files.add(http.MultipartFile(
    //     'file', image.readAsBytes().asStream(), image.lengthSync(),
    //     filename: fileName));
    // var response = await request.send();
    // var responseString = await await http.Response.fromStream(response);
    // double pci = json.decode(responseString.body)['data'][0].toDouble();

    // return [imageURL, pci];
    return [imageURL, 95.60649295226];
  }

  List<Map> _getAllSubmissions(QuerySnapshot snapshot) {
    print("hello");
    List retrievedUserSubmissions = List();

    for (var doc in snapshot.documents) {
      if (!userReportedSubmissions.contains(doc.documentID)) {
        retrievedUserSubmissions.add(doc);
      }
    }

    return retrievedUserSubmissions.map((submission) {
      return {
        'id': submission.documentID,
        'latitude': submission.data['latitude'],
        'longitude': submission.data['longitude'],
        'status': submission.data['status'].toInt(),
        'date': submission.data['date'],
        'time': submission.data['time'],
        'comments': submission.data['comments'],
        'location': submission.data['location'],
        'imageURL': submission.data['imageURL'],
        'pci': submission.data['pci'].toDouble(),
        'upvotes': submission.data['upvotes'] ?? 0,
        'downvotes': submission.data['downvotes'] ?? 0,
        'userUpVoted': submission.data['userUpVoted'] ?? [],
        'userDownVoted': submission.data['userDownVoted'] ?? [],
      };
    }).toList();
  }

  SubmissionProvider({this.userReportedSubmissions});

  List<Map> _getUserSubmissions(QuerySnapshot snapshot) {
    List retrievedUserSubmissions = List();

    for (var doc in snapshot.documents) {
      if (userReportedSubmissions.contains(doc.documentID)) {
        retrievedUserSubmissions.add(doc);
      }
    }

    return retrievedUserSubmissions.map((submission) {
      return {
        'latitude': submission.data['latitude'],
        'longitude': submission.data['longitude'],
        'status': submission.data['status'].toInt(),
        'date': submission.data['date'],
        'time': submission.data['time'],
        'comments': submission.data['comments'],
        'location': submission.data['location'],
        'imageURL': submission.data['imageURL'],
        'pci': submission.data['pci'].toDouble(),
        'upvotes': submission.data['upvotes'] ?? 0,
        'downvotes': submission.data['downvotes'] ?? 0,
      };
    }).toList();
  }

  Stream<List<Map>> get userSubmission {
    return submissionCollection.snapshots().map(_getUserSubmissions);
  }

  Stream<List<Map>> get allSubmissions {
    return submissionCollection.snapshots().map(_getAllSubmissions);
  }

  Future<void> vote(String uid, String docID, String voting) async {
    DocumentReference submitRef = submissionCollection.document(docID);
    DocumentSnapshot submitSnap = await submitRef.snapshots().first;
    bool up = voting == "up";

    List downVotingUsers = submitSnap.data['userDownVoted'] ?? [];
    List upVotingUsers = submitSnap.data['userUpVoted'] ?? [];
    int upvotes = submitSnap.data['upvotes'] ?? 0;
    int downVotes = submitSnap.data['downvotes'] ?? 0;

    if (up) {
      if (downVotingUsers.contains(uid)) {
        downVotingUsers.remove(uid);
        downVotes--;
      }
    } else {
      if (upVotingUsers.contains(uid)) {
        upVotingUsers.remove(uid);
        upvotes--;
      }
    }

    await submitRef.updateData(up
        ? {
            'userUpVoted': upVotingUsers + [uid],
            'userDownVoted': downVotingUsers,
            'downvotes': downVotes,
            'upvotes': upvotes + 1
          }
        : {
            'userDownVoted': downVotingUsers + [uid],
            'userUpVoted': upVotingUsers,
            'upvotes': upvotes,
            'downvotes': downVotes + 1,
          });

    DocumentReference userRef = userCollection.document(submitSnap.data['uid']);
    DocumentSnapshot userSnap = await userRef.snapshots().first;
    print(userSnap.data);
    await userRef.updateData(
      up
          ? {'credibilityScore': userSnap.data['credibilityScore'] + 1}
          : {'credibilityScore': userSnap.data['credibilityScore'] - 1},
    );
  }
}
