import 'package:challenge/app/modules/auth/presenter/auth_page.dart';
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

  group('02. Authentication', () {
    testWidgets('should got error if try to login with invalid email',
        (tester) async {
      await app.main(testing: true);
      await tester.pumpAndSettle();
      expect(find.byType(AuthPage), findsOneWidget);
      await Behaviors.login(tester, email: "raphael.com");
      await tester.pumpAndSettle();
      expect(find.text('Email invalid'), findsOneWidget);
    });

    testWidgets('should do the login', (tester) async {
      await app.main(testing: true);
      await tester.pumpAndSettle();
      await Behaviors.shouldGoToHomePage(tester);
      await tester.pumpAndSettle();
    });
    testWidgets('should do the logout', (tester) async {
      await app.main(testing: true);
      await Behaviors.logout(tester);
      await tester.pumpAndSettle();
    });
  });
}
