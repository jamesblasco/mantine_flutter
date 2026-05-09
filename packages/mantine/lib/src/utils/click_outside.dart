import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

/// Calls [onClickOutside] when a tap is detected outside the [child] widget's bounds.
///
/// This is a Flutter implementation of Mantine's `use-click-outside` hook.
/// It works by registering a global pointer listener and checking if the
/// pointer down event occurred within the bounds of this widget.
class MantineClickOutside extends StatefulWidget {
  const MantineClickOutside({
    super.key,
    required this.child,
    required this.onClickOutside,
  });

  /// The widget to monitor for outside clicks.
  final Widget child;

  /// Called when a pointer down event occurs outside the bounds of [child].
  final VoidCallback onClickOutside;

  @override
  State<MantineClickOutside> createState() => _MantineClickOutsideState();
}

class _MantineClickOutsideState extends State<MantineClickOutside> {
  final GlobalKey _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    // Register global listener for pointer events
    WidgetsBinding.instance.addPostFrameCallback((_) {
      GestureBinding.instance.pointerRouter.addGlobalRoute(_handlePointerEvent);
    });
  }

  @override
  void dispose() {
    GestureBinding.instance.pointerRouter.removeGlobalRoute(_handlePointerEvent);
    super.dispose();
  }

  void _handlePointerEvent(PointerEvent event) {
    if (event is PointerDownEvent) {
      final RenderBox? renderBox =
          _key.currentContext?.findRenderObject() as RenderBox?;

      if (renderBox != null && renderBox.hasSize) {
        final Offset localPosition = renderBox.globalToLocal(event.position);
        if (!renderBox.size.contains(localPosition)) {
          widget.onClickOutside();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: _key,
      child: widget.child,
    );
  }
}
