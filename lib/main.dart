import 'package:flutter/material.dart';
import 'package:TXApp/app/app_scene.dart';
import 'dart:io';
import 'package:flutter/services.dart';

void main() {
  runApp(AppScene());
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

