import 'package:first_app/components/custom_dropdown_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('filters items while the bottom sheet is open', (tester) async {
    final controller = TextEditingController();
    addTearDown(controller.dispose);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomDropdownList(
            textEditingController: controller,
            items: const ['Ahmed', 'Sara', 'Omar'],
          ),
        ),
      ),
    );

    await tester.tap(find.byType(TextFormField).first);
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).last, 'sar');
    await tester.pump();

    expect(find.text('Sara'), findsOneWidget);
    expect(find.text('Ahmed'), findsNothing);
    expect(find.text('Omar'), findsNothing);

    await tester.tap(find.byIcon(Icons.close));
    await tester.pump();

    expect(find.text('Ahmed'), findsOneWidget);
    expect(find.text('Sara'), findsOneWidget);
    expect(find.text('Omar'), findsOneWidget);
  });
}
