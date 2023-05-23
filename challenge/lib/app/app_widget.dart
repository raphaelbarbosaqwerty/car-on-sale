import 'package:challenge/app/modules/splash/presenter/splash_page.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Car on Sale - Challenge',
      home: SplashPage(),
    );
  }
}
