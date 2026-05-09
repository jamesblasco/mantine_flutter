import 'package:flutter/widgets.dart';

/// Observable set with add/remove/toggle helpers.
class MantineSetState<T> extends ValueNotifier<Set<T>> {
  MantineSetState([Iterable<T>? initialValue])
      : super(Set<T>.from(initialValue ?? <T>{}));

  /// Adds an item to the set and notifies listeners.
  void add(T item) {
    if (!value.contains(item)) {
      value = {...value, item};
    }
  }

  /// Removes an item from the set and notifies listeners.
  void remove(T item) {
    if (value.contains(item)) {
      value = Set<T>.from(value)..remove(item);
    }
  }

  /// Toggles an item in the set and notifies listeners.
  void toggle(T item) {
    if (value.contains(item)) {
      remove(item);
    } else {
      add(item);
    }
  }

  /// Clears the set and notifies listeners.
  void clear() {
    if (value.isNotEmpty) {
      value = <T>{};
    }
  }
}
