import 'package:flutter_test/flutter_test.dart';
import 'package:classical_ly/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('shows onboarding for a first-time musician', (tester) async {
    SharedPreferences.setMockInitialValues({});
    await tester.pumpWidget(const ClassicalLyApp());
    await tester.pumpAndSettle();
    expect(find.text('Begin your archive'), findsOneWidget);
  });
}
