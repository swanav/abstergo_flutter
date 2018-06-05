import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'package:abstergo_flutter/models/AppState.dart';

import 'package:abstergo_flutter/pages/courses/CoursesPage.dart';
import 'package:abstergo_flutter/pages/classes/ClassesPage.dart';
import 'package:abstergo_flutter/pages/profile/ProfilePage.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        switch(vm.pageIndex) {
          case 0:
            return CoursesPage();
          case 1:
            return ClassesPage();
          case 2:
            return ProfilePage();
        }
      },
    );
  }
}

class _ViewModel {

  final int pageIndex;

  _ViewModel({this.pageIndex});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      pageIndex: store.state.pageIndex
    );
  }
}
