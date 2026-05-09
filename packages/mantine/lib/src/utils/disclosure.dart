import 'package:flutter/widgets.dart';

/// MantineDisclosure is a boolean state helper with open/close/toggle semantics.
class MantineDisclosure extends ValueNotifier<bool> {
  MantineDisclosure(
    super.value, {
    this.onOpen,
    this.onClose,
  });

  /// Callback when [value] becomes true.
  final VoidCallback? onOpen;

  /// Callback when [value] becomes false.
  final VoidCallback? onClose;

  /// Sets [value] to true.
  void open() {
    value = true;
  }

  /// Sets [value] to false.
  void close() {
    value = false;
  }

  /// Toggles [value] between true and false.
  void toggle() {
    value = !value;
  }

  @override
  set value(bool newValue) {
    if (value == newValue) return;
    super.value = newValue;
    if (newValue) {
      onOpen?.call();
    } else {
      onClose?.call();
    }
  }
}
