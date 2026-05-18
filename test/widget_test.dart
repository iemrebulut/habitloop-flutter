import 'package:flutter_test/flutter_test.dart';
import 'package:habitloop/app.dart';
import 'package:habitloop/core/constants/app_strings.dart';

void main() {
  testWidgets('onboarding ekranı marka adını ve CTA butonunu gösterir', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const HabitLoopApp());
    await tester.pump();

    expect(find.text(AppStrings.appName), findsOneWidget);
    expect(find.text(AppStrings.getStarted), findsOneWidget);
  });
}
