import 'package:challenge/app/app_widget.dart';
import 'package:challenge/app/core/di.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main({bool testing = false}) async {
  if (!testing) {
    setupLocator();
  }

  await Hive.initFlutter();
  runApp(const MyApp());
}
