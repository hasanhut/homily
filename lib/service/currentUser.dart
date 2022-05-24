import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:homily/model/user.dart';
import 'package:homily/service/database.dart';

class CurrentUser extends ChangeNotifier {
  var _currentUser = OurUser(uid: "", name: "", email: "", groupId: "");

  OurUser get getCurrentUser => _currentUser;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> onStartUp() async {
    String retVal = "error";
    try {
      User? _firebaseUser = await _auth.currentUser;
      if (_firebaseUser != null) {
        _currentUser = (await OurDatabase().getUserInfo(_firebaseUser.uid))!;
        if (_currentUser != null) {
          retVal = "success";
        }
      }
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  Future<String> signOut() async {
    String retVal = "error";
    try {
      await _auth.signOut();
      _currentUser = OurUser(uid: "", name: "", email: "", groupId: "");
      retVal = "success";
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  Future<String> signUpUser(String email, String password, String name) async {
    String retval = "error";
    OurUser _user = OurUser(uid: "", name: "", email: "", groupId: "");
    try {
      UserCredential _authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      _user.uid = _authResult.user!.uid;
      _user.email = _authResult.user!.email;
      _user.name = name;
      String _returnString = await OurDatabase().createUser(_user);
      if (_returnString == "success") {
        retval = "success";
      }
    } catch (e) {
      print(e);
    }

    return retval;
  }

  Future<String> loginUserWithEmail(String email, String password) async {
    String retVal = "error";

    try {
      UserCredential _authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      _currentUser = (await OurDatabase().getUserInfo(_authResult.user!.uid))!;
      if (_currentUser != null) {
        retVal = "success";
      }
    } catch (e) {
      print(e);
    }

    return retVal;
  }
}
