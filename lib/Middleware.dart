import 'dart:async';
import 'package:redux/redux.dart';
import 'package:abstergo_flutter/Actions.dart';
import 'package:abstergo_flutter/models/AppState.dart';
import 'package:tkiosk/tkiosk.dart';

void loggingMiddleware(Store<AppState> store, action, NextDispatcher next) {
  print('${new DateTime.now()}: $action');
  next(action);
}

void networkRequestMiddleware(Store<AppState> store, action, NextDispatcher next) async {

  switch(action) {
    case PersonalInfoFetchAction:
      store.dispatch(ExamInfoFetchAction);
      store.dispatch(SemesterInfoFetchAction);
      fetchPersonalInfo().then((PersonalInfo profile) {
        store.dispatch(PersonalInfoUpdateAction(profile));
      });
      break;
    case ExamInfoFetchAction:
      fetchExamGrades().then((List<ExamGrade> examGrades) {
        store.dispatch(ExamGradesUpdateAction(examGrades));
      });
      fetchExamMarks().then((List<ExamMark> examMarks) {
        store.dispatch(ExamMarksUpdateAction(examMarks));
      });
      break;
    case SemesterInfoFetchAction:
      fetchSemesterInfo().then((Map<Semester, List<Course>> semesters) {
        store.dispatch(SemesterInfoUpdateAction(semesters));
      });
      break;
  }

  next(action);
}

Future<PersonalInfo> fetchPersonalInfo() {
  WebKiosk swanav = WebKiosk("101504122", "2405");
  try {
    return swanav.login().then((bool loggedIn) {
      if(loggedIn) {
        return swanav.personalInfo().then((PersonalInfo profile) => profile);
      }
      return null;
    });
  } catch(ex) {
    print(ex.toString());
  }
  return null;
}

Future<Map<Semester, List<Course>>> fetchSemesterInfo() {
  WebKiosk swanav = WebKiosk("101504122", "2405");
  return swanav.login().then((bool loggedIn) {
    if(loggedIn) {
      return swanav.semesters()
        .then((Map<Semester, List<Course>> semesters) {
          if(semesters!=null) {
            return semesters;
          } else {
            print("WTF");
            return semesters;
          }
        })
        .catchError((error) {
          print("Error: $error");
        });
    }
  }).catchError((error) {
    print("Error: $error");
  });
}

Future<List<ExamGrade>> fetchExamGrades() {
  WebKiosk swanav = WebKiosk("101504122", "2405");
  try {
    return swanav.login().then((bool loggedIn) {
      if(loggedIn) {
        return swanav.examGrades().then((List<ExamGrade> examGrades) => examGrades);
      }
      return null;
    });
  } catch(ex) {
    print(ex.toString());
  }
  return null;
}

Future<List<ExamMark>> fetchExamMarks() {
  WebKiosk swanav = WebKiosk("101504122", "2405");
  try {
    return swanav.login().then((bool loggedIn) {
      if(loggedIn) {
        return swanav.examMarks().then((List<ExamMark> examMarks) => examMarks);
      }
      return null;
    });
  } catch(ex) {
    print(ex.toString());
  }
  return null;
}
