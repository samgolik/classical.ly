import 'package:flutter_test/flutter_test.dart';
import 'package:classical_ly/main.dart';

void main() {
  testWidgets('shows the repertoire feed', (tester) async {
    await tester.pumpWidget(const ClassicalLyApp());
    expect(find.text('classical.ly'), findsOneWidget);
    expect(find.text('Your recent performances'), findsOneWidget);
  });
}
