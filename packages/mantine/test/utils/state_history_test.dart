import 'package:flutter_test/flutter_test.dart';
import 'package:mantine/mantine.dart';

void main() {
  group('MantineStateHistory', () {
    test('initial state', () {
      final state = MantineStateHistory<int>(0);
      expect(state.value, 0);
      expect(state.canUndo, isFalse);
      expect(state.canRedo, isFalse);
      expect(state.history, isEmpty);
      expect(state.future, isEmpty);
    });

    test('setting value updates state and history', () {
      final state = MantineStateHistory<int>(0);
      state.set(1);
      expect(state.value, 1);
      expect(state.canUndo, isTrue);
      expect(state.canRedo, isFalse);
      expect(state.history, [0]);
      expect(state.future, isEmpty);

      state.set(2);
      expect(state.value, 2);
      expect(state.history, [0, 1]);
    });

    test('undo and redo', () {
      final state = MantineStateHistory<int>(0);
      state.set(1);
      state.set(2);

      state.undo();
      expect(state.value, 1);
      expect(state.canUndo, isTrue);
      expect(state.canRedo, isTrue);
      expect(state.history, [0]);
      expect(state.future, [2]);

      state.undo();
      expect(state.value, 0);
      expect(state.canUndo, isFalse);
      expect(state.canRedo, isTrue);
      expect(state.history, isEmpty);
      expect(state.future, [1, 2]);

      state.redo();
      expect(state.value, 1);
      expect(state.canUndo, isTrue);
      expect(state.canRedo, isTrue);
      expect(state.history, [0]);
      expect(state.future, [2]);
    });

    test('setting value truncates future', () {
      final state = MantineStateHistory<int>(0);
      state.set(1);
      state.set(2);
      state.undo(); // value is 1, future is [2]

      state.set(3);
      expect(state.value, 3);
      expect(state.canRedo, isFalse);
      expect(state.history, [0, 1]);
      expect(state.future, isEmpty);
    });

    test('capacity limits history', () {
      final state = MantineStateHistory<int>(0, capacity: 2);
      state.set(1);
      state.set(2);
      // History should be [1, 2], but wait, capacity=2 means max 2 items including current?
      // Mantine hook: capacity - The maximum number of states to keep in history.
      // If capacity is 2, it should probably only keep 2 states.
      // 0 -> set(1) -> [0, 1] (size 2)
      // set(2) -> [1, 2] (size 2)

      expect(state.value, 2);
      expect(state.history, [1]);
      expect(state.canUndo, isTrue);

      state.undo();
      expect(state.value, 1);
      expect(state.canUndo, isFalse);
    });

    test('does not add same value to history', () {
      final state = MantineStateHistory<int>(0);
      state.set(0);
      expect(state.history, isEmpty);

      state.set(1);
      state.set(1);
      expect(state.history, [0]);
    });
  });
}
