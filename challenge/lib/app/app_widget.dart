import 'package:challenge/app/design/cos_theme.dart';
import 'package:challenge/app/modules/splash/presenter/splash_page.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: CosTheme.grayDark,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: CosTheme.grayDark,
        ),
      ),
      title: 'Car on Sale - Challenge',
      home: const SplashPage(),
    );
  }
}
