import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class Behaviors {
  static Future<void> login(WidgetTester tester) async {
    final nameTextField = find.byKey(const Key('name'));
    final emailTextField = find.byKey(const Key('email'));
    await tester.enterText(nameTextField, "Raphael");
    expect(find.text('Raphael'), findsOneWidget);
    await tester.enterText(emailTextField, "raphael@test.com");
    expect(find.text('raphael@test.com'), findsOneWidget);
    final enterButton = find.byKey(const Key('enter'));
    await tester.pumpAndSettle();
    await tester.tap(enterButton);
  }
}
