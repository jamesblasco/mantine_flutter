import 'package:flutter_test/flutter_test.dart';
import 'package:mantine/mantine.dart';

void main() {
  group('MantineInterval', () {
    test('should execute callback periodically', () async {
      int count = 0;
      final interval = MantineInterval(const Duration(milliseconds: 100), () {
        count++;
      });

      expect(interval.active, isFalse);
      interval.start();
      expect(interval.active, isTrue);

      await Future.delayed(const Duration(milliseconds: 150));
      expect(count, equals(1));

      await Future.delayed(const Duration(milliseconds: 100));
      expect(count, equals(2));

      interval.stop();
      expect(interval.active, isFalse);

      await Future.delayed(const Duration(milliseconds: 100));
      expect(count, equals(2));

      interval.dispose();
    });

    test('toggle should start and stop interval', () {
      final interval = MantineInterval(const Duration(milliseconds: 100), () {});

      expect(interval.active, isFalse);
      interval.toggle();
      expect(interval.active, isTrue);
      interval.toggle();
      expect(interval.active, isFalse);

      interval.dispose();
    });

    test('start should not create multiple timers', () async {
      int count = 0;
      final interval = MantineInterval(const Duration(milliseconds: 100), () {
        count++;
      });

      interval.start();
      interval.start();
      expect(interval.active, isTrue);

      await Future.delayed(const Duration(milliseconds: 150));
      expect(count, equals(1));

      interval.dispose();
    });
  });
}
