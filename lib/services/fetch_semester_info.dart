import 'package:tkiosk/tkiosk.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:abstergo_flutter/models/credentials.dart';

void fetchSemesterInfo() async {
  Credentials credentials = await Credentials.fetch();
  WebKiosk webkiosk = WebKiosk(credentials.rollNumber, credentials.password);
  DocumentReference ref =
      Firestore.instance.collection('exam').document(credentials.firebaseId);
  try {
    if (await webkiosk.login()) {
      Map<Semester, List<Course>> semesters = await webkiosk.semesters();
      List<Map<String, String>> listOfSemesters = List();
      semesters.forEach((Semester semester, List<Course> courses) {
        CollectionReference colRef = ref.collection(semester.code);
        courses.forEach((Course course) {
          colRef.document(course.subjectCode).setData(course.toMap(), merge: true);
        });
        listOfSemesters.add({'code': semester.code});
      });
      ref.setData({'semesters': listOfSemesters}, merge: true);
    }
  } catch (error) {
    print("Error: $error");
  }
}
