import 'dart:async';
import 'package:redux/redux.dart';
import 'package:abstergo_flutter/redux/actions.dart';
import 'package:abstergo_flutter/models/app_state.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:abstergo_flutter/models/session.dart';
import 'package:tkiosk/tkiosk.dart';

void loggingMiddleware(Store<AppState> store, action, NextDispatcher next) {
  print('${new DateTime.now()}: $action');
  next(action);
}

void networkRequestMiddleware(
    Store<AppState> store, action, NextDispatcher next) async {
  if (action.runtimeType == LoginAction) {
    attemptLogin(action.session).then((loginStatus) {
      if (loginStatus) {
        store.dispatch(LoginSuccessAction);
        Session session = action.session;
        FirebaseAuth.instance
            .signInWithEmailAndPassword(
          email: "${session.username}@thapar.abstergo.me",
          password: "${session.password}@tu123",
        )
            .catchError((error) {
          return FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: "${session.username}@thapar.abstergo.me",
            password: "${session.password}@tu123",
          );
        }).then((FirebaseUser user) async {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          preferences.setString("rollNumber", session.username);
          preferences.setString("password", session.password);
          preferences.setString("fb-username", user.email);
          preferences.setString("fb-password", "${session.password}@tu123");
          preferences.setString("uid", user.uid);
          preferences.commit();
        });
      } else {
        store.dispatch(LoginFailedAction);
      }
    });
  }

  FirebaseUser user = await FirebaseAuth.instance.currentUser();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  Session session = Session(
    username: preferences.getString("rollNumber"),
    password: preferences.getString("password"),
  );
  print(session);
  switch (action) {
    case PersonalInfoFetchAction:
      store.dispatch(SemesterInfoFetchAction);
      store.dispatch(ExamInfoFetchAction);
      // fetchPersonalInfo(session).then((PersonalInfo profile) {
      //   Firestore.instance
      //       .collection('profile')
      //       .document(user.uid)
      //       .setData(profile.toMap());
      // }).catchError(errorHandler);
      fetchSubGroupInfo(session).then((Map data) {
        store.dispatch(SubGroupUpdateAction(data));
      }).catchError(errorHandler);
      break;
    case ExamInfoFetchAction:
      fetchExamGrades(session).then((List<ExamGrade> examGrades) {
        store.dispatch(ExamGradesUpdateAction(examGrades));
      }).catchError(errorHandler);
      fetchExamMarks(session).then((List<ExamMark> examMarks) {
        store.dispatch(ExamMarksUpdateAction(examMarks));
      }).catchError(errorHandler);
      break;
    case SemesterInfoFetchAction:
      fetchSemesterInfo(session)
          .then((Map<Semester, List<Course>> semesters) {
        store.dispatch(SemesterInfoUpdateAction(semesters));
      }).catchError(errorHandler);
      break;
  }

  next(action);
}

Future<bool> attemptLogin(Session session) {
  WebKiosk webkiosk = WebKiosk(session.username, session.password);
  try {
    return webkiosk.login();
  } catch (ex) {
    print(ex.toString());
    return Future(() => false);
  }
}

Future<PersonalInfo> fetchPersonalInfo(Session session) {
  if (session == null) {
    return Future(null);
  }
  WebKiosk webkiosk = WebKiosk(session.username, session.password);
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

Future<Map<String, String>> fetchSubGroupInfo(Session session) {
  if (session == null) {
    return Future(null);
  }
  WebKiosk webkiosk = WebKiosk(session.username, session.password);
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

Future<Map<Semester, List<Course>>> fetchSemesterInfo(Session session) {
  if (session == null) {
    return Future(null);
  }
  WebKiosk webkiosk = WebKiosk(session.username, session.password);
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

Future<List<ExamGrade>> fetchExamGrades(Session session) {
  if (session == null) {
    return Future(null);
  }
  WebKiosk webkiosk = WebKiosk(session.username, session.password);
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

Future<List<ExamMark>> fetchExamMarks(Session session) {
  if (session == null) {
    return Future(null);
  }
  WebKiosk webkiosk = WebKiosk(session.username, session.password);
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

errorHandler(e) {
  print(e);
}
