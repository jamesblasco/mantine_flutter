import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mantine/mantine.dart';

void main() {
  testWidgets('MantineFlex renders children with gaps', (tester) async {
    await tester.pumpWidget(
      MantineProvider(
        theme: const MantineThemeData(),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: MantineFlex(
            gap: MantineSize.md,
            children: [
              const SizedBox(width: 10, height: 10, key: Key('child1')),
              const SizedBox(width: 10, height: 10, key: Key('child2')),
            ],
          ),
        ),
      ),
    );

    expect(find.byKey(const Key('child1')), findsOneWidget);
    expect(find.byKey(const Key('child2')), findsOneWidget);

    final flex = tester.widget<Flex>(find.byType(Flex));
    expect(flex.direction, Axis.horizontal);

    // md spacing is 16.0
    expect(find.byType(SizedBox), findsNWidgets(3)); // 2 children + 1 spacer
    final spacer = tester.widget<SizedBox>(find.byType(SizedBox).at(1));
    expect(spacer.width, 16.0);
  });

  testWidgets('MantineFlex supports direction vertical', (tester) async {
    await tester.pumpWidget(
      MantineProvider(
        theme: const MantineThemeData(),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: MantineFlex(
            direction: Axis.vertical,
            gapValue: 20.0,
            children: [
              const SizedBox(width: 10, height: 10),
              const SizedBox(width: 10, height: 10),
            ],
          ),
        ),
      ),
    );

    final flex = tester.widget<Flex>(find.byType(Flex));
    expect(flex.direction, Axis.vertical);

    final spacer = tester.widget<SizedBox>(find.byType(SizedBox).at(1));
    expect(spacer.height, 20.0);
  });

  testWidgets('MantineFlex supports wrap', (tester) async {
    await tester.pumpWidget(
      MantineProvider(
        theme: const MantineThemeData(),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: MantineFlex(
            wrap: true,
            gap: MantineSize.sm, // 8.0
            children: [
              const SizedBox(width: 10, height: 10),
              const SizedBox(width: 10, height: 10),
            ],
          ),
        ),
      ),
    );

    expect(find.byType(Wrap), findsOneWidget);
    final wrap = tester.widget<Wrap>(find.byType(Wrap));
    expect(wrap.spacing, 8.0);
    expect(wrap.runSpacing, 8.0);
  });
}
