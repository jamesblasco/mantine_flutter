import 'package:flutter_test/flutter_test.dart';
import 'package:mantine/src/utils/list_state.dart';

void main() {
  group('MantineListState', () {
    test('initial value', () {
      final state = MantineListState<int>([1, 2, 3]);
      expect(state.value, [1, 2, 3]);
    });

    test('append', () {
      final state = MantineListState<int>([1, 2]);
      int callCount = 0;
      state.addListener(() => callCount++);

      state.append(3);
      expect(state.value, [1, 2, 3]);
      expect(callCount, 1);
    });

    test('prepend', () {
      final state = MantineListState<int>([1, 2]);
      int callCount = 0;
      state.addListener(() => callCount++);

      state.prepend(0);
      expect(state.value, [0, 1, 2]);
      expect(callCount, 1);
    });

    test('insert', () {
      final state = MantineListState<int>([1, 3]);
      int callCount = 0;
      state.addListener(() => callCount++);

      state.insert(1, 2);
      expect(state.value, [1, 2, 3]);
      expect(callCount, 1);
    });

    test('remove', () {
      final state = MantineListState<int>([1, 2, 3]);
      int callCount = 0;
      state.addListener(() => callCount++);

      state.remove(1);
      expect(state.value, [1, 3]);
      expect(callCount, 1);
    });

    test('reorder', () {
      final state = MantineListState<int>([1, 2, 3]);
      int callCount = 0;
      state.addListener(() => callCount++);

      state.reorder(0, 2); // [2, 3, 1]
      expect(state.value, [2, 3, 1]);
      expect(callCount, 1);
    });

    test('filter', () {
      final state = MantineListState<int>([1, 2, 3, 4]);
      int callCount = 0;
      state.addListener(() => callCount++);

      state.filter((x) => x % 2 == 0);
      expect(state.value, [2, 4]);
      expect(callCount, 1);
    });

    test('applyWhere', () {
      final state = MantineListState<int>([1, 2, 3, 4]);
      int callCount = 0;
      state.addListener(() => callCount++);

      state.applyWhere((x) => x % 2 == 0, (x) => x * 10);
      expect(state.value, [1, 20, 3, 40]);
      expect(callCount, 1);
    });

    test('setAll', () {
      final state = MantineListState<int>([1, 2]);
      int callCount = 0;
      state.addListener(() => callCount++);

      state.setAll([4, 5, 6]);
      expect(state.value, [4, 5, 6]);
      expect(callCount, 1);
    });

    test('each mutation creates a new list instance', () {
      final initialList = [1, 2, 3];
      final state = MantineListState<int>(initialList);

      state.append(4);
      expect(state.value, isNot(same(initialList)));

      final secondList = state.value;
      state.prepend(0);
      expect(state.value, isNot(same(secondList)));
    });
   group('MantineListState corner cases', () {
      test('reorder to end', () {
        final state = MantineListState<int>([1, 2, 3]);
        state.reorder(0, 2);
        expect(state.value, [2, 3, 1]);
      });

      test('reorder to start', () {
        final state = MantineListState<int>([1, 2, 3]);
        state.reorder(2, 0);
        expect(state.value, [3, 1, 2]);
      });
    });
  });
}
