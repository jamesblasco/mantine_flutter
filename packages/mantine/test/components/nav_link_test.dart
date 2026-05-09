import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mantine/mantine.dart';

void main() {
  testWidgets('MantineNavLink renders label and description', (WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget(
      const MantineNavLink(
        label: Text('Label'),
        description: Text('Description'),
      ),
    ));

    expect(find.text('Label'), findsOneWidget);
    expect(find.text('Description'), findsOneWidget);
  });

  testWidgets('MantineNavLink handles active state', (WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget(
      const MantineNavLink(
        label: Text('Active Link'),
        active: true,
      ),
    ));

    final text = tester.widget<DefaultTextStyle>(
      find.descendant(
        of: find.byType(MantineNavLink),
        matching: find.byType(DefaultTextStyle).first,
      ),
    );
    expect(text.style.fontWeight, FontWeight.w600);
  });

  testWidgets('MantineNavLink toggles children', (WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget(
      const MantineNavLink(
        label: Text('Parent'),
        children: [
          MantineNavLink(label: Text('Child')),
        ],
      ),
    ));

    // Initially child should be hidden by SizeTransition (sizeFactor 0)
    // But it's still in the tree.
    expect(find.text('Child'), findsOneWidget);

    await tester.tap(find.text('Parent'));
    await tester.pumpAndSettle();

    // After tap and animation, child should be visible.
    // SizeTransition should have sizeFactor > 0.
  });
}

Widget createTestWidget(Widget child) {
  return MantineProvider(
    child: WidgetsApp(
      color: const Color(0xFF0000FF),
      onGenerateRoute: (settings) => PageRouteBuilder(
        pageBuilder: (_, __, ___) => Center(child: child),
      ),
    ),
  );
}
