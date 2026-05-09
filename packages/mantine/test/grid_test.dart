import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mantine/mantine.dart';

void main() {
  testWidgets('MantineGrid renders children', (WidgetTester tester) async {
    await tester.pumpWidget(
      MantineProvider(
        child: WidgetsApp(
          color: const Color(0xFF000000),
          builder: (context, _) => const MantineGrid(
            children: [
              MantineGridCol(span: 6, child: Text('Col 1')),
              MantineGridCol(span: 6, child: Text('Col 2')),
            ],
          ),
        ),
      ),
    );

    expect(find.text('Col 1'), findsOneWidget);
    expect(find.text('Col 2'), findsOneWidget);
  });
}
