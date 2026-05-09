import 'package:flutter_test/flutter_test.dart';
import 'package:mantine/mantine.dart';

void main() {
  group('MantineValidatedState', () {
    test('initializes with value and error', () {
      final state = MantineValidatedState<String>(
        'initial',
        (value) => value.isEmpty ? 'Empty' : null,
      );

      expect(state.value, 'initial');
      expect(state.error, isNull);
    });

    test('initializes with error if initial value is invalid', () {
      final state = MantineValidatedState<String>(
        '',
        (value) => value.isEmpty ? 'Empty' : null,
      );

      expect(state.value, '');
      expect(state.error, 'Empty');
    });

    test('updates value and error when set is called', () {
      final state = MantineValidatedState<String>(
        'initial',
        (value) => value.length < 3 ? 'Too short' : null,
      );

      int notifyCount = 0;
      state.addListener(() => notifyCount++);

      state.set('hi');
      expect(state.value, 'hi');
      expect(state.error, 'Too short');
      expect(notifyCount, 1);

      state.set('hello');
      expect(state.value, 'hello');
      expect(state.error, isNull);
      expect(notifyCount, 2);
    });
  });
}
