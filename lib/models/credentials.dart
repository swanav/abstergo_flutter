import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class Credentials {
  String rollNumber;
  String password;

  String uid;
  bool isWebkioskAuthenticated = false;

  Credentials(this.rollNumber, this.password, {this.uid});

  set(String userId) => uid = userId;

  String get firebaseEmail => "$rollNumber@thapar.abstergo.me";
  String get firebasePassword => "$password@tu123";
  String get firebaseId => uid;

  static Future<Credentials> fetch() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return Credentials(
      preferences.get("rollNumber"),
      preferences.get("password"),
      uid: preferences.get("uid"),
    );
  }
}
