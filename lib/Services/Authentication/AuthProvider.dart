import 'package:epox_flutter/Services/Databases/UserDatabase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:epox_flutter/Services/Authentication/UserModel.dart';
import 'package:flutter/services.dart';

class AuthProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String email;

  UserModel _userFromFirebase(FirebaseUser user) {
    return user != null
        ? UserModel(
            user.uid,
            user.email,
          )
        : null;
  }

  Stream<UserModel> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebase);
  }

  Future emailSignIn(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebase(user);
    } catch (e) {
      print(e);
      return e;
    }
  }

  Future emailRegistration(
      String email, String password, String name, String username) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      FirebaseUser user = result.user;

      await UserDatabase(uid: user.uid).registerUserData(email, username, name);

      return _userFromFirebase(user);
    } catch (e) {
      print(e);
      return e;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e);
      return null;
    }
  }
}
