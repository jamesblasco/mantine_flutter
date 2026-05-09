import 'dart:async';
import 'package:flutter/widgets.dart';

/// ValueNotifier that delays emitting until the value is stable for a given duration.
class MantineDebounced<T> extends ValueNotifier<T> {
  MantineDebounced(
    super.initialValue, {
    required this.delay,
    this.immediate = false,
  });

  /// The duration to wait before emitting the value.
  final Duration delay;

  /// If true, the first write will emit immediately before the delay.
  final bool immediate;

  Timer? _timer;

  /// Updates the value with debounce logic.
  void set(T newValue) {
    final bool isFirstCall = _timer == null;

    _timer?.cancel();

    if (immediate && isFirstCall) {
      value = newValue;
    }

    _timer = Timer(delay, () {
      value = newValue;
      _timer = null;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _timer = null;
    super.dispose();
  }
}
