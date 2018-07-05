import 'package:shared_preferences/shared_preferences.dart';
import 'package:tkiosk/tkiosk.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:abstergo_flutter/models/credentials.dart';

void fetchPersonalInfo() async {
  print("Fetching Profile...");
  Credentials credentials = await Credentials.fetch();
  WebKiosk webkiosk = WebKiosk(credentials.rollNumber, credentials.password);
  try {
    if (await webkiosk.login()) {
      PersonalInfo profile = await webkiosk.personalInfo();
      Firestore.instance
          .collection('profile')
          .document(credentials.firebaseId)
          .setData(profile.toMap());
    }
  } catch (ex) {
    print("Exception in fetching profile data.");
  }
}

void fetchSubGroupInfo() async {
  print("Fetching Subgroup details...");
  Credentials credentials = await Credentials.fetch();
  WebKiosk webkiosk = WebKiosk(credentials.rollNumber, credentials.password);
  SharedPreferences preferences = await SharedPreferences.getInstance();
  try {
    if (await webkiosk.login()) {
      Map<String, String> data = await webkiosk.subGroup();
      DocumentReference ref = Firestore.instance
          .collection('profile')
          .document(credentials.firebaseId);
      ref.setData(data, merge: true);
      data.forEach((String key, String value) {
        preferences.setString(key, value);
      });
      preferences.commit();
    }
  } catch (ex) {
    print(ex.toString());
  }
}
