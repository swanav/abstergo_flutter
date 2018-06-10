import 'package:tkiosk/tkiosk.dart';
import 'package:abstergo_flutter/actions.dart';
import 'package:abstergo_flutter/models/app_state.dart';
import 'package:abstergo_flutter/models/setting.dart';
import 'package:abstergo_flutter/models/session.dart';

AppState appReducer(AppState state, action) {
  return AppState(
    count: countReducer(state.count, action),
    isLoading: loadingReducer(state.isLoading, action),
    settings: settingsReducer(state.settings, action),
    pageIndex: navigationReducer(state.pageIndex, action),
    personalInfo: personalInfoReducer(state.personalInfo, action),
    examMarks: examMarksReducer(state.examMarks, action),
    examGrades: examGradesReducer(state.examGrades, action),
    semesters: semestersInfoReducer(state.semesters, action),
    session: sessionReducer(state.session, action),
    subGroupData: subGroupDataReducer(state.subGroupData, action),
  );
}

Map<String,String> subGroupDataReducer(Map<String,String> subGroupData, action) {
  if(action.runtimeType == SubGroupUpdateAction) {
    return action.subgroupData;
  }
  return subGroupData;
}

Session sessionReducer(Session session, action) {
  if(action == LogoutAction) {
    return null;
  }
  if(action.runtimeType == LoginAction) {
    return action.session;
  } else if(action == LoginSuccessAction ) {
    return Session(
      password: session.password,
      username: session.username,
      isValid: true,
    );
  }
  return session;
}

PersonalInfo personalInfoReducer(PersonalInfo personalInfo, action) {
  if(action == PersonalInfoFetchAction) {
    return null;
  }
  if(action.runtimeType == PersonalInfoUpdateAction) {
    return action.personalInfo;
  }
  return personalInfo;
}

Map<Semester, List<Course>> semestersInfoReducer(Map<Semester, List<Course>> semesters, action) {
  if(action == SemesterInfoFetchAction) {
    return null;
  }
  if(action.runtimeType == SemesterInfoUpdateAction) {
    return action.semesters;
  }
  return semesters;
}

List<ExamMark> examMarksReducer(List<ExamMark> examMarks, action) {
  if(action == ExamInfoFetchAction) {
    return null;
  }
  if(action.runtimeType == ExamMarksUpdateAction) {
    return action.examMarks;
  }
  return examMarks;
}

List<ExamGrade> examGradesReducer(List<ExamGrade> examGrades, action) {
  if(action == ExamInfoFetchAction) {
    return null;
  }
  if(action.runtimeType == ExamGradesUpdateAction) {
    return action.examGrades;
  }
  return examGrades;
}

Map<String, Setting> settingsReducer(Map<String, Setting> settings, action) {
  switch(action.runtimeType) {
    case SettingsChangeAction:
      Map<String, Setting> newSettings = Map();
      newSettings.addAll(settings);
      newSettings[action.tag] = action.setting;
      return newSettings;
    default:
      return settings;
  }
}

bool loadingReducer(bool isLoading, action) {
  switch(action) {
    case LoadedAction:
      return false;
    default:
      return isLoading;
  }
}

int countReducer(int count, action) {
  switch(action.runtimeType) {
    case IncrementCount:
      return count+1;
    case DecrementCount:
      return count-1;
    default: 
      return count;
  }
}

int navigationReducer(int pageIndex, action) {
  switch(action.runtimeType) {
    case NavigationChangeAction:
      return action.pageIndex;
    default: 
      return pageIndex;
  }
}
