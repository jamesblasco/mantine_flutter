import 'package:flutter/widgets.dart';

class MantineCounter extends ValueNotifier<int> {
  MantineCounter(
    this.initialValue, {
    this.min,
    this.max,
  }) : super(_clamp(initialValue, min, max));

  final int initialValue;
  final int? min;
  final int? max;

  void increment() {
    value = _clamp(value + 1, min, max);
  }

  void decrement() {
    value = _clamp(value - 1, min, max);
  }

  void reset() {
    value = _clamp(initialValue, min, max);
  }

  void set(int newValue) {
    value = _clamp(newValue, min, max);
  }

  static int _clamp(int value, int? min, int? max) {
    if (min != null && value < min) return min;
    if (max != null && value > max) return max;
    return value;
  }
}
