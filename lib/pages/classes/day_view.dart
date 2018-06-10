import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:abstergo_flutter/models/app_state.dart';
import 'package:abstergo_flutter/models/class_details.dart';
import 'package:abstergo_flutter/pages/classes/day_view_row.dart';

class DayView extends StatelessWidget {
  final String day;

  DayView(this.day);

  List<Widget> dayViewGenerator(classes) {
    List<Widget> days = List();
    classes.forEach((dynamic clas) {
      days.add(DayViewRow(ClassDetails.fromMap(clas)));
    });
    return days;
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: _ViewModel.fromStore,
        builder: (context, vm) {
          return StreamBuilder(
              stream: Firestore.instance
                  .collection('schedule')
                  .document(vm.semesterCode)
                  .getCollection(vm.subGroup)
                  .document(day)
                  .snapshots,
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data.data == null) {
                  return Center(child: Text('Loading Time Table...'));
                }

                return ListView(
                  children: dayViewGenerator(snapshot.data.data['classes']),
                );
              });
        });
  }
}

class _ViewModel {
  final String branchCode;
  final String subGroup;
  final String semesterCode;

  _ViewModel(
      {this.branchCode, this.semesterCode, this.subGroup});

  static _ViewModel fromStore(Store<AppState> store) {
    if (store.state.personalInfo != null) {
      return _ViewModel(
        branchCode: store.state.personalInfo.branch,
        semesterCode: store.state.subGroupData["semesterCode"],
        subGroup: store.state.subGroupData["subGroup"],
      );
    }
    return _ViewModel();
  }
}