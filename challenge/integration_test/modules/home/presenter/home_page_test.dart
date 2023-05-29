import 'package:challenge/app/modules/auth/presenter/auth_page.dart';
import 'package:challenge/app/modules/home/presenter/pages/show_car_page.dart';
import 'package:challenge/app/utils/cos_client.dart';
import 'package:challenge/main.dart' as app;
import 'package:flutter/semantics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../test/shared/json_data.dart';
import '../../../utils/behaviors.dart';
import '../../../utils/di.dart';
import '../../../../test/shared/mocks.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  late MockHttpClient client;

  setUpAll(() {
    setupTestsLocator();
    client = locator.get<MockHttpClient>();
  });

  tearDownAll(() {
    client.close();
  });

  group('03. HomePage', () {
    testWidgets('should try to search with an incomplete VIN code',
        (tester) async {
      await app.main(testing: true);
      await tester.pumpAndSettle();
      expect(find.byType(AuthPage), findsOneWidget);
      await Behaviors.shouldGoToHomePage(tester);
      await tester.pumpAndSettle();
      await tester.enterText(
        find.byKey(const Key('vinCode')),
        "INCORRECTVINCODE",
      );
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('search')));
      await tester.pumpAndSettle();
      expect(find.text('VIN should contain 17 characters'), findsOneWidget);
    });

    testWidgets('should got status 200 and goes to the ShowPage',
        (tester) async {
      when(() => client.get(
            Uri.https('anyUrl'),
            headers: {
              CosChallenge.user: 'someUserId',
            },
          )).thenAnswer(
        (_) async => Response(
          carInformationWithCorrectJsonFormat,
          200,
        ),
      );

      await app.main(testing: true);
      await tester.pumpAndSettle();
      await tester.enterText(
        find.byKey(const Key('vinCode')),
        "3VWLL7AJ0EM408519",
      );
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('search')));
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 2));
      await tester.pumpAndSettle();
      expect(find.byType(ShowCarPage), findsOneWidget);
    });

    testWidgets('should got status 300 and shows the suggestion list',
        (tester) async {
      when(() => client.get(
            Uri.https('anyUrl'),
            headers: {
              CosChallenge.user: 'someUserId',
            },
          )).thenAnswer(
        (_) async => Response(
          multiplesOptionsStatus300,
          300,
        ),
      );

      await app.main(testing: true);
      await tester.pumpAndSettle();
      await tester.enterText(
        find.byKey(const Key('vinCode')),
        "3VWLL7AJ0EM408519",
      );
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('search')));
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 2));
      expect(find.byKey(const Key('cos_preview_list')), findsOneWidget);
      await tester.tap(find.byKey(const Key('close_alert_button')));
      await tester.pumpAndSettle();
      expect(find.byKey(const Key('cos_preview_list')), findsNothing);
    });

    testWidgets('should got status 400 and show the Snackbar error',
        (tester) async {
      when(() => client.get(
            Uri.https('anyUrl'),
            headers: {
              CosChallenge.user: 'someUserId',
            },
          )).thenAnswer(
        (_) async => Response(
          error400,
          400,
        ),
      );

      await app.main(testing: true);
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
      expect(find.byKey(const Key('snack_bar_error')), findsOneWidget);
    });
  });
}
