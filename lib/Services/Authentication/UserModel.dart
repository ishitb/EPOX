import 'package:epox_flutter/Services/Databases/SubmissionModel.dart';

class UserModel {
  final String uid, email;

  UserModel(
    this.uid,
    this.email,
  );
}

class UserDataModel {
  final String emailID, name, username;
  final int noOfSubmissions, credibilityScore;
  final List submissions;

  UserDataModel({
    this.emailID,
    this.name,
    this.username,
    this.noOfSubmissions,
    this.credibilityScore,
    this.submissions,
  });
}
