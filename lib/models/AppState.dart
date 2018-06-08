import 'package:meta/meta.dart';
import 'package:tkiosk/tkiosk.dart';
import 'package:abstergo_flutter/models/Setting.dart';
import 'package:abstergo_flutter/models/Settings.dart';
import 'package:abstergo_flutter/models/Session.dart';

@immutable
class AppState {
  final int count;
  final bool isLoading;
  final int pageIndex;

  final Map<String, Setting> settings;

  final PersonalInfo personalInfo;
  final List<ExamGrade> examGrades;
  final List<ExamMark> examMarks;
  final Map<Semester, List<Course>> semesters;
  final Session session;


  AppState({
    this.count = 0,
    this.isLoading = false,
    this.pageIndex = 1,
    this.personalInfo,
    this.examMarks,
    this.examGrades,
    this.semesters,
    this.settings = defaultSettings,
    this.session,
  });

  factory AppState.loading() => AppState(isLoading: true);

  AppState copyWith({
    bool isLoading,
    int count,
    int pageIndex,
    PersonalInfo personalInfo,
    List<ExamGrade> examGrades,
    List<ExamMark> examMarks,
    Map<Semester, List<Course>> semesters,
    Map<String, Setting> settings,
    Session session,
  }) {
    return AppState(
      isLoading: isLoading ?? this.isLoading,
      count: count ?? this.count,
      pageIndex: pageIndex ?? this.pageIndex,
      personalInfo: personalInfo ?? this.personalInfo,
      examGrades: examGrades ?? this.examGrades,
      examMarks: examMarks ?? this.examMarks,
      semesters: semesters ?? this.semesters,
      settings: settings ?? this.settings,
      session: session ?? this.session
    );
  }

  @override
  int get hashCode =>
      isLoading.hashCode ^
      count.hashCode ^
      pageIndex.hashCode ^
      personalInfo.hashCode ^
      examMarks.hashCode ^
      examGrades.hashCode ^
      semesters.hashCode ^
      settings.hashCode ^ 
      session.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          isLoading == other.isLoading &&
          count == other.count &&
          pageIndex == other.pageIndex &&
          personalInfo == other.personalInfo &&
          examGrades == other.examGrades &&
          examMarks == other.examMarks &&
          semesters == other.semesters &&
          settings == other.settings && 
          session == other.session;

  @override
  String toString() {
    return "AppState {count: $count , isLoading: $isLoading}";
  }
}
