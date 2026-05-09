import 'package:flutter_test/flutter_test.dart';
import 'package:mantine/mantine.dart';

void main() {
  test('MantineThrottled throttles updates', () async {
    final throttled = MantineThrottled<int>(0, duration: const Duration(milliseconds: 100));
    int callCount = 0;
    throttled.addListener(() {
      callCount++;
    });

    expect(throttled.value, 0);
    expect(callCount, 0);

    // First update (leading edge)
    throttled.value = 1;
    expect(throttled.value, 1);
    expect(callCount, 1);

    // Immediate second update (should be ignored)
    throttled.value = 2;
    expect(throttled.value, 1);
    expect(callCount, 1);

    // Wait for duration
    await Future.delayed(const Duration(milliseconds: 110));

    // Update after duration
    throttled.value = 3;
    expect(throttled.value, 3);
    expect(callCount, 2);
  });
}
