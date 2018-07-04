import 'dart:async';
import 'package:redux/redux.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tkiosk/tkiosk.dart';

import 'package:abstergo_flutter/redux/actions.dart';
import 'package:abstergo_flutter/models/app_state.dart';
import 'package:abstergo_flutter/models/credentials.dart';

void loggingMiddleware(Store<AppState> store, action, NextDispatcher next) {
  print('${new DateTime.now()}: $action');
  next(action);
}

void networkRequestMiddleware(
    Store<AppState> store, action, NextDispatcher next) async {

  FirebaseUser user = await FirebaseAuth.instance.currentUser();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  
  Credentials credentials = Credentials(
    preferences.getString("rollNumber"),
    preferences.getString("password"),
  );

  switch (action) {
    case PersonalInfoFetchAction:
      fetchPersonalInfo(credentials).then((PersonalInfo profile) {
        Firestore.instance
            .collection('profile')
            .document(user.uid)
            .setData(profile.toMap());
      }).catchError(errorHandler);
      fetchSubGroupInfo(credentials).then((Map<String,String> data) {
        store.dispatch(SubGroupUpdateAction(data));
        data.forEach((String key, String value) {
          preferences.setString(key, value);
        });
        preferences.commit();
      }).catchError(errorHandler);
      break;
    case ExamInfoFetchAction:
      fetchExamGrades(credentials).then((List<ExamGrade> examGrades) {
        store.dispatch(ExamGradesUpdateAction(examGrades));
      }).catchError(errorHandler);
      fetchExamMarks(credentials).then((List<ExamMark> examMarks) {
        store.dispatch(ExamMarksUpdateAction(examMarks));
      }).catchError(errorHandler);
      break;
    case SemesterInfoFetchAction:
      fetchSemesterInfo(credentials)
          .then((Map<Semester, List<Course>> semesters) {
        store.dispatch(SemesterInfoUpdateAction(semesters));
      }).catchError(errorHandler);
      break;
  }

  next(action);
}

Future<bool> attemptLogin(Credentials credentials) {
  WebKiosk webkiosk = WebKiosk(credentials.rollNumber, credentials.password);
  try {
    return webkiosk.login();
  } catch (ex) {
    print(ex.toString());
    return Future(() => false);
  }
}

Future<PersonalInfo> fetchPersonalInfo(Credentials credentials) {
  WebKiosk webkiosk = WebKiosk(credentials.rollNumber, credentials.password);
  try {
    return webkiosk.login().then((bool loggedIn) {
      if (loggedIn) {
        return webkiosk.personalInfo().then((PersonalInfo profile) => profile);
      }
      return Future(null);
    });
  } catch (ex) {
    print(ex.toString());
  }
  return Future(null);
}

Future<Map<String, String>> fetchSubGroupInfo(Credentials credentials) {
  WebKiosk webkiosk = WebKiosk(credentials.rollNumber, credentials.password);
  try {
    return webkiosk.login().then((bool loggedIn) {
      if (loggedIn) {
        return webkiosk.subGroup().then((Map<String, String> data) => data);
      }
      return Future(null);
    });
  } catch (ex) {
    print(ex.toString());
  }
  return Future(null);
}

Future<Map<Semester, List<Course>>> fetchSemesterInfo(Credentials credentials) {
  
  WebKiosk webkiosk = WebKiosk(credentials.rollNumber, credentials.password);
  return webkiosk.login().then((bool loggedIn) {
    if (loggedIn) {
      return webkiosk.semesters().then((Map<Semester, List<Course>> semesters) {
        if (semesters != null) {
          return semesters;
        } else {
          print("WTF");
          return semesters;
        }
      }).catchError((error) {
        print("Error: $error");
      });
    }
  }).catchError((error) {
    print("Error: $error");
  });
}

Future<List<ExamGrade>> fetchExamGrades(Credentials credentials) {
  
  WebKiosk webkiosk = WebKiosk(credentials.rollNumber, credentials.password);
  try {
    return webkiosk.login().then((bool loggedIn) {
      if (loggedIn) {
        return webkiosk
            .examGrades()
            .then((List<ExamGrade> examGrades) => examGrades);
      }
      return Future(null);
    });
  } catch (ex) {
    print(ex.toString());
  }
  return Future(null);
}

Future<List<ExamMark>> fetchExamMarks(Credentials credentials) {
  WebKiosk webkiosk = WebKiosk(credentials.rollNumber, credentials.password);
  try {
    return webkiosk.login().then((bool loggedIn) {
      if (loggedIn) {
        return webkiosk
            .examMarks()
            .then((List<ExamMark> examMarks) => examMarks);
      }
      return Future(null);
    });
  } catch (ex) {
    print(ex.toString());
  }
  return Future(null);
}

void errorHandler(Exception e) {
  print(e);
}
