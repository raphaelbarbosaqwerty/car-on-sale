import 'package:challenge/app/modules/auth/presenter/auth_page.dart';
import 'package:challenge/app/modules/home/presenter/home_page.dart';
import 'package:challenge/main.dart' as app;
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../../../utils/behaviors.dart';
import '../../../utils/di.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() {
    setupTestsLocator();
  });

  group('01. SplashPage behavior', () {
    testWidgets('should goes to the AuthPage', (tester) async {
      await app.main(testing: true);
      await tester.pumpAndSettle();
      expect(find.byType(AuthPage), findsOneWidget);
    });

    testWidgets('should cache the user', (tester) async {
      await app.main(testing: true);
      await tester.pumpAndSettle();
      await Behaviors.shouldGoToHomePage(tester);
      await tester.pumpAndSettle();
    });

    testWidgets('should goes to the HomePage if exist cached user',
        (tester) async {
      await app.main(testing: true);
      await tester.pumpAndSettle();
      expect(find.byType(HomePage), findsOneWidget);
      await tester.pumpAndSettle();
    });
  });
}
