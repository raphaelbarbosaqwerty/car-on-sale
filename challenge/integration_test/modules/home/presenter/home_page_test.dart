import 'package:challenge/main.dart' as app;
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../../../utils/behaviors.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('03. AuthPage E2E', () {
    testWidgets('Validate if user can login and logout', (tester) async {
      app.main();
      await tester.pumpAndSettle();
      expect(find.text('Welcome'), findsOneWidget);
      await Behaviors.login(tester);
      await tester.pumpAndSettle();
      expect(find.text('Home'), findsOneWidget);
      await tester.pumpAndSettle();
      final vinCodeField = find.byKey(const Key('vinCode'));
      await tester.enterText(vinCodeField, "123456789AZCDVFDD");
      expect(find.text('123456789AZCDVFDD'), findsOneWidget);
      final vinCode = find.byKey(const Key('search'));
      await tester.pumpAndSettle(const Duration(seconds: 2));
      await tester.tap(vinCode);
      await tester.pumpAndSettle(const Duration(seconds: 10));
      await tester.pumpAndSettle();

      // for (var i = 0; i < 8; i++) {
      //   await tester.tap(vinCode);
      //   await tester.pumpAndSettle();
      // }
    });
  });
}
