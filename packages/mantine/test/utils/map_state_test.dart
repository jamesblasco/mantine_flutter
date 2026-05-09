import 'package:flutter_test/flutter_test.dart';
import 'package:mantine/mantine.dart';

void main() {
  group('MantineMapState', () {
    test('initializes with empty map by default', () {
      final state = MantineMapState<String, int>();
      expect(state.value, isEmpty);
    });

    test('initializes with provided map', () {
      final state = MantineMapState<String, int>({'a': 1, 'b': 2});
      expect(state.value, {'a': 1, 'b': 2});
    });

    test('set adds new item and notifies listeners', () {
      final state = MantineMapState<String, int>();
      int callCount = 0;
      state.addListener(() => callCount++);

      state.set('a', 1);
      expect(state.value, {'a': 1});
      expect(callCount, 1);
    });

    test('set updates existing item and notifies listeners', () {
      final state = MantineMapState<String, int>({'a': 1});
      int callCount = 0;
      state.addListener(() => callCount++);

      state.set('a', 2);
      expect(state.value, {'a': 2});
      expect(callCount, 1);
    });

    test('remove deletes item and notifies listeners', () {
      final state = MantineMapState<String, int>({'a': 1, 'b': 2});
      int callCount = 0;
      state.addListener(() => callCount++);

      state.remove('a');
      expect(state.value, {'b': 2});
      expect(callCount, 1);
    });

    test('merge adds multiple items and notifies listeners', () {
      final state = MantineMapState<String, int>({'a': 1});
      int callCount = 0;
      state.addListener(() => callCount++);

      state.merge({'b': 2, 'c': 3});
      expect(state.value, {'a': 1, 'b': 2, 'c': 3});
      expect(callCount, 1);
    });

    test('clear removes all items and notifies listeners', () {
      final state = MantineMapState<String, int>({'a': 1, 'b': 2});
      int callCount = 0;
      state.addListener(() => callCount++);

      state.clear();
      expect(state.value, isEmpty);
      expect(callCount, 1);
    });
  });
}
