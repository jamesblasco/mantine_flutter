import 'package:flutter/widgets.dart';

/// State with undo/redo history tracking.
class MantineStateHistory<T> extends ValueNotifier<T> {
  MantineStateHistory(
    T initialValue, {
    this.capacity,
  }) : super(initialValue) {
    _history = [initialValue];
    _pointer = 0;
  }

  /// The maximum number of states to keep in history.
  final int? capacity;

  late List<T> _history;
  late int _pointer;

  @override
  set value(T newValue) {
    set(newValue);
  }

  /// Updates the value and records it in history.
  /// Truncates any future states.
  void set(T newValue) {
    if (newValue == value) return;

    // Truncate future
    if (_pointer < _history.length - 1) {
      _history = _history.sublist(0, _pointer + 1);
    }

    _history.add(newValue);

    if (capacity != null && _history.length > capacity!) {
      _history.removeAt(0);
    } else {
      _pointer++;
    }

    super.value = newValue;
  }

  /// Reverts to the previous state if available.
  void undo() {
    if (canUndo) {
      _pointer--;
      super.value = _history[_pointer];
    }
  }

  /// Advances to the next state if available.
  void redo() {
    if (canRedo) {
      _pointer++;
      super.value = _history[_pointer];
    }
  }

  /// Whether there are states to undo.
  bool get canUndo => _pointer > 0;

  /// Whether there are states to redo.
  bool get canRedo => _pointer < _history.length - 1;

  /// List of previous states (excluding current).
  List<T> get history => List.unmodifiable(_history.sublist(0, _pointer));

  /// List of future states (excluding current).
  List<T> get future => List.unmodifiable(_history.sublist(_pointer + 1));
}
