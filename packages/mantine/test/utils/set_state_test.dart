import 'package:flutter_test/flutter_test.dart';
import 'package:mantine/mantine.dart';

void main() {
  group('MantineSetState', () {
    test('initial value', () {
      final setState = MantineSetState<String>(['a', 'b']);
      expect(setState.value, containsAll(['a', 'b']));
      expect(setState.value.length, 2);
    });

    test('add items', () {
      final setState = MantineSetState<String>();
      int notifications = 0;
      setState.addListener(() => notifications++);

      setState.add('a');
      expect(setState.value, contains('a'));
      expect(notifications, 1);

      // Adding same item should not notify
      setState.add('a');
      expect(notifications, 1);

      setState.add('b');
      expect(setState.value, containsAll(['a', 'b']));
      expect(notifications, 2);
    });

    test('remove items', () {
      final setState = MantineSetState<String>(['a', 'b']);
      int notifications = 0;
      setState.addListener(() => notifications++);

      setState.remove('a');
      expect(setState.value, isNot(contains('a')));
      expect(setState.value, contains('b'));
      expect(notifications, 1);

      // Removing non-existent item should not notify
      setState.remove('a');
      expect(notifications, 1);

      setState.remove('b');
      expect(setState.value, isEmpty);
      expect(notifications, 2);
    });

    test('toggle items', () {
      final setState = MantineSetState<String>(['a']);
      int notifications = 0;
      setState.addListener(() => notifications++);

      setState.toggle('a');
      expect(setState.value, isNot(contains('a')));
      expect(notifications, 1);

      setState.toggle('a');
      expect(setState.value, contains('a'));
      expect(notifications, 2);

      setState.toggle('b');
      expect(setState.value, containsAll(['a', 'b']));
      expect(notifications, 3);
    });

    test('clear items', () {
      final setState = MantineSetState<String>(['a', 'b']);
      int notifications = 0;
      setState.addListener(() => notifications++);

      setState.clear();
      expect(setState.value, isEmpty);
      expect(notifications, 1);

      // Clearing empty set should not notify
      setState.clear();
      expect(notifications, 1);
    });
  });
}
