import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:abstergo_flutter/models/class_details.dart';
import 'package:abstergo_flutter/pages/classes/day_view_row.dart';
import 'package:abstergo_flutter/pages/layout/loading.dart';

class DayView extends StatefulWidget {
  final String day;
  final String semesterCode;
  final String subGroup;
  
  DayView({this.semesterCode, this.subGroup, this.day});

  @override
  _DayViewState createState() => _DayViewState();

}

class _DayViewState extends State<DayView> {

  int today;

  @override
  void initState() {
    super.initState();
    int today = DateTime.now().weekday;
    setState(() {
      this.today = today;
    });
  }

  int _day() {
    switch(widget.day) {
      case "MON":
        return 1;
      case "TUE":
        return 2;
      case "WED": 
        return 3;
      case "THU": 
        return 4;
      case "FRI":
        return 5;
    }
  }

  @override
  Widget build(BuildContext context) =>    
    StreamBuilder(
        stream: Firestore.instance
            .collection('schedule')
            .document(widget.semesterCode)
            .collection(widget.subGroup)
            .document(widget.day)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData || snapshot.data.data == null) {
            return Loading();
          }

          var classes = List.from(snapshot.data.data['classes']);
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) =>
                DayViewRow(details: ClassDetails.fromMap(classes[index]), day: _day(),),
            itemCount: classes.length,
          );
        });
  }

