import 'package:flutter_test/flutter_test.dart';

import 'package:frige_animation/main.dart';

void main() {
  testWidgets('app builds and shows home header', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump();
    expect(find.text('Your Fridge is empty'), findsOneWidget);
  });
}
