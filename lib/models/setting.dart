import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class Setting<T> {
  final String heading;
  final String description;
  final IconData icon;
  final T value;

  const Setting({
    @required this.heading,
    this.description,
    this.icon,
    this.value,
  });

  static Setting changeSetting<T>(Setting setting, T value) {
    return Setting(
      heading: setting.heading,
      description: setting.description,
      icon: setting.icon,
      value: value,
    );
  }
}
