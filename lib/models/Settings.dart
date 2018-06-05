class Settings {

  final bool updateInBackground;

  const Settings({this.updateInBackground = true});

  static Settings defaultSettings() => Settings(updateInBackground: true);

}