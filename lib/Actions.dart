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

class SettingsChangeAction {
  final Settings settings;
  SettingsChangeAction(this.settings);
}

class NavigationChangeAction {
  final int pageIndex;
  NavigationChangeAction(this.pageIndex);
}