import 'dart:async';
import 'package:flutter/widgets.dart';

class MantineTimeout extends ChangeNotifier {
  Timer? _timer;

  /// Returns true if the timer is currently running
  bool get pending => _timer != null;

  /// Cancels any in-progress timer and starts a new one
  void start(Duration delay, void Function() callback) {
    _timer?.cancel();
    _timer = Timer(delay, () {
      _timer = null;
      notifyListeners();
      callback();
    });
    notifyListeners();
  }

  /// Cancels the pending timer
  void clear() {
    if (_timer != null) {
      _timer?.cancel();
      _timer = null;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _timer = null;
    super.dispose();
  }
}
