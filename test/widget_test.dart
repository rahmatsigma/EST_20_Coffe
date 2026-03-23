import 'package:flutter_test/flutter_test.dart';
import 'package:est20coffee/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const Est20CoffeeApp());
    expect(find.text('EST 20 COFFEE'), findsAny);
  });
}
