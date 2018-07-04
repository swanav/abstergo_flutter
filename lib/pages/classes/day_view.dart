import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:abstergo_flutter/models/class_details.dart';
import 'package:abstergo_flutter/pages/classes/day_view_row.dart';
import 'package:abstergo_flutter/pages/layout/loading.dart';

class DayView extends StatefulWidget {
  final String day;

  DayView(this.day);

  @override
  _DayViewState createState() => _DayViewState();
}

class _DayViewState extends State<DayView> {
  String semesterCode;
  String subGroup;

  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((SharedPreferences pref) {
      setState(() {
        this.semesterCode = pref.getString("semesterCode");
        this.subGroup = pref.getString("subGroup");
      });
    });
  }

  List<Widget> dayViewGenerator(classes) {
    List<Widget> days = List();
    classes.forEach((dynamic clas) {
      days.add(DayViewRow(ClassDetails.fromMap(clas)));
    });
    return days;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Firestore.instance
            .collection('schedule')
            .document(this.semesterCode)
            .collection(this.subGroup)
            .document(widget.day)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data.data == null) {
            return Loading();
          }

          return ListView(
            children: dayViewGenerator(snapshot.data.data['classes']),
          );
        });
  }
}
