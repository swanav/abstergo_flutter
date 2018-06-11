import 'package:abstergo_flutter/models/setting.dart';
import 'package:abstergo_flutter/res/icons.dart';

class Settings {
  static const String BACKGROUND_UPDATES = "background-updates";
  static const String USER_NAME = "user-name";
  static const String PASSWORD = "password";

  static Setting<T> changeSetting<T>(Setting<T> setting, T value) {
    return Setting(
      heading: setting.heading,
      description: setting.description,
      // icon: setting.icon,
      value: value
    );
  }
}

const Map<String, Setting> defaultSettings = {
  Settings.BACKGROUND_UPDATES: Setting<bool>(
    heading: "Background Updates",
    description: "Update in background",
    // icon: AppIcons.SETTINGS_BACKGROUND,
    value: true,
  ),
  Settings.USER_NAME: Setting<String>(
    heading: "Roll Number",
    description: "Please enter your roll number",
    // icon: AppIcons.SETTINGS_USERNAME,
    value: null
  ),
  Settings.PASSWORD: Setting<String>(
    heading: "Password",
    description: "Please enter your password",
    // icon: AppIcons.SETTINGS_PASSWORD,
    value: null
  ),
};
