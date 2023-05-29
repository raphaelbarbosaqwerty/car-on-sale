import 'package:challenge/app/modules/auth/presenter/auth_page.dart';
import 'package:challenge/app/modules/home/presenter/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// All flows related to the App.
class Behaviors {
  static Future<void> getCarAndGoesToShowPage(WidgetTester tester) async {
    expect(find.byType(AuthPage), findsOneWidget);
    await Behaviors.shouldGoToHomePage(tester);
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const Key('vinCode')),
      "3VWLL7AJ0EM408519",
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('search')));
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 4));
    await tester.pumpAndSettle();
  }

  static Future<void> shouldGoToHomePage(WidgetTester tester) async {
    expect(find.byType(AuthPage), findsOneWidget);
    await Behaviors.login(tester);
    await tester.pumpAndSettle();
    expect(find.byType(HomePage), findsOneWidget);
    await tester.pumpAndSettle();
  }

  static Future<void> login(
    WidgetTester tester, {
    String email = "raphael@test.com",
    String name = "Raphael Barbosa",
  }) async {
    final nameTextField = find.byKey(const Key('name'));
    final emailTextField = find.byKey(const Key('email'));
    await tester.enterText(nameTextField, name);
    expect(find.text(name), findsOneWidget);
    await tester.enterText(emailTextField, email);
    final enterButton = find.byKey(const Key('enter'));
    await tester.pumpAndSettle();
    await tester.tap(enterButton);
  }

  static Future<void> logout(WidgetTester tester) async {
    await tester.pumpAndSettle();
    final logoutButton = find.byKey(const Key('logout'));
    await tester.tap(logoutButton);
    await tester.pumpAndSettle();
    expect(find.byType(AuthPage), findsOneWidget);
  }
}
