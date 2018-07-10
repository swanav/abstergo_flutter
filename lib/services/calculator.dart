import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

int gradeToGradePoint(String grade) {
  switch (grade) {
    case 'A+':
    case 'A':
      return 10;
    case 'A-':
      return 9;
    case 'B':
      return 8;
    case 'B-':
      return 7;
    case 'C':
      return 6;
    case 'C-':
      return 5;
    case 'E':
      return 4;
    default:
      return 3;
  }
}

calculateSgpa(String examCode) async {
  FirebaseUser user = await FirebaseAuth.instance.currentUser();
  DocumentReference docRef =
      Firestore.instance.collection('exam').document(user.uid);
  DocumentSnapshot userExamRecord = await docRef.get();
  if (userExamRecord.exists) {
    List<Map<dynamic, dynamic>> shallowSemesters =
        List.from(userExamRecord.data['semesters']);
    List<Map<dynamic, dynamic>> semesters = List();
    await Future.forEach(shallowSemesters, (shallowSemester) async {
      Map sem = Map.from(shallowSemester);
      QuerySnapshot snapshot =
          await docRef.collection(sem['code']).getDocuments();
      num totalCredits = 0;
      num totalPoints = 0;
      if (snapshot.documents.length > 0) {
        snapshot.documents.forEach((document) {
          Map<dynamic, dynamic> data = document.data;
          totalCredits += data['credits'];
          totalPoints +=
              gradeToGradePoint(data['gradeObtained']) * data['credits'];
        });
      }
      num sgpa = totalPoints / totalCredits;
      print(sgpa);
      semesters.add({
        'code': sem['code'],
        'sgpa': sgpa,
        'credits': totalCredits,
      });
    });

    docRef.setData({'semesters': semesters}, merge: true);
  }
}

calculateCgpa() async {
  FirebaseUser user = await FirebaseAuth.instance.currentUser();
  DocumentReference docRef =
      Firestore.instance.collection('exam').document(user.uid);
  DocumentSnapshot userExamRecord = await docRef.get();
  if (userExamRecord.exists) {
    List<Map<dynamic, dynamic>> semesters =
        List.from(userExamRecord.data['semesters']);
    num cgpa = 0.0;
    num totalCredits = 0;
    num totalPoints = 0;
    semesters.forEach((semester) {
      totalCredits += semester['credits'];
      totalPoints += semester['sgpa'] * semester['credits'];
    });
    cgpa = totalPoints/totalCredits;
    docRef.setData({'cgpa': cgpa}, merge: true);
  }
}
