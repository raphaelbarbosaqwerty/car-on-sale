import 'package:challenge/app/modules/home/presenter/pages/show_car_page.dart';
import 'package:challenge/app/utils/cos_client.dart';
import 'package:challenge/main.dart' as app;
import 'package:flutter/semantics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../test/shared/json_data.dart';
import '../../../../../test/shared/mocks.dart';
import '../../../../utils/behaviors.dart';
import '../../../../utils/di.dart';

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

  group('04. ShowCarPage', () {
    testWidgets('should open the feedback snackbar', (tester) async {
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
      await Behaviors.getCarAndGoesToShowPage(tester);
      await tester.pumpAndSettle();
      expect(find.byType(ShowCarPage), findsOneWidget);
      await tester.tap(find.byKey(const Key('check_feedback')));
      await tester.pumpAndSettle();
      expect(find.byKey(const Key('snack_bar')), findsOneWidget);
    });
  });
}
