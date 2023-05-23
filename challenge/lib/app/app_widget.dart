import 'package:challenge/app/modules/auth/presenter/auth_page.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Car on Sale - Challenge',
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: GlobalTheme.yellowDark),
      //   useMaterial3: true,
      // ),
      home: const AuthPage(),
    );
  }
}
