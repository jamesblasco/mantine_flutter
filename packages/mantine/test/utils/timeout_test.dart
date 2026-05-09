import 'package:flutter_test/flutter_test.dart';
import 'package:mantine/mantine.dart';

void main() {
  group('MantineTimeout', () {
    test('should execute callback after delay', () async {
      final timeout = MantineTimeout();
      bool executed = false;

      timeout.start(const Duration(milliseconds: 100), () {
        executed = true;
      });

      expect(timeout.pending, isTrue);
      expect(executed, isFalse);

      await Future.delayed(const Duration(milliseconds: 150));

      expect(executed, isTrue);
      expect(timeout.pending, isFalse);

      timeout.dispose();
    });

    test('should clear pending timer', () async {
      final timeout = MantineTimeout();
      bool executed = false;

      timeout.start(const Duration(milliseconds: 100), () {
        executed = true;
      });

      expect(timeout.pending, isTrue);
      timeout.clear();
      expect(timeout.pending, isFalse);

      await Future.delayed(const Duration(milliseconds: 150));

      expect(executed, isFalse);

      timeout.dispose();
    });

    test('should cancel previous timer when starting new one', () async {
      final timeout = MantineTimeout();
      int executionCount = 0;

      timeout.start(const Duration(milliseconds: 100), () {
        executionCount++;
      });

      timeout.start(const Duration(milliseconds: 100), () {
        executionCount++;
      });

      await Future.delayed(const Duration(milliseconds: 150));

      expect(executionCount, equals(1));

      timeout.dispose();
    });
  });
}
