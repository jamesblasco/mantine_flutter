import 'package:flutter_test/flutter_test.dart';
import 'package:mantine/src/utils/uncontrolled.dart';

void main() {
  group('MantineUncontrolled', () {
    test('uses value when controlled', () {
      final state = MantineUncontrolled<String>(
        value: 'controlled',
        defaultValue: 'default',
        finalValue: 'final',
      );

      expect(state.currentValue, 'controlled');
    });

    test('uses defaultValue when uncontrolled', () {
      final state = MantineUncontrolled<String>(
        value: null,
        defaultValue: 'default',
        finalValue: 'final',
      );

      expect(state.currentValue, 'default');
    });

    test('uses finalValue when both value and defaultValue are null', () {
      final state = MantineUncontrolled<String>(
        value: null,
        defaultValue: null,
        finalValue: 'final',
      );

      expect(state.currentValue, 'final');
    });

    test('handleChange updates internal state and calls onChanged in uncontrolled mode', () {
      String? changedValue;
      final state = MantineUncontrolled<String>(
        value: null,
        defaultValue: 'initial',
        finalValue: 'final',
        onChanged: (v) => changedValue = v,
      );

      state.handleChange('new value');
      expect(state.currentValue, 'new value');
      expect(changedValue, 'new value');
    });

    test('handleChange only calls onChanged in controlled mode', () {
      String? changedValue;
      final state = MantineUncontrolled<String>(
        value: 'controlled',
        defaultValue: 'initial',
        finalValue: 'final',
        onChanged: (v) => changedValue = v,
      );

      state.handleChange('new value');
      expect(state.currentValue, 'controlled'); // Stays 'controlled' because it's controlled
      expect(changedValue, 'new value');
    });

    test('update allows changing controlled value', () {
      final state = MantineUncontrolled<String>(
        value: 'initial',
        finalValue: 'final',
      );

      expect(state.currentValue, 'initial');
      state.update(value: 'updated');
      expect(state.currentValue, 'updated');
    });
  });
}
