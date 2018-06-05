import 'package:meta/meta.dart';
import 'package:tkiosk/tkiosk.dart';
import 'package:abstergo_flutter/models/Settings.dart';

@immutable
class AppState {
  final int count;
  final bool isLoading;
  final int pageIndex;

  final Settings settings;
  final PersonalInfo personalInfo;

  AppState({
    this.count = 0,
    this.isLoading = false,
    this.pageIndex = 1,
    this.personalInfo,
    this.settings = const Settings(updateInBackground: true),
  });

  factory AppState.loading() => AppState(
      personalInfo: PersonalInfo(
        "Swanav",
        "101504122",
        "Anuj Kumar",
        "BE",
        "ELE",
        "7",
        studentContact: ContactDetail("9821880713", "-", "sswanav@gmail.com"),
        parentContact:
            ContactDetail("8195904760", "-", "swanavswaroop@gmail.com"),
        correspondenceAddress: Address(
            "J-701, Mayurdhwaj Apartments,\nPlot No. 60,\nI. P. Extn.",
            "",
            "New Delhi",
            "Delhi",
            "110092"),
        permanentAddress: Address(
            "J-701, Mayurdhwaj Apartments,\nPlot No. 60, I.P. Extn.",
            "",
            "New Delhi",
            "Delhi",
            "110092"),
      ),
      isLoading: true);

  AppState copyWith({
    bool isLoading,
    int count,
    int pageIndex,
    PersonalInfo personalInfo,
    Settings settings,
  }) {
    return AppState(
      isLoading: isLoading ?? this.isLoading,
      count: count ?? this.count,
      pageIndex: pageIndex ?? this.pageIndex,
      personalInfo: personalInfo ?? this.personalInfo,
      settings: settings ?? this.settings,
    );
  }

  @override
  int get hashCode =>
      isLoading.hashCode ^
      count.hashCode ^
      pageIndex.hashCode ^
      personalInfo.hashCode ^
      settings.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          isLoading == other.isLoading &&
          count == other.count &&
          pageIndex == other.pageIndex &&
          personalInfo == other.personalInfo &&
          settings == other.settings;

  @override
  String toString() {
    return "AppState {count: $count , isLoading: $isLoading}";
  }
}
