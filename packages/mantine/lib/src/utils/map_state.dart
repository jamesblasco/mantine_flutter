import 'package:flutter/widgets.dart';

/// Observable map with set/remove/merge helpers.
class MantineMapState<K, V> extends ValueNotifier<Map<K, V>> {
  MantineMapState([Map<K, V>? initialValue])
      : super(initialValue != null ? Map<K, V>.from(initialValue) : <K, V>{});

  /// Sets value for the given key.
  void set(K key, V value) {
    final next = Map<K, V>.from(this.value);
    next[key] = value;
    this.value = next;
  }

  /// Removes the key-value pair from the map.
  void remove(K key) {
    final next = Map<K, V>.from(this.value);
    next.remove(key);
    this.value = next;
  }

  /// Merges the given map into the current map.
  void merge(Map<K, V> values) {
    final next = Map<K, V>.from(this.value);
    next.addAll(values);
    this.value = next;
  }

  /// Clears all items from the map.
  void clear() {
    value = <K, V>{};
  }
}
