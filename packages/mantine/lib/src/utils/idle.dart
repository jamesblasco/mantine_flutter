import 'dart:async';
import 'package:flutter/widgets.dart';

/// MantineIdle fires a callback after a period of no pointer or key events.
class MantineIdle extends ChangeNotifier {
  MantineIdle({required this.timeout}) {
    _startTimer();
  }

  /// Period of inactivity after which [isIdle] becomes true.
  final Duration timeout;

  Timer? _timer;
  bool _isIdle = false;

  /// Whether the user is currently idle.
  bool get isIdle => _isIdle;

  /// Resets the idle timer.
  void reset() {
    if (_isIdle) {
      _isIdle = false;
      notifyListeners();
    }
    _timer?.cancel();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer(timeout, () {
      _isIdle = true;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  /// Convenience widget that wraps a [Listener] and [KeyboardListener]
  /// to reset a [Timer] on any event.
  ///
  /// Use [MantineIdleScope.of(context)] to access the idle state in the subtree.
  static Widget wrap({
    required Duration timeout,
    required Widget child,
  }) {
    return _MantineIdleWrapper(
      timeout: timeout,
      child: child,
    );
  }
}

class _MantineIdleWrapper extends StatefulWidget {
  const _MantineIdleWrapper({
    required this.timeout,
    required this.child,
  });

  final Duration timeout;
  final Widget child;

  @override
  State<_MantineIdleWrapper> createState() => _MantineIdleWrapperState();
}

class _MantineIdleWrapperState extends State<_MantineIdleWrapper> {
  late final MantineIdle _idle;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _idle = MantineIdle(timeout: widget.timeout);
  }

  @override
  void dispose() {
    _idle.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: (_) => _idle.reset(),
      onPointerMove: (_) => _idle.reset(),
      onPointerHover: (_) => _idle.reset(),
      child: KeyboardListener(
        focusNode: _focusNode,
        autofocus: true,
        onKeyEvent: (_) => _idle.reset(),
        child: MantineIdleScope(
          idle: _idle,
          child: widget.child,
        ),
      ),
    );
  }
}

/// Provides access to [MantineIdle] in the widget tree.
class MantineIdleScope extends InheritedNotifier<MantineIdle> {
  const MantineIdleScope({
    super.key,
    required MantineIdle idle,
    required super.child,
  }) : super(notifier: idle);

  /// Returns the [MantineIdle] instance from the nearest [MantineIdleScope] ancestor.
  static MantineIdle of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<MantineIdleScope>();
    if (scope == null) {
      throw FlutterError(
        'MantineIdleScope.of() called with a context that does not contain a MantineIdleScope.',
      );
    }
    return scope.notifier!;
  }

  /// Returns the [MantineIdle] instance from the nearest [MantineIdleScope] ancestor, if any.
  static MantineIdle? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MantineIdleScope>()?.notifier;
  }
}
