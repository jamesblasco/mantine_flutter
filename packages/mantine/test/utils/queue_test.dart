import 'package:flutter_test/flutter_test.dart';
import 'package:mantine/mantine.dart';

void main() {
  group('MantineQueue', () {
    test('initializes with empty state and queue', () {
      final q = MantineQueue<int>(limit: 2);
      expect(q.state, isEmpty);
      expect(q.queue, isEmpty);
    });

    test('initializes with initial values and respects limit', () {
      final q = MantineQueue<int>(limit: 2, initialValues: [1, 2, 3]);
      expect(q.state, [1, 2]);
      expect(q.queue, [3]);
    });

    test('add() adds to state if under limit', () {
      final q = MantineQueue<int>(limit: 2);
      q.add(1);
      expect(q.state, [1]);
      expect(q.queue, isEmpty);
    });

    test('add() adds to queue if limit reached', () {
      final q = MantineQueue<int>(limit: 2);
      q.add(1);
      q.add(2);
      q.add(3);
      expect(q.state, [1, 2]);
      expect(q.queue, [3]);
    });

    test('shift() removes from state and moves from queue', () {
      final q = MantineQueue<int>(limit: 2, initialValues: [1, 2, 3]);
      final removed = q.shift();
      expect(removed, 1);
      expect(q.state, [2, 3]);
      expect(q.queue, isEmpty);
    });

    test('shift() returns null if empty', () {
      final q = MantineQueue<int>(limit: 2);
      expect(q.shift(), isNull);
    });

    test('peek returns first element or null', () {
      final q = MantineQueue<int>(limit: 2);
      expect(q.peek, isNull);
      q.add(1);
      expect(q.peek, 1);
      q.add(2);
      expect(q.peek, 1);
    });

    test('addAll() distributes items', () {
      final q = MantineQueue<int>(limit: 2);
      q.addAll([1, 2, 3, 4]);
      expect(q.state, [1, 2]);
      expect(q.queue, [3, 4]);
    });

    test('update() modifies both state and queue items', () {
      final q = MantineQueue<int>(limit: 2, initialValues: [1, 2, 3, 4]);
      q.update((items) => items.map((e) => e * 2).toList());
      expect(q.state, [2, 4]);
      expect(q.queue, [6, 8]);
    });

    test('cleanQueue() clears only the queue', () {
      final q = MantineQueue<int>(limit: 2, initialValues: [1, 2, 3, 4]);
      q.cleanQueue();
      expect(q.state, [1, 2]);
      expect(q.queue, isEmpty);
    });

    test('notifies listeners on changes', () {
      final q = MantineQueue<int>(limit: 2);
      int callCount = 0;
      q.addListener(() => callCount++);

      q.add(1); // state change -> notify
      expect(callCount, 1);

      q.add(2); // state change -> notify
      expect(callCount, 2);

      q.add(3); // queue change -> notify
      expect(callCount, 3);

      q.shift(); // state and queue change -> notify
      expect(callCount, 4);

      q.cleanQueue(); // queue already empty -> no notify
      expect(callCount, 4);

      q.add(4); // queue change -> notify
      expect(callCount, 5);

      q.cleanQueue(); // queue change -> notify
      expect(callCount, 6);
    });
  });
}
