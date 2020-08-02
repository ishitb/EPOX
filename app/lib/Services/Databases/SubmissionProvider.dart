import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epox_flutter/Services/Authentication/UserModel.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:http/http.dart' as http;

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

    List<Placemark> placemark =
        await Geolocator().placemarkFromCoordinates(latitude, longitude);
    newSubmissionData['location'] =
        "${placemark[0].name}, ${placemark[0].subLocality} - ${placemark[0].postalCode}, ${placemark[0].locality}, ${placemark[0].administrativeArea}";

    DocumentReference submissionRef = await submissionCollection.add(
      newSubmissionData,
    );

    String imageURL = await _uploadImage(imageFile, submissionRef.documentID);

    await submissionRef.updateData({
      'imageURL': imageURL,
    });

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

  Future<String> _uploadImage(File image, String reportID) async {
    final FirebaseStorage storage = FirebaseStorage.instance;
    StorageTaskSnapshot snapshot = await storage
        .ref()
        .child('upload-images/$reportID')
        .putFile(image)
        .onComplete;
    final String imageURL = await snapshot.ref.getDownloadURL();

    // var request = http.MultipartRequest(
    //     'POST', Uri.parse('http://192.168.0.105:8000/image-upload'));
    // String fileName = '$reportID.${image.path.toString().split('.').last}';
    // request.files.add(http.MultipartFile(
    //     'file', image.readAsBytes().asStream(), image.lengthSync(),
    //     filename: fileName));
    // var response = await request.send();
    // print(response.statusCode);

    return imageURL;
  }

  List<Map> _getAllSubmissions(QuerySnapshot snapshot) {
    return snapshot.documents.map((submission) {
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
      };
    }).toList();
  }

  Stream<List<Map>> get userSubmission {
    return submissionCollection.snapshots().map(_getUserSubmissions);
  }

  // Stream<QuerySnapshot> get userSubmission {
  //   return submissionCollection.snapshots();
  // }
}
