import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class FetchTimeTable {

  final String year;
  final String branch;
  final String group;
  final String semesterCode;

  CollectionReference get ref => Firestore.instance.collection('schedule')
      .document(year)
      .getCollection(branch)
      .document(group)
      .getCollection(semesterCode);

  FetchTimeTable(this.year, this.branch, this.group, this.semesterCode) {
    _fetchFromFirebase();
  }

  void _fetchFromFirebase() {
    ref.getDocuments().then (
            (QuerySnapshot data) => data.documents.forEach(
                (DocumentSnapshot document) => document
            )
    );
  }

  void _saveToSql(String id, Map<String, String> map) {

  }

}
