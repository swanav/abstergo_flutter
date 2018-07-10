import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:tkiosk/tkiosk.dart';
import 'package:abstergo_flutter/pages/layout/loading.dart';
import 'package:abstergo_flutter/pages/courses/course_item.dart';

class CourseList extends StatefulWidget {
  final String examCode;

  CourseList({this.examCode});

  @override
  _CourseListState createState() => _CourseListState();
}

class _CourseListState extends State<CourseList> with TickerProviderStateMixin {
  AnimationController scaleAnimation;

  FirebaseUser user;

  @override
  void initState() {
    scaleAnimation = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 750),
        lowerBound: 0.0,
        upperBound: 1.0);
    scaleAnimation.forward();
    FirebaseAuth.instance.currentUser().then((FirebaseUser user) {
      setState(() {
        this.user = user;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return Expanded(
        child: Loading(),
      );
    }
    return Expanded(
      child: StreamBuilder(
        stream: Firestore.instance
            .collection('exam')
            .document(user.uid)
            .collection(widget.examCode)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Loading();
          }
          List<DocumentSnapshot> courses = List.from(snapshot.data.documents);
          return ScaleTransition(
            scale: scaleAnimation,
            child: ListView.builder(
              padding: const EdgeInsets.all(0.0),
              itemBuilder: (BuildContext context, int index) {
                Course course = Course.fromMap(Map.from(courses[index].data));
                ExamGrade grade = ExamGrade.fromMap(Map.from(courses[index].data));
                return CourseItem(
                  examCode: widget.examCode,
                  course: course,
                  grade: grade,
                );
              },
              itemCount: snapshot.data.documents.length,
            ),
          );
        },
      ),
    );
  }
}
