import 'package:first_app/pages/aboutus.dart';
import 'package:first_app/timer_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('Aboutus counts down each second and stops when removed', (
    tester,
  ) async {
    final timerInfo = TimerInfo();
    addTearDown(timerInfo.dispose);

    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: timerInfo,
        child: const MaterialApp(home: Scaffold(body: Aboutus())),
      ),
    );
    await tester.pump();
    expect(tester.takeException(), isNull);
    await tester.scrollUntilVisible(
      find.byType(Consumer<TimerInfo>),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('59'), findsOneWidget);

    await tester.pump(const Duration(seconds: 1));
    expect(find.text('58'), findsOneWidget);
    expect(find.text('59'), findsNothing);
    expect(tester.takeException(), isNull);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(seconds: 2));
    expect(timerInfo.remainingTime, 58);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Aboutus countdown stops notifying at zero', (tester) async {
    final timerInfo = TimerInfo();
    addTearDown(timerInfo.dispose);
    for (var i = 0; i < 58; i++) {
      timerInfo.updateRemainingTime();
    }
    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: timerInfo,
        child: const MaterialApp(home: Scaffold(body: Aboutus())),
      ),
    );
    await tester.pump(const Duration(seconds: 1));
    expect(timerInfo.remainingTime, 0);
    var notifications = 0;
    timerInfo.addListener(() => notifications++);
    await tester.pump(const Duration(seconds: 3));
    expect(timerInfo.remainingTime, 0);
    expect(notifications, 0);
    await tester.pumpWidget(const SizedBox.shrink());
  });
}
