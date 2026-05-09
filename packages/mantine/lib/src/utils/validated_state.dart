import 'package:flutter/widgets.dart';

/// State with a validator function and exposed error string.
///
/// [MantineValidatedState] allows managing a value and its validation state
/// in a single object. It is useful for form inputs where you want to
/// show validation errors as the user types or after a certain event.
class MantineValidatedState<T> extends ChangeNotifier {
  MantineValidatedState(
    T initialValue,
    this.validator,
  )   : _value = initialValue,
        _error = validator(initialValue);

  /// The validator function that returns an error message or null if the value is valid.
  final String? Function(T value) validator;

  T _value;
  String? _error;

  /// Current value.
  T get value => _value;

  /// Current validation error message.
  String? get error => _error;

  /// Updates the value, runs the validator, and notifies listeners.
  void set(T newValue) {
    _value = newValue;
    _error = validator(newValue);
    notifyListeners();
  }
}
