import 'package:meta/meta.dart';
import 'package:tkiosk/tkiosk.dart';

import 'package:abstergo_flutter/models/session.dart';
import 'package:abstergo_flutter/models/setting.dart';
import 'package:abstergo_flutter/models/settings.dart';

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
  final Map<String, String> subGroupData;

  AppState(
      {this.count = 0,
      this.isLoading = false,
      this.pageIndex = 1,
      this.personalInfo,
      this.examMarks,
      this.examGrades,
      this.semesters,
      this.settings = defaultSettings,
      this.session,
      this.subGroupData});

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
    Map<String, String> subGroupData,
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
      session: session ?? this.session,
      subGroupData: subGroupData ?? this.subGroupData,
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
      session.hashCode ^
      subGroupData.hashCode;

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
          session == other.session &&
          subGroupData == other.subGroupData;

  @override
  String toString() {
    return "AppState {count: $count , isLoading: $isLoading}";
  }

  dynamic toJson() => {
        'count': count,
        'isLoading': isLoading,
        'pageIndex': pageIndex,
        'session': session,
        'settings': settings,
        'semesters': semesters,
        'subGroupData': subGroupData,
        'personalInfo': personalInfo,
        'examMarks': examMarks,
        'examGrades': examGrades,
      };

  static AppState fromJson(dynamic json) {
    PersonalInfo personalInfo;
    if (json['personalInfo'] != null) {
      personalInfo = PersonalInfo(
        json['personalInfo']['name'],
        json['personalInfo']['enrollmentNumber'],
        json['personalInfo']['fatherName'],
        json['personalInfo']['program'],
        json['personalInfo']['branch'],
        json['personalInfo']['semester'],
        studentContact: ContactDetail(
          json['personalInfo']['studentContact']['mobile'],
          json['personalInfo']['studentContact']['telephone'],
          json['personalInfo']['studentContact']['email'],
        ),
        parentContact: ContactDetail(
          json['personalInfo']['parentContact']['mobile'],
          json['personalInfo']['parentContact']['telephone'],
          json['personalInfo']['parentContact']['email'],
        ),
        correspondenceAddress: Address(
          json['personalInfo']['correspondenceAddress']['address'],
          json['personalInfo']['correspondenceAddress']['district'],
          json['personalInfo']['correspondenceAddress']['city'],
          json['personalInfo']['correspondenceAddress']['state'],
          json['personalInfo']['correspondenceAddress']['pin'],
        ),
        permanentAddress: Address(
          json['personalInfo']['permanentAddress']['address'],
          json['personalInfo']['permanentAddress']['district'],
          json['personalInfo']['permanentAddress']['city'],
          json['personalInfo']['permanentAddress']['state'],
          json['personalInfo']['permanentAddress']['pin'],
        ),
      );
    }

    Map<String, String> subGroupData;
    if (json['subGroupData'] != null) {
      subGroupData = Map.from(json['subGroupData']);
    }

    Session session;
    if (json['session'] != null) {
      session = Session(
        isValid: json['session']['isValid'],
        username: json['session']['username'],
        password: json['session']['password'],
      );
    }

    return AppState(
      count: json['count'],
      isLoading: json['isLoading'],
      pageIndex: json['pageIndex'],
      session: session,
      // settings: Map.from(json['settings']),
      subGroupData: subGroupData,
      personalInfo: personalInfo,
      // semesters: Map.from(json['semesters']),
      // examMarks: json['examMarks'],
      // examGrades: json['examGrades'],
    );
  }
}
