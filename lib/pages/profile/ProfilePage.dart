import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:abstergo_flutter/models/AppState.dart';
import 'package:abstergo_flutter/pages/profile/ProfileContent.dart';
import 'package:tkiosk/tkiosk.dart';

class ProfilePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder:(context, vm) {
        if(vm.profile == null) {
          return Center(
            child: Text("Profile"),
          );
        }
        return Container(
          child: ProfileContent(vm.profile)
        );
      },
    );
  }
}

class _ViewModel {
  
  final PersonalInfo profile;

  _ViewModel({this.profile});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      profile: store.state.personalInfo
    );
  }
}
