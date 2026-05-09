import 'package:flutter/widgets.dart';

class MantineCollapse extends StatefulWidget {
  const MantineCollapse({
    super.key,
    required this.opened,
    required this.child,
    this.transitionDuration = const Duration(milliseconds: 200),
    this.transitionCurve = Curves.ease,
  });

  final bool opened;
  final Widget child;
  final Duration transitionDuration;
  final Curve transitionCurve;

  @override
  State<MantineCollapse> createState() => _MantineCollapseState();
}

class _MantineCollapseState extends State<MantineCollapse>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.transitionDuration,
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: widget.transitionCurve,
    );
    if (widget.opened) {
      _controller.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(MantineCollapse oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.opened != oldWidget.opened) {
      if (widget.opened) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
    if (widget.transitionDuration != oldWidget.transitionDuration) {
      _controller.duration = widget.transitionDuration;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: _animation,
      axisAlignment: -1.0,
      child: widget.child,
    );
  }
}
