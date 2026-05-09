import 'package:flutter_test/flutter_test.dart';
import 'package:mantine/mantine.dart';

void main() {
  group('MantinePaginationState', () {
    test('initializes with correct total pages', () {
      final state = MantinePaginationState(total: 100, pageSize: 10);
      expect(state.totalPages, 10);
      expect(state.page, 1);
    });

    test('claps page to valid range', () {
      final state = MantinePaginationState(total: 100, pageSize: 10, page: 15);
      expect(state.page, 10);

      state.setPage(0);
      expect(state.page, 1);

      state.setPage(11);
      expect(state.page, 10);
    });

    test('next() and previous() methods', () {
      final state = MantinePaginationState(total: 100, pageSize: 10);
      state.next();
      expect(state.page, 2);

      state.previous();
      expect(state.page, 1);

      state.previous();
      expect(state.page, 1);

      state.setPage(10);
      state.next();
      expect(state.page, 10);
    });

    test('first() and last() methods', () {
      final state = MantinePaginationState(total: 100, pageSize: 10);
      state.last();
      expect(state.page, 10);

      state.first();
      expect(state.page, 1);
    });

    test('range computation - small total', () {
      final state = MantinePaginationState(total: 50, pageSize: 10);
      expect(state.range, [1, 2, 3, 4, 5]);
    });

    test('range computation - large total, start', () {
      final state = MantinePaginationState(total: 100, pageSize: 10, siblings: 1, boundaries: 1);
      // range should be [1, 2, 3, 4, 5, 'dots', 10]
      expect(state.range, [1, 2, 3, 4, 5, 'dots', 10]);
    });

    test('range computation - large total, middle', () {
      final state = MantinePaginationState(total: 100, pageSize: 10, page: 5, siblings: 1, boundaries: 1);
      // range should be [1, 'dots', 4, 5, 6, 'dots', 10]
      expect(state.range, [1, 'dots', 4, 5, 6, 'dots', 10]);
    });

    test('range computation - large total, end', () {
      final state = MantinePaginationState(total: 100, pageSize: 10, page: 10, siblings: 1, boundaries: 1);
      // range should be [1, 'dots', 6, 7, 8, 9, 10]
      expect(state.range, [1, 'dots', 6, 7, 8, 9, 10]);
    });

    test('notifies listeners on change', () {
      final state = MantinePaginationState(total: 100, pageSize: 10);
      int callCount = 0;
      state.addListener(() => callCount++);

      state.setPage(2);
      expect(callCount, 1);

      state.next();
      expect(callCount, 2);

      state.total = 200;
      expect(callCount, 3);
    });
  });
}
