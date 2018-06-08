import 'dart:io';
import 'package:flutter/material.dart';
import 'package:abstergo_flutter/Abstergo.dart';
import 'package:flutter_stetho/flutter_stetho.dart';

void main() {  
  HttpOverrides.global = StethoHttpOverrides();
  return runApp(Abstergo());
}
