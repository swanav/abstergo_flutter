import 'package:tkiosk/tkiosk.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:abstergo_flutter/models/credentials.dart';

void fetchExamMarks() async {
  print("Fetching marks...");
  Credentials credentials = await Credentials.fetch();
  WebKiosk webkiosk = WebKiosk(credentials.rollNumber, credentials.password);
  DocumentReference ref =
      Firestore.instance.collection('exam').document(credentials.firebaseId);
  try {
    if (await webkiosk.login()) {
      List<ExamMark> examMarks = await webkiosk.examMarks();
      examMarks.forEach((ExamMark marks) {
        ref
            .collection(marks.examCode)
            .document(marks.subjectCode)
            .collection('marks')
            .document(marks.event)
            .setData(marks.toMap());
      });
    }
  } catch (ex) {
    print("Exception in fetching marks data.");
  }
}
