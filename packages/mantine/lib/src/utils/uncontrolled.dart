import 'package:flutter/foundation.dart';

/// Controlled/uncontrolled state adapter for building dual-mode input components.
///
/// If [value] (external) is non-null: controlled mode — reads from external, calls [onChanged].
/// Otherwise: uncontrolled mode — manages internal state.
class MantineUncontrolled<T> {
  MantineUncontrolled({
    this.value,
    this.defaultValue,
    required T finalValue,
    this.onChanged,
  }) : _internalValue = value ?? defaultValue ?? finalValue;

  /// External value for controlled mode.
  T? value;

  /// Initial value for uncontrolled mode.
  final T? defaultValue;

  /// Callback when value changes.
  ValueChanged<T>? onChanged;

  T _internalValue;

  /// Current value (external if controlled, internal if uncontrolled).
  T get currentValue => value ?? _internalValue;

  /// Updates the value.
  /// In uncontrolled mode, updates internal state and calls [onChanged].
  /// In controlled mode, only calls [onChanged].
  void handleChange(T newValue) {
    if (value == null) {
      _internalValue = newValue;
    }
    onChanged?.call(newValue);
  }

  /// Updates the properties from the widget.
  /// Should be called in `didUpdateWidget`.
  void update({
    T? value,
    ValueChanged<T>? onChanged,
  }) {
    this.value = value;
    this.onChanged = onChanged;
  }
}
