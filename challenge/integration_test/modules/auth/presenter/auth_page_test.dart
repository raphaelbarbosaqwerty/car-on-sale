import 'package:challenge/main.dart' as app;
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../../../utils/behaviors.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('02. AuthPage E2E', () {
    testWidgets('Validate if user can login and logout', (tester) async {
      app.main();
      await tester.pumpAndSettle();
      expect(find.text('Welcome'), findsOneWidget);
      await Behaviors.login(tester);
      await tester.pumpAndSettle();
      expect(find.text('Home'), findsOneWidget);
      final logoutButton = find.byKey(const Key('logout'));
      await tester.tap(logoutButton);
      await tester.pumpAndSettle();
      expect(find.text('Welcome'), findsOneWidget);
    });
  });
}
