import 'package:flutter_test/flutter_test.dart';
import 'package:chapter_6_sceen/main.dart';

void main() {
  testWidgets('App builds', (tester) async {
    await tester.pumpWidget(const Chapter6Screen());
    expect(find.byType(Chapter6Screen), findsOneWidget);
  });
}
