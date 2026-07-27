import 'package:flutter_test/flutter_test.dart';
import 'package:classical_ly/features/onboarding/splash_screen.dart';

void main() {
  testWidgets('renders the splash identity', (tester) async {
    await tester.pumpWidget(const SplashScreen());
    expect(find.text('classical.ly'), findsOneWidget);
  });
}
