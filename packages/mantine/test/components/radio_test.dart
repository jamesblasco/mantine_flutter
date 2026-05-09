import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mantine/mantine.dart';

void main() {
  testWidgets('MantineRadioGroup and MantineRadio work together', (tester) async {
    String? selectedValue;

    await tester.pumpWidget(
      MantineProvider(
        theme: MantineThemeData(),
        child: MaterialApp(
          home: Scaffold(
            body: MantineRadioGroup<String>(
              value: selectedValue,
              onChanged: (value) => selectedValue = value,
              child: const Column(
                children: [
                  MantineRadio(value: 'a', label: 'Option A'),
                  MantineRadio(value: 'b', label: 'Option B'),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    expect(find.text('Option A'), findsOneWidget);
    expect(find.text('Option B'), findsOneWidget);

    // Tap on Option B
    await tester.tap(find.text('Option B'));
    await tester.pump();

    expect(selectedValue, equals('b'));
  });

  testWidgets('MantineRadio supports custom colors and sizes', (tester) async {
    await tester.pumpWidget(
      MantineProvider(
        theme: MantineThemeData(),
        child: const MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                MantineRadio(
                  value: 'xs',
                  label: 'XS',
                  size: MantineSize.xs,
                  color: 'red',
                ),
                MantineRadio(
                  value: 'xl',
                  label: 'XL',
                  size: MantineSize.xl,
                  color: 'blue',
                ),
              ],
            ),
          ),
        ),
      ),
    );

    expect(find.text('XS'), findsOneWidget);
    expect(find.text('XL'), findsOneWidget);
  });
}
