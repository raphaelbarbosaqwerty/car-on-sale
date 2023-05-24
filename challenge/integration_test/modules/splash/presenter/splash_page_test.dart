import 'package:challenge/main.dart' as app;
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('01. SplashPage E2E - Validate navigation', () {
    testWidgets('Validate if user goes to AuthPage', (tester) async {
      app.main();
      await tester.pumpAndSettle();
      expect(find.text('Welcome'), findsOneWidget);
    });
  });
}
