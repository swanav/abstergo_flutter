import 'package:tkiosk/tkiosk.dart';
import 'package:abstergo_flutter/Actions.dart';
import 'package:abstergo_flutter/models/AppState.dart';
import 'package:abstergo_flutter/models/Settings.dart';

AppState appReducer(AppState state, action) {
  print(action.runtimeType);
  return AppState(
    count: countReducer(state.count, action),
    isLoading: loadingReducer(state.isLoading, action),
    settings: settingsReducer(state.settings, action),
    pageIndex: navigationReducer(state.pageIndex, action),
    personalInfo: personalInfoReducer(state.personalInfo, action)
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
