import 'package:epox_flutter/Services/Databases/SubmissionModel.dart';

class UserModel {
  final String uid, email;

  UserModel(
    this.uid,
    this.email,
  );
}

class UserDataMode {
  final String emailID, name, username;
  final int noOfSubmissions, credibilityScore;
  final List<SubmissionModel> submission;

  UserDataMode({
    this.emailID,
    this.name,
    this.username,
    this.noOfSubmissions,
    this.credibilityScore,
    this.submission,
  });
}
