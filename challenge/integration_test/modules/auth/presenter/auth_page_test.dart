import 'package:challenge/main.dart' as app;
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../../../utils/behaviors.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  Future<void> initialStepper(WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    expect(find.text('Welcome'), findsOneWidget);
    await Behaviors.login(tester);
    await tester.pumpAndSettle();
    expect(find.text('Home'), findsOneWidget);
    await tester.pumpAndSettle();
  }

  group('02. Authentication', () {
    testWidgets('Validate if user can login', (tester) async {
      await initialStepper(tester);
      tearDownAll(() => tester);
    });

    testWidgets('Validate if user can Logout and goes to AuthPage',
        (tester) async {
      await initialStepper(tester);
      final logoutButton = find.byKey(const Key('logout'));
      await tester.tap(logoutButton);
      await tester.pumpAndSettle();
      expect(find.text('Welcome'), findsOneWidget);
    });
  });
}
