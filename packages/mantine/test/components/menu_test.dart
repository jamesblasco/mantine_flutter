import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mantine/mantine.dart';

void main() {
  testWidgets('MantineMenu toggles open/close with non-interactive target', (WidgetTester tester) async {
    await tester.pumpWidget(
      MantineProvider(
        child: WidgetsApp(
          color: const Color(0xFF000000),
          onGenerateRoute: (settings) => PageRouteBuilder(
            pageBuilder: (context, anim1, anim2) => Center(
              child: MantineMenu(
                target: MantineMenuTarget(
                  child: Container(
                    key: const Key('target'),
                    width: 100,
                    height: 50,
                    color: const Color(0xFFFF0000),
                  ),
                ),
                dropdown: MantineMenuDropdown(
                  children: [
                    MantineMenuItem(
                      key: const Key('item'),
                      onPressed: () {},
                      child: const Text('Item'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );

    // Initially closed
    expect(find.text('Item'), findsNothing);

    // Open
    await tester.tap(find.byKey(const Key('target')));
    await tester.pumpAndSettle();
    expect(find.text('Item'), findsOneWidget);

    // Close on item click
    await tester.tap(find.text('Item'));
    await tester.pumpAndSettle();
    expect(find.text('Item'), findsNothing);
  });

  testWidgets('MantineMenu toggles open/close with interactive target (Button)', (WidgetTester tester) async {
    bool buttonPressed = false;
    await tester.pumpWidget(
      MantineProvider(
        child: WidgetsApp(
          color: const Color(0xFF000000),
          onGenerateRoute: (settings) => PageRouteBuilder(
            pageBuilder: (context, anim1, anim2) => Center(
              child: MantineMenu(
                target: MantineMenuTarget(
                  child: MantineButton(
                    key: const Key('target-button'),
                    onPressed: () {
                      buttonPressed = true;
                    },
                    child: const Text('Open'),
                  ),
                ),
                dropdown: MantineMenuDropdown(
                  children: [
                    MantineMenuItem(
                      onPressed: () {},
                      child: const Text('Item'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );

    // Initially closed
    expect(find.text('Item'), findsNothing);

    // Open by tapping button
    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();

    // Check if menu opened
    expect(find.text('Item'), findsOneWidget);
    // Check if button also fired its onPressed
    expect(buttonPressed, isTrue);
  });
}
