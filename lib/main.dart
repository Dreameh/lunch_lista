import 'package:flutter/material.dart';
import 'app.dart';
import 'package:flutter/services.dart';

void main() {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]).then((_) {
        runApp(App());
      });
}