import 'package:challenge/app/app_widget.dart';
import 'package:challenge/app/core/di.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  setupLocator();
  await Hive.initFlutter();
  runApp(const MyApp());
}
