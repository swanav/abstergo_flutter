import 'dart:async';
import 'package:redux/redux.dart';
import 'package:abstergo_flutter/Actions.dart';
import 'package:abstergo_flutter/models/AppState.dart';
import 'package:tkiosk/tkiosk.dart';

loggingMiddleware(Store<AppState> store, action, NextDispatcher next) {
  print('${new DateTime.now()}: ${action.runtimeType}');

  next(action);
}

networkRequestMiddleware(Store<AppState> store, action, NextDispatcher next) async {

  switch(action) {
    case PersonalInfoFetchAction:
      getPersonalInfo(store);
      break;
    default:
      print("No action required");
  }
  
  
  print("passed");
  next(action);
}

getPersonalInfo(Store<AppState> store) {
  WebKiosk swanav = WebKiosk("101504122", "2405");
  try {
    swanav.login().then((bool loggedIn) {
      if(loggedIn) {
        print("logged in");
        return swanav.personalInfo();
      } else {
        print("logged out");
      }
      print("ye function toh khatam");
      return null;
    }).then((PersonalInfo personalInfo) {
      print("yahaan hu");
      if(personalInfo != null) {
        store.dispatch(PersonalInfoUpdateAction(personalInfo));
        print(personalInfo.name);
      } else {
        print("Nahi hua yaar");
      }
    });
  } catch(ex) {
    print(ex.toString());
  }
}