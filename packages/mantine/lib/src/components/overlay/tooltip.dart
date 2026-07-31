import 'dart:async';
import 'package:flutter/widgets.dart';
import '../../foundation/size.dart';
import '../../theme/context_extensions.dart';
import 'popover.dart';

class MantineTooltip extends StatefulWidget {
  const MantineTooltip({
    super.key,
    required this.label,
    required this.child,
    this.opened,
    this.defaultOpened = false,
    this.onChange,
    this.position = MantinePopoverPosition.top,
    this.offset = 5.0,
    this.withArrow = false,
    this.arrowSize = 4.0,
    this.arrowOffset = 5.0,
    this.arrowRadius = 0.0,
    this.color,
    this.radius,
    this.shadow = MantineSize.sm,
    this.multiline = false,
    this.width,
    this.openDelay = 0,
    this.closeDelay = 0,
    this.disabled = false,
  });

  final Widget label;
  final Widget child;
  final bool? opened;
  final bool defaultOpened;
  final ValueChanged<bool>? onChange;
  final MantinePopoverPosition position;
  final double offset;
  final bool withArrow;
  final double arrowSize;
  final double arrowOffset;
  final double arrowRadius;
  final String? color;
  final MantineSize? radius;
  final MantineSize shadow;
  final bool multiline;
  final double? width;
  final int openDelay;
  final int closeDelay;
  final bool disabled;

  static const group = MantineTooltipGroup;

  @override
  State<MantineTooltip> createState() => _MantineTooltipState();
}

class _MantineTooltipState extends State<MantineTooltip> {
  bool _opened = false;
  Timer? _openTimer;
  Timer? _closeTimer;

  bool get _isControlled => widget.opened != null;
  bool get _isOpened => _isControlled ? widget.opened! : _opened;

  @override
  void initState() {
    super.initState();
    _opened = widget.defaultOpened;
  }

  _MantineTooltipGroupScope? _getGroupScope() {
    return context.getElementForInheritedWidgetOfExactType<_MantineTooltipGroupScope>()?.widget as _MantineTooltipGroupScope?;
  }

  void _setOpened(bool value) {
    if (_isOpened == value) return;
    if (!_isControlled) {
      setState(() {
        _opened = value;
      });
    }
    widget.onChange?.call(value);

    final group = _getGroupScope();
    group?.state.setAnyOpened(value);
  }

  void _handleMouseEnter() {
    if (widget.disabled) return;
    _closeTimer?.cancel();

    final group = _getGroupScope();
    final effectiveOpenDelay = (group?.anyOpened ?? false)
        ? 0
        : (widget.openDelay > 0 ? widget.openDelay : (group?.openDelay ?? 0));

    if (effectiveOpenDelay > 0) {
      _openTimer?.cancel();
      _openTimer = Timer(Duration(milliseconds: effectiveOpenDelay), () {
        _setOpened(true);
      });
    } else {
      _setOpened(true);
    }
  }

  void _handleMouseLeave() {
    _openTimer?.cancel();

    final group = _getGroupScope();
    final effectiveCloseDelay = widget.closeDelay > 0 ? widget.closeDelay : (group?.closeDelay ?? 0);

    if (effectiveCloseDelay > 0) {
      _closeTimer?.cancel();
      _closeTimer = Timer(Duration(milliseconds: effectiveCloseDelay), () {
        _setOpened(false);
      });
    } else {
      _setOpened(false);
    }
  }

  @override
  void dispose() {
    _openTimer?.cancel();
    _closeTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.mantineTheme;

    final backgroundColor = widget.color != null
        ? theme.colors.resolve(widget.color!)[theme.primaryShade]
        : (context.isDarkMode ? theme.colors.resolve('dark')[4] : theme.colors.resolve('gray')[9]);

    final textColor = theme.white;

    return MantinePopover(
      opened: _isOpened,
      position: widget.position,
      offset: widget.offset,
      withArrow: widget.withArrow,
      arrowSize: widget.arrowSize,
      arrowOffset: widget.arrowOffset,
      arrowRadius: widget.arrowRadius,
      radius: widget.radius,
      shadow: widget.shadow,
      barrierDismissible: false,
      dropdownPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      backgroundColor: backgroundColor,
      textColor: textColor,
      target: MouseRegion(
        onEnter: (_) => _handleMouseEnter(),
        onExit: (_) => _handleMouseLeave(),
        child: Focus(
          onFocusChange: (focused) {
            if (focused) {
              _handleMouseEnter();
            } else {
              _handleMouseLeave();
            }
          },
          child: widget.child,
        ),
      ),
      content: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: widget.width ?? (widget.multiline ? 200.0 : double.infinity),
        ),
        child: DefaultTextStyle(
          style: TextStyle(
            color: textColor,
            fontSize: 12,
            fontFamily: theme.typography.fontFamily,
          ),
          child: widget.label,
        ),
      ),
    );
  }
}

class MantineTooltipGroup extends StatefulWidget {
  const MantineTooltipGroup({
    super.key,
    required this.child,
    this.openDelay = 0,
    this.closeDelay = 0,
  });

  final Widget child;
  final int openDelay;
  final int closeDelay;

  @override
  State<MantineTooltipGroup> createState() => _MantineTooltipGroupState();
}

class _MantineTooltipGroupState extends State<MantineTooltipGroup> {
  bool _anyOpened = false;

  void setAnyOpened(bool opened) {
    if (_anyOpened != opened) {
      setState(() {
        _anyOpened = opened;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _MantineTooltipGroupScope(
      anyOpened: _anyOpened,
      openDelay: widget.openDelay,
      closeDelay: widget.closeDelay,
      state: this,
      child: widget.child,
    );
  }
}

class _MantineTooltipGroupScope extends InheritedWidget {
  const _MantineTooltipGroupScope({
    required super.child,
    required this.anyOpened,
    required this.openDelay,
    required this.closeDelay,
    required this.state,
  });

  final bool anyOpened;
  final int openDelay;
  final int closeDelay;
  final _MantineTooltipGroupState state;

  @override
  bool updateShouldNotify(_MantineTooltipGroupScope oldWidget) {
    return oldWidget.anyOpened != anyOpened ||
        oldWidget.openDelay != openDelay ||
        oldWidget.closeDelay != closeDelay;
  }
}
