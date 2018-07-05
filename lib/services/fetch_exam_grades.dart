import 'package:tkiosk/tkiosk.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:abstergo_flutter/models/credentials.dart';

void fetchExamGrades() async {
  print("Fetching grades...");
  Credentials credentials = await Credentials.fetch();
  WebKiosk webkiosk = WebKiosk(credentials.rollNumber, credentials.password);
  DocumentReference ref =
      Firestore.instance.collection('exam').document(credentials.firebaseId);
  try {
    if (await webkiosk.login()) {
      List<ExamGrade> examGrades = await webkiosk.examGrades();
      examGrades.forEach((ExamGrade grade) {
        ref
            .collection(grade.examCode)
            .document(grade.subjectCode)
            .setData(grade.toMap(), merge: true);
      });
    }
  } catch (ex) {
    print("Exception in fetching grades data.");
  }
}
