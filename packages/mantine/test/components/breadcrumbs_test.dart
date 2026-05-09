import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mantine/mantine.dart';

void main() {
  testWidgets('MantineBreadcrumbs renders children and default separator',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MantineProvider(
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: MantineBreadcrumbs(
            children: [
              MantineText('Home'),
              MantineText('Docs'),
              MantineText('Breadcrumbs'),
            ],
          ),
        ),
      ),
    );

    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Docs'), findsOneWidget);
    expect(find.text('Breadcrumbs'), findsOneWidget);
    expect(find.text('/'), findsNWidgets(2));
  });

  testWidgets('MantineBreadcrumbs renders custom separator',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MantineProvider(
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: MantineBreadcrumbs(
            separator: MantineText('>'),
            children: [
              MantineText('Home'),
              MantineText('Docs'),
            ],
          ),
        ),
      ),
    );

    expect(find.text('>'), findsOneWidget);
    expect(find.text('/'), findsNothing);
  });

  testWidgets('MantineBreadcrumbs renders nothing when children are empty',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MantineProvider(
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: MantineBreadcrumbs(
            children: [],
          ),
        ),
      ),
    );

    expect(find.byType(Row), findsNothing);
  });
}
