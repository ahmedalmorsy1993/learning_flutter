// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:first_app/main.dart';
import 'package:first_app/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('selecting Home does not stack another HomePage', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.byType(HomePage), findsOneWidget);
    expect(find.text('Home Page'), findsNothing);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    final aboutDrawerItem = find.widgetWithText(ListTile, 'AboutUs');
    expect(aboutDrawerItem, findsOneWidget);
    await tester.tap(aboutDrawerItem);
    await tester.pumpAndSettle();

    expect(find.text('This is the About Us page.'), findsOneWidget);
    expect(find.byTooltip('Back'), findsOneWidget);
    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();

    expect(find.byType(HomePage), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();
    final homeDrawerItem = find.widgetWithText(ListTile, 'Home');
    expect(homeDrawerItem, findsOneWidget);
    await tester.tap(homeDrawerItem);
    await tester.pumpAndSettle();

    expect(find.byType(HomePage), findsOneWidget);
    expect(find.text('Home Page'), findsNothing);
    expect(find.widgetWithText(ListTile, 'Home'), findsNothing);
  });
}
