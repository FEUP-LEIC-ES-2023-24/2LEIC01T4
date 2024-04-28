// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:get_a_lift/homePage.dart';
import 'package:get_a_lift/report.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  testWidgets('ReportPage displays AppBar with correct title', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ReportPage()));
    expect(find.text('Report an Incident'), findsOneWidget);
  });

  testWidgets('ReportPage displays TextField for report reason', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ReportPage()));
    expect(find.widgetWithText(TextField, 'Enter the reason for the report'), findsOneWidget);
  });

  testWidgets('ReportPage displays TextField for driver name', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ReportPage()));
    expect(find.widgetWithText(TextField, 'Enter the name of the driver you are reporting'), findsOneWidget);
  });

  testWidgets('ReportPage displays TextField for incident description', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ReportPage()));
    expect(find.widgetWithText(TextField, 'Description of the incident'), findsOneWidget);
  });

  testWidgets('Submit button click with empty fields shows toast message', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ReportPage()));
    await tester.tap(find.text('Submit'));
    await tester.pumpAndSettle();
    expect(find.text('Please fill in all fields!'), findsOneWidget);
  });

  testWidgets('Submit button click with filled fields navigates to HomePage', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ReportPage()));
    // Fill the text fields
    await tester.enterText(find.widgetWithText(TextField, 'Enter the reason for the report'), 'Reason');
    await tester.enterText(find.widgetWithText(TextField, 'Enter the name of the driver you are reporting'), 'Driver');
    await tester.enterText(find.widgetWithText(TextField, 'Description of the incident'), 'Description');
    await tester.tap(find.text('Submit'));
    await tester.pumpAndSettle();
    expect(find.byType(HomePage), findsOneWidget);
  });
}
