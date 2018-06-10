import 'dart:async';
import 'package:redux/redux.dart';
import 'package:abstergo_flutter/actions.dart';
import 'package:abstergo_flutter/models/app_state.dart';
import 'package:abstergo_flutter/models/session.dart';
import 'package:tkiosk/tkiosk.dart';

void loggingMiddleware(Store<AppState> store, action, NextDispatcher next) {
  print('${new DateTime.now()}: $action');
  next(action);
}

void persistanceMiddleware(Store<AppState> store, action, NextDispatcher next) {

  

  next(action);
}

void networkRequestMiddleware(Store<AppState> store, action, NextDispatcher next) async {

  if(action.runtimeType == LoginAction) {
    attemptLogin(action.session).then((loginStatus) {
      if(loginStatus) {
        store.dispatch(LoginSuccessAction);
      } else {
        store.dispatch(LoginFailedAction);
      }
    });
  }

  switch(action) {
    case PersonalInfoFetchAction:
      store.dispatch(SemesterInfoFetchAction);
      store.dispatch(ExamInfoFetchAction);
      fetchPersonalInfo(store.state.session).then((PersonalInfo profile) {
        store.dispatch(PersonalInfoUpdateAction(profile));
      }).catchError(errorHandler);
      fetchSubGroupInfo(store.state.session).then((Map data) {
        print(data.length);
        store.dispatch(SubGroupUpdateAction(data));
      }).catchError(errorHandler);
      break;
    case ExamInfoFetchAction:
      fetchExamGrades(store.state.session).then((List<ExamGrade> examGrades) {
        store.dispatch(ExamGradesUpdateAction(examGrades));
      }).catchError(errorHandler);
      fetchExamMarks(store.state.session).then((List<ExamMark> examMarks) {
        store.dispatch(ExamMarksUpdateAction(examMarks));
      }).catchError(errorHandler);
      break;
    case SemesterInfoFetchAction:
      fetchSemesterInfo(store.state.session).then((Map<Semester, List<Course>> semesters) {
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
  } catch(ex) {
    print(ex.toString());
    return Future(() => false);
  }
}

Future<PersonalInfo> fetchPersonalInfo(Session session) {
  if(session == null) {
    return Future(null);
  }
  WebKiosk webkiosk = WebKiosk(session.username, session.password);
  try {
    return webkiosk.login().then((bool loggedIn) {
      if(loggedIn) {
        return webkiosk.personalInfo().then((PersonalInfo profile) => profile);
      }
      return Future(null);
    });
  } catch(ex) {
    print(ex.toString());
  }
  return Future(null);
}

Future<Map<String, String>> fetchSubGroupInfo(Session session) {
  if(session == null) {
    return Future(null);
  }
  WebKiosk webkiosk = WebKiosk(session.username, session.password);
  try {
    return webkiosk.login().then((bool loggedIn) {
      if(loggedIn) {
        return webkiosk.subGroup().then((Map<String,String> data) => data);
      }
      return Future(null);
    });
  } catch(ex) {
    print(ex.toString());
  }
  return Future(null);
}

Future<Map<Semester, List<Course>>> fetchSemesterInfo(Session session) {
  if(session == null) {
    return Future(null);
  }
  WebKiosk webkiosk = WebKiosk(session.username, session.password);
  return webkiosk.login().then((bool loggedIn) {
    if(loggedIn) {
      return webkiosk.semesters()
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

Future<List<ExamGrade>> fetchExamGrades(Session session) {
  if(session == null) {
    return Future(null);
  }
  WebKiosk webkiosk = WebKiosk(session.username, session.password);
  try {
    return webkiosk.login().then((bool loggedIn) {
      if(loggedIn) {
        return webkiosk.examGrades().then((List<ExamGrade> examGrades) => examGrades);
      }
      return Future(null);
    });
  } catch(ex) {
    print(ex.toString());
  }
  return Future(null);
}

Future<List<ExamMark>> fetchExamMarks(Session session) {
  if(session == null) {
    return Future(null);
  }
  WebKiosk webkiosk = WebKiosk(session.username, session.password);
  try {
    return webkiosk.login().then((bool loggedIn) {
      if(loggedIn) {
        return webkiosk.examMarks().then((List<ExamMark> examMarks) => examMarks);
      }
      return Future(null);
    });
  } catch(ex) {
    print(ex.toString());
  }
  return Future(null);
}

errorHandler(e) {
  print(e);
}
