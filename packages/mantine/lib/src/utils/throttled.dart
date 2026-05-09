import 'package:flutter/foundation.dart';

/// A [ValueNotifier] that throttles updates to its value.
///
/// It emits at most once per [duration] window.
/// This implementation uses leading-edge emit: the first write goes through immediately,
/// and subsequent writes within the [duration] window are ignored.
class MantineThrottled<T> extends ValueNotifier<T> {
  MantineThrottled(super.value, {required this.duration});

  /// The duration of the throttle window.
  final Duration duration;

  DateTime? _lastEmitTime;

  @override
  set value(T newValue) {
    final now = DateTime.now();
    if (_lastEmitTime == null || now.difference(_lastEmitTime!) >= duration) {
      _lastEmitTime = now;
      super.value = newValue;
    }
  }
}
