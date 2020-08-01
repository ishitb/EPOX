import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epox_flutter/Services/Authentication/UserModel.dart';

class UserDatabase {
  final String uid;
  UserDatabase({this.uid});

  final CollectionReference userCollection =
      Firestore.instance.collection("users");

  Future<void> registerUserData(
      String emailID, String username, String name) async {
    return await userCollection.document(uid).setData({
      'emailID': emailID,
      'username': username,
      'name': name,
      'noOfSubmissions': 0,
      'credibilityScore': 0,
      'submissions': []
    });
  }

  UserDataModel _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserDataModel(
      name: snapshot.data['name'],
      emailID: snapshot.data['emailID'],
      username: snapshot.data['username'],
      noOfSubmissions: snapshot.data['noOfSubmissions'],
      credibilityScore: snapshot.data['credibilityScore'],
      submissions: snapshot.data['submissions'],
    );
  }

  Stream<UserDataModel> get userData {
    return userCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }
}
