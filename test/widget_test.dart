// This is a basic Flutter widget test.
// To perform an interaction with a widget in your test, use the WidgetTester utility that Flutter
// provides. For example, you can send tap and scroll gestures. You can also use WidgetTester to
// find child widgets in the widget tree, read text, and verify that the values of widget properties
// are correct.

//import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:abstergo_flutter/Abstergo.dart';

void main() {
  testWidgets('Login Page encountered', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(Abstergo());

    // Verify that our counter starts at 0.
    expect(find.text('Roll Number'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Submit'), findsOneWidget);

    // Tap the '+' icon and trigger a frame.
    // await tester.enterText(find.text('Roll Number'), '101504122');
    // await tester.enterText(find.text('Password'), '2405');
    // await tester.tap(find.text('Submit'));
    // await tester.pump();

    // Verify that our counter has incremented.
    // expect(find.text('Login'), findsNothing);
    // expect(find.text('1'), findsOneWidget);
  });
}
