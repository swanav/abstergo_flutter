import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:abstergo_flutter/pages/layout/loading.dart';
import 'package:abstergo_flutter/pages/profile/profile_content.dart';
import 'package:tkiosk/tkiosk.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  FirebaseUser user;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.currentUser().then((FirebaseUser user) {
      setState(() {
        this.user = user;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return Loading();
    }

    return StreamBuilder(
        stream: Firestore.instance
            .collection('profile')
            .document(user.uid)
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.data == null) {
            return Loading();
          }
          return Container(
            child: ProfileContent(
              PersonalInfo.fromMap(snapshot.data.data),
            ),
          );
        });
  }
}
