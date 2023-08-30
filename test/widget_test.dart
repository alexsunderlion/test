// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:clubforce/app.dart';
import 'package:clubforce/core/injection/injection_container.dart' as di;
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App Loaded Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await di.init();
    await tester.pumpWidget(const App());

    // Verify that our counter starts at 0.
    expect(find.text('Artist'), findsOneWidget);
    expect(find.text('Album'), findsNothing);
    await tester.pumpAndSettle(const Duration(seconds: 5));

    expect(find.text('Fennesz'), findsOneWidget);
    await tester.tap(find.text('Fennesz'));
    await tester.pumpAndSettle();

    expect(find.text('Fennesz'), findsOneWidget);
  });
}
