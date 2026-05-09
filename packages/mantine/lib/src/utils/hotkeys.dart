import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class MantineHotkey {
  const MantineHotkey({
    required this.key,
    this.control = false,
    this.shift = false,
    this.alt = false,
    this.meta = false,
    required this.handler,
  });

  final LogicalKeyboardKey key;
  final bool control;
  final bool shift;
  final bool alt;
  final bool meta;
  final VoidCallback handler;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MantineHotkey &&
          runtimeType == other.runtimeType &&
          key == other.key &&
          control == other.control &&
          shift == other.shift &&
          alt == other.alt &&
          meta == other.meta &&
          handler == other.handler;

  @override
  int get hashCode =>
      key.hashCode ^
      control.hashCode ^
      shift.hashCode ^
      alt.hashCode ^
      meta.hashCode ^
      handler.hashCode;
}

class MantineHotkeysProvider extends InheritedWidget {
  const MantineHotkeysProvider({
    super.key,
    required this.hotkeys,
    required super.child,
  });

  final List<MantineHotkey> hotkeys;

  static MantineHotkeysProvider? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MantineHotkeysProvider>();
  }

  static List<MantineHotkey> of(BuildContext context) {
    final provider = maybeOf(context);
    return provider?.hotkeys ?? const [];
  }

  @override
  bool updateShouldNotify(MantineHotkeysProvider oldWidget) {
    return hotkeys != oldWidget.hotkeys;
  }
}

class MantineHotkeys extends StatefulWidget {
  const MantineHotkeys({
    super.key,
    required this.hotkeys,
    this.ignoreInputs = true,
    required this.child,
  });

  final List<MantineHotkey> hotkeys;
  final bool ignoreInputs;
  final Widget child;

  @override
  State<MantineHotkeys> createState() => _MantineHotkeysState();
}

class _MantineHotkeysState extends State<MantineHotkeys> {
  @override
  void initState() {
    super.initState();
    HardwareKeyboard.instance.addHandler(_handleKeyEvent);
  }

  @override
  void dispose() {
    HardwareKeyboard.instance.removeHandler(_handleKeyEvent);
    super.dispose();
  }

  bool _handleKeyEvent(KeyEvent event) {
    if (event is! KeyDownEvent) return false;

    if (widget.ignoreInputs) {
      final focusNode = FocusManager.instance.primaryFocus;
      if (focusNode != null && focusNode.context != null) {
        // Simple check if the focused widget is likely an input.
        // In Flutter, we can check if it's an EditableText.
        final element = focusNode.context! as Element;
        bool isInput = false;
        element.visitAncestorElements((parent) {
          if (parent.widget is EditableText) {
            isInput = true;
            return false;
          }
          return true;
        });
        if (isInput) return false;
      }
    }

    final hk = HardwareKeyboard.instance;

    for (final hotkey in widget.hotkeys) {
      if (event.logicalKey == hotkey.key) {
        final ctrlPressed = hk.isControlPressed;
        final shiftPressed = hk.isShiftPressed;
        final altPressed = hk.isAltPressed;
        final metaPressed = hk.isMetaPressed;

        if (hotkey.control == ctrlPressed &&
            hotkey.shift == shiftPressed &&
            hotkey.alt == altPressed &&
            hotkey.meta == metaPressed) {
          hotkey.handler();
          return true;
        }
      }
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return MantineHotkeysProvider(
      hotkeys: widget.hotkeys,
      child: widget.child,
    );
  }
}

/// Helper for cross-platform 'mod' key (Cmd on macOS, Ctrl elsewhere)
LogicalKeyboardKey get mantineModKey =>
    defaultTargetPlatform == TargetPlatform.macOS ||
            defaultTargetPlatform == TargetPlatform.iOS
        ? LogicalKeyboardKey.meta
        : LogicalKeyboardKey.control;
