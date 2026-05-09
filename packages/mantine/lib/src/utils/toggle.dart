import 'package:flutter/widgets.dart';

/// State that cycles between two provided values.
class MantineToggle<T> extends ValueNotifier<T> {
  MantineToggle(this.initial, this.other) : super(initial);

  /// The first value of the toggle.
  final T initial;

  /// The second value of the toggle.
  final T other;

  /// Swaps between [initial] and [other].
  void toggle() {
    value = (value == initial) ? other : initial;
  }

  /// Explicitly sets the value.
  void set(T newValue) {
    value = newValue;
  }
}
