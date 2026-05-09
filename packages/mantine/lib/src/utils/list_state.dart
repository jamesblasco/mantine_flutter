import 'package:flutter/foundation.dart';

/// An observable list with named mutation methods.
///
/// Every mutation creates a new list copy to ensure [ValueNotifier]
/// notifies its listeners.
class MantineListState<T> extends ValueNotifier<List<T>> {
  MantineListState(super.value);

  /// Appends [item] to the end of the list.
  void append(T item) {
    value = [...value, item];
  }

  /// Prepends [item] to the beginning of the list.
  void prepend(T item) {
    value = [item, ...value];
  }

  /// Inserts [item] at [index].
  void insert(int index, T item) {
    final newList = List<T>.from(value);
    newList.insert(index, item);
    value = newList;
  }

  /// Removes item at [index].
  void remove(int index) {
    final newList = List<T>.from(value);
    newList.removeAt(index);
    value = newList;
  }

  /// Reorders item from [from] index to [to] index.
  void reorder(int from, int to) {
    final newList = List<T>.from(value);
    final item = newList.removeAt(from);
    newList.insert(to, item);
    value = newList;
  }

  /// Filters the list based on [condition].
  void filter(bool Function(T) condition) {
    value = value.where(condition).toList();
  }

  /// Applies [transform] to items that satisfy [condition].
  void applyWhere(bool Function(T) condition, T Function(T) transform) {
    value = value.map((item) => condition(item) ? transform(item) : item).toList();
  }

  /// Replaces the current list with [newList].
  void setAll(List<T> newList) {
    value = List<T>.from(newList);
  }
}
