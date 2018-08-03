import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:abstergo_flutter/services/fetch_exam_grades.dart';
import 'package:abstergo_flutter/services/fetch_exam_marks.dart';
import 'package:abstergo_flutter/services/fetch_semester_info.dart';
import 'package:abstergo_flutter/services/calculator.dart';
import 'package:abstergo_flutter/pages/courses/course_content.dart';
import 'package:abstergo_flutter/pages/layout/loading.dart';

class CoursesPage extends StatefulWidget {
  @override
  _CoursesPageState createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
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
      stream:
          Firestore.instance.collection('exam').document(user.uid).snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Loading();
        }

        if (!snapshot.data.exists) {
          fetchSemesterInfo();
          fetchExamMarks();
          fetchExamGrades();
          return Center(
            child: Text(
              "Exam details unavailable.\nTrying to fetch from the server.",
              textAlign: TextAlign.center,
            ),
          );
        }

        List<Map> semesters = List.from(snapshot.data.data['semesters']);
        double cgpa = 0.0;
        if(snapshot.data.data['cgpa'] == null) {
          calculateCgpa();
        } else {
          cgpa = (snapshot.data.data['cgpa'] as num).toDouble();
        }
        return CourseContent(
          semesters: semesters,
          cgpa: cgpa,
           username: user.displayName,
        );
      },
    );
  }
}
