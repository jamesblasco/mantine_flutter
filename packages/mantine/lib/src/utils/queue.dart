import 'package:flutter/widgets.dart';
import 'package:collection/collection.dart';

/// FIFO observable queue with add/shift helpers.
///
/// Limits the number of data items in the current state
/// and places the rest of them in a queue.
class MantineQueue<T> extends ValueNotifier<List<T>> {
  MantineQueue({
    List<T> initialValues = const [],
    required this.limit,
  })  : _queue = [],
        super([]) {
    _distribute(initialValues, notifyOnNoStateChange: false);
  }

  /// Maximum number of items that state can include.
  final int limit;

  List<T> _queue;

  /// Returns the items currently in the queue (overflow).
  List<T> get queue => List.unmodifiable(_queue);

  /// Returns the items currently in the state (within limit).
  List<T> get state => value;

  /// Returns the first element of the state without removing it.
  T? get peek => value.isNotEmpty ? value.first : null;

  /// Adds a single item to the state or queue.
  void add(T item) {
    if (value.length < limit) {
      value = [...value, item];
    } else {
      _queue = [..._queue, item];
      notifyListeners();
    }
  }

  /// Adds multiple items to the state or queue.
  void addAll(Iterable<T> items) {
    final allItems = [...value, ..._queue, ...items];
    _distribute(allItems);
  }

  /// Removes and returns the first element from the state.
  /// If there are items in the queue, the first item from the queue is moved to the state.
  T? shift() {
    if (value.isEmpty) return null;

    final removed = value.first;
    final newState = List<T>.from(value)..removeAt(0);

    if (_queue.isNotEmpty) {
      newState.add(_queue.first);
      _queue = List<T>.from(_queue)..removeAt(0);
    }

    value = newState;
    return removed;
  }

  /// Applies the given function to all items in state and queue.
  void update(List<T> Function(List<T>) fn) {
    final allItems = [...value, ..._queue];
    final updatedItems = fn(allItems);
    _distribute(updatedItems);
  }

  /// Removes all items from the queue.
  void cleanQueue() {
    if (_queue.isNotEmpty) {
      _queue = [];
      notifyListeners();
    }
  }

  void _distribute(List<T> items, {bool notifyOnNoStateChange = true}) {
    final List<T> newState;
    final List<T> newQueue;

    if (items.length <= limit) {
      newState = List<T>.from(items);
      newQueue = [];
    } else {
      newState = items.sublist(0, limit);
      newQueue = items.sublist(limit);
    }

    final bool stateChanged = !const ListEquality().equals(value, newState);
    final bool queueChanged = !const ListEquality().equals(_queue, newQueue);
    _queue = newQueue;

    if (stateChanged) {
      value = newState;
    } else if (queueChanged && notifyOnNoStateChange) {
      notifyListeners();
    }
  }
}
