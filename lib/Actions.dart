import 'package:tkiosk/tkiosk.dart';
import 'package:abstergo_flutter/models/Settings.dart';

class IncrementCount {}

class DecrementCount {}

class LoadedAction {}

class NotLoadedAction {}

class PersonalInfoFetchAction {}

class PersonalInfoUpdateAction {
  final PersonalInfo personalInfo;
  PersonalInfoUpdateAction(this.personalInfo);
}

class SemesterInfoFetchAction {}

class SemesterInfoUpdateAction {
  Map<Semester, List<Course>> semesters;
  SemesterInfoUpdateAction(this.semesters);
}


class ExamInfoFetchAction {}

class ExamMarksUpdateAction {
  final List<ExamMark> examMarks;
  ExamMarksUpdateAction(this.examMarks);
}

class ExamGradesUpdateAction {
  final List<ExamGrade> examGrades;
  ExamGradesUpdateAction(this.examGrades);
}

class SettingsChangeAction {
  final Settings settings;
  SettingsChangeAction(this.settings);
}

class NavigationChangeAction {
  final int pageIndex;
  NavigationChangeAction(this.pageIndex);
}