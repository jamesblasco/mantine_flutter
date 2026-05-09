import 'dart:async';
import 'package:flutter/widgets.dart';

/// MantineInterval is a wrapper for [Timer.periodic] with start, stop, and toggle controls.
///
/// You must call [dispose] when the interval is no longer needed to cancel the timer.
class MantineInterval extends ChangeNotifier {
  MantineInterval(this.duration, this.callback);

  /// The duration between each callback.
  final Duration duration;

  /// The function to call periodically.
  final void Function() callback;

  Timer? _timer;

  /// Returns true if the interval is currently active.
  bool get active => _timer != null;

  /// Starts the interval. If it is already active, this does nothing.
  void start() {
    if (_timer == null) {
      _timer = Timer.periodic(duration, (timer) {
        callback();
      });
      notifyListeners();
    }
  }

  /// Stops the interval.
  void stop() {
    if (_timer != null) {
      _timer?.cancel();
      _timer = null;
      notifyListeners();
    }
  }

  /// Toggles the interval.
  void toggle() {
    if (active) {
      stop();
    } else {
      start();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _timer = null;
    super.dispose();
  }
}
