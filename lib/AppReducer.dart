import 'package:tkiosk/tkiosk.dart';
import 'package:abstergo_flutter/Actions.dart';
import 'package:abstergo_flutter/models/AppState.dart';
import 'package:abstergo_flutter/models/Settings.dart';

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
  );
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

Settings settingsReducer(Settings settings, action) {
  switch(action) {
    case SettingsChangeAction:
      return action.settings;
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
