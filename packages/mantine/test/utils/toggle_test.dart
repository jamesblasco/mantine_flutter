import 'package:flutter_test/flutter_test.dart';
import 'package:mantine/mantine.dart';

void main() {
  group('MantineToggle', () {
    test('should initialize with initial value', () {
      final toggle = MantineToggle('a', 'b');
      expect(toggle.value, 'a');
    });

    test('should toggle between values', () {
      final toggle = MantineToggle('a', 'b');
      toggle.toggle();
      expect(toggle.value, 'b');
      toggle.toggle();
      expect(toggle.value, 'a');
    });

    test('should set value explicitly', () {
      final toggle = MantineToggle('a', 'b');
      toggle.set('b');
      expect(toggle.value, 'b');
      toggle.set('c'); // Even if not initial or other
      expect(toggle.value, 'c');
      toggle.toggle(); // Toggling from 'c' should go back to 'initial' because 'c' != 'initial'
      expect(toggle.value, 'a');
    });

    test('should notify listeners on change', () {
      final toggle = MantineToggle('a', 'b');
      int callCount = 0;
      toggle.addListener(() => callCount++);

      toggle.toggle();
      expect(callCount, 1);

      toggle.set('a');
      expect(callCount, 2);
    });
  });
}
