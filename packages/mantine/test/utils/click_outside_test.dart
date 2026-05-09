import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mantine/mantine.dart';

void main() {
  testWidgets('MantineClickOutside calls onClickOutside when tapping outside',
      (tester) async {
    bool clickedOutside = false;

    await tester.pumpWidget(
      MantineProvider(
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 100),
                MantineClickOutside(
                  onClickOutside: () {
                    clickedOutside = true;
                  },
                  child: Container(
                    key: const Key('inside'),
                    width: 100,
                    height: 100,
                    color: const Color(0xFF00FF00),
                  ),
                ),
                const SizedBox(height: 100),
                Container(
                  key: const Key('outside'),
                  width: 100,
                  height: 100,
                  color: const Color(0xFFFF0000),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    // Tap inside
    await tester.tap(find.byKey(const Key('inside')));
    await tester.pump();
    expect(clickedOutside, isFalse);

    // Tap outside
    await tester.tap(find.byKey(const Key('outside')));
    await tester.pump();
    expect(clickedOutside, isTrue);
  });
}
