import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mantine/mantine.dart';

void main() {
  testWidgets('MantineTooltip shows on hover', (tester) async {
    await tester.pumpWidget(
      MantineProvider(
        child: MaterialApp(
          home: Scaffold(
            body: const Center(
              child: MantineTooltip(
                label: Text('Tooltip text'),
                child: Text('Target'),
              ),
            ),
          ),
        ),
      ),
    );

    expect(find.text('Tooltip text'), findsNothing);

    final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
    await gesture.addPointer(location: Offset.zero);
    addTearDown(gesture.removePointer);

    await tester.pump();
    await gesture.moveTo(tester.getCenter(find.text('Target')));
    await tester.pumpAndSettle();

    expect(find.text('Tooltip text'), findsOneWidget);

    await gesture.moveTo(Offset.zero);
    await tester.pumpAndSettle();

    expect(find.text('Tooltip text'), findsNothing);
  });

  testWidgets('MantineTooltip honors openDelay', (tester) async {
    await tester.pumpWidget(
      MantineProvider(
        child: MaterialApp(
          home: Scaffold(
            body: const Center(
              child: MantineTooltip(
                label: Text('Tooltip text'),
                openDelay: 500,
                child: Text('Target'),
              ),
            ),
          ),
        ),
      ),
    );

    final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
    await gesture.addPointer(location: Offset.zero);
    addTearDown(gesture.removePointer);

    await gesture.moveTo(tester.getCenter(find.text('Target')));
    await tester.pump();

    // Should not be visible yet
    expect(find.text('Tooltip text'), findsNothing);

    await tester.pump(const Duration(milliseconds: 250));
    expect(find.text('Tooltip text'), findsNothing);

    await tester.pump(const Duration(milliseconds: 251));
    await tester.pumpAndSettle();
    expect(find.text('Tooltip text'), findsOneWidget);
  });
}
