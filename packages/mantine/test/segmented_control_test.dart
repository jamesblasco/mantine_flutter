import 'package:flutter_test/flutter_test.dart';
import 'package:mantine/mantine.dart';
import 'package:flutter/widgets.dart';

void main() {
  testWidgets('MantineSegmentedControl renders items', (tester) async {
    await tester.pumpWidget(
      MantineProvider(
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: MantineSegmentedControl<String>(
            data: const [
              MantineSegmentedControlItem(label: Text('Item 1'), value: '1'),
              MantineSegmentedControlItem(label: Text('Item 2'), value: '2'),
            ],
          ),
        ),
      ),
    );

    expect(find.text('Item 1'), findsOneWidget);
    expect(find.text('Item 2'), findsOneWidget);
  });

  testWidgets('MantineSegmentedControl.strings factory works', (tester) async {
    await tester.pumpWidget(
      MantineProvider(
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: MantineSegmentedControl.strings(
            data: const ['React', 'Angular'],
          ),
        ),
      ),
    );

    expect(find.text('React'), findsOneWidget);
    expect(find.text('Angular'), findsOneWidget);
  });

  testWidgets('MantineSegmentedControl changes value on tap', (tester) async {
    String? changedValue;
    await tester.pumpWidget(
      MantineProvider(
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: MantineSegmentedControl<String>(
            onChanged: (val) => changedValue = val,
            data: const [
              MantineSegmentedControlItem(label: Text('Item 1'), value: '1'),
              MantineSegmentedControlItem(label: Text('Item 2'), value: '2'),
            ],
          ),
        ),
      ),
    );

    await tester.tap(find.text('Item 2'));
    await tester.pumpAndSettle();

    expect(changedValue, equals('2'));
  });

  testWidgets('MantineSegmentedControl respects disabled state', (tester) async {
    String? changedValue;
    await tester.pumpWidget(
      MantineProvider(
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: MantineSegmentedControl<String>(
            disabled: true,
            onChanged: (val) => changedValue = val,
            data: const [
              MantineSegmentedControlItem(label: Text('Item 1'), value: '1'),
              MantineSegmentedControlItem(label: Text('Item 2'), value: '2'),
            ],
          ),
        ),
      ),
    );

    await tester.tap(find.text('Item 2'));
    await tester.pumpAndSettle();

    expect(changedValue, isNull);
  });

  testWidgets('MantineSegmentedControl vertical orientation works without crash', (tester) async {
    await tester.pumpWidget(
      MantineProvider(
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Center(
            child: MantineSegmentedControl<String>(
              orientation: MantineSegmentedControlOrientation.vertical,
              data: const [
                MantineSegmentedControlItem(label: Text('Item 1'), value: '1'),
                MantineSegmentedControlItem(label: Text('Item 2'), value: '2'),
              ],
            ),
          ),
        ),
      ),
    );

    expect(find.text('Item 1'), findsOneWidget);
    expect(find.text('Item 2'), findsOneWidget);
  });
}
