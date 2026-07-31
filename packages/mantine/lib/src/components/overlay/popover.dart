import 'package:flutter/widgets.dart';
import '../../foundation/size.dart';
import '../../theme/context_extensions.dart';

enum MantinePopoverPosition {
  bottom,
  bottomStart,
  bottomEnd,
  top,
  topStart,
  topEnd,
  left,
  leftStart,
  leftEnd,
  right,
  rightStart,
  rightEnd,
}

class MantinePopover extends StatefulWidget {
  const MantinePopover({
    super.key,
    required this.opened,
    this.onClose,
    required this.target,
    required this.content,
    this.position = MantinePopoverPosition.bottom,
    this.offset = 8.0,
    this.withArrow = false,
    this.radius,
    this.shadow = MantineSize.sm,
    this.size = MantineSize.md,
    this.arrowSize = 7.0,
    this.arrowOffset = 10.0,
    this.arrowRadius = 0.0,
    this.dropdownPadding,
    this.barrierDismissible = true,
    this.backgroundColor,
    this.textColor,
  });

  final bool opened;
  final VoidCallback? onClose;
  final Widget target;
  final Widget content;
  final MantinePopoverPosition position;
  final double offset;
  final bool withArrow;
  final MantineSize? radius;
  final MantineSize shadow;
  final MantineSize size;
  final double arrowSize;
  final double arrowOffset;
  final double arrowRadius;
  final EdgeInsetsGeometry? dropdownPadding;
  final bool barrierDismissible;
  final Color? backgroundColor;
  final Color? textColor;

  @override
  State<MantinePopover> createState() => _MantinePopoverState();
}

class _MantinePopoverState extends State<MantinePopover> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    if (widget.opened) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _showPopover();
      });
    }
  }

  @override
  void didUpdateWidget(MantinePopover oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.opened != oldWidget.opened) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        if (widget.opened) {
          _showPopover();
        } else {
          _hidePopover();
        }
      });
    } else if (widget.opened) {
      _overlayEntry?.markNeedsBuild();
    }
  }

  @override
  void dispose() {
    _hidePopover();
    super.dispose();
  }

  void _showPopover() {
    if (_overlayEntry != null) return;
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _hidePopover() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
      builder: (context) => Stack(
        children: [
          if (widget.barrierDismissible)
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: widget.onClose,
              child: Container(
                color: const Color(0x00000000),
                constraints: const BoxConstraints.expand(),
              ),
            ),
          _PopoverDropdown(
            layerLink: _layerLink,
            position: widget.position,
            offset: widget.offset,
            withArrow: widget.withArrow,
            radius: widget.radius,
            shadow: widget.shadow,
            size: widget.size,
            arrowSize: widget.arrowSize,
            arrowOffset: widget.arrowOffset,
            arrowRadius: widget.arrowRadius,
            dropdownPadding: widget.dropdownPadding,
            backgroundColor: widget.backgroundColor,
            textColor: widget.textColor,
            child: widget.content,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: widget.target,
    );
  }
}

class _PopoverDropdown extends StatelessWidget {
  const _PopoverDropdown({
    required this.layerLink,
    required this.position,
    required this.offset,
    required this.withArrow,
    required this.radius,
    required this.shadow,
    required this.size,
    required this.arrowSize,
    required this.arrowOffset,
    required this.arrowRadius,
    required this.dropdownPadding,
    required this.backgroundColor,
    required this.textColor,
    required this.child,
  });

  final LayerLink layerLink;
  final MantinePopoverPosition position;
  final double offset;
  final bool withArrow;
  final MantineSize? radius;
  final MantineSize shadow;
  final MantineSize size;
  final double arrowSize;
  final double arrowOffset;
  final double arrowRadius;
  final EdgeInsetsGeometry? dropdownPadding;
  final Color? backgroundColor;
  final Color? textColor;
  final Widget child;

  Alignment _getTargetAnchor() {
    return switch (position) {
      MantinePopoverPosition.bottom => Alignment.bottomCenter,
      MantinePopoverPosition.bottomStart => Alignment.bottomLeft,
      MantinePopoverPosition.bottomEnd => Alignment.bottomRight,
      MantinePopoverPosition.top => Alignment.topCenter,
      MantinePopoverPosition.topStart => Alignment.topLeft,
      MantinePopoverPosition.topEnd => Alignment.topRight,
      MantinePopoverPosition.left => Alignment.centerLeft,
      MantinePopoverPosition.leftStart => Alignment.topLeft,
      MantinePopoverPosition.leftEnd => Alignment.bottomLeft,
      MantinePopoverPosition.right => Alignment.centerRight,
      MantinePopoverPosition.rightStart => Alignment.topRight,
      MantinePopoverPosition.rightEnd => Alignment.bottomRight,
    };
  }

  Alignment _getFollowerAnchor() {
    return switch (position) {
      MantinePopoverPosition.bottom => Alignment.topCenter,
      MantinePopoverPosition.bottomStart => Alignment.topLeft,
      MantinePopoverPosition.bottomEnd => Alignment.topRight,
      MantinePopoverPosition.top => Alignment.bottomCenter,
      MantinePopoverPosition.topStart => Alignment.bottomLeft,
      MantinePopoverPosition.topEnd => Alignment.bottomRight,
      MantinePopoverPosition.left => Alignment.centerRight,
      MantinePopoverPosition.leftStart => Alignment.topRight,
      MantinePopoverPosition.leftEnd => Alignment.bottomRight,
      MantinePopoverPosition.right => Alignment.centerLeft,
      MantinePopoverPosition.rightStart => Alignment.topLeft,
      MantinePopoverPosition.rightEnd => Alignment.bottomLeft,
    };
  }

  Offset _getOffset() {
    return switch (position) {
      MantinePopoverPosition.bottom ||
      MantinePopoverPosition.bottomStart ||
      MantinePopoverPosition.bottomEnd =>
        Offset(0, offset),
      MantinePopoverPosition.top ||
      MantinePopoverPosition.topStart ||
      MantinePopoverPosition.topEnd =>
        Offset(0, -offset),
      MantinePopoverPosition.left ||
      MantinePopoverPosition.leftStart ||
      MantinePopoverPosition.leftEnd =>
        Offset(-offset, 0),
      MantinePopoverPosition.right ||
      MantinePopoverPosition.rightStart ||
      MantinePopoverPosition.rightEnd =>
        Offset(offset, 0),
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.mantineTheme;
    final resolvedRadius = theme.radius.resolve(radius ?? theme.defaultRadius);
    final effectiveBackgroundColor = backgroundColor ?? context.mantineSurface;
    final effectiveTextColor = textColor ?? context.mantineBodyText;
    final shadowValue = theme.shadows.resolve(shadow);
    final padding = dropdownPadding ?? EdgeInsets.all(theme.spacing.resolve(size));

    Widget dropdown = Container(
      decoration: BoxDecoration(
        color: effectiveBackgroundColor,
        borderRadius: BorderRadius.circular(resolvedRadius),
        boxShadow: shadowValue,
        border: Border.all(
          color: context.isDarkMode
              ? const Color(0xFF373A40)
              : const Color(0xFFE9ECEF),
          width: 1,
        ),
      ),
      padding: padding,
      child: DefaultTextStyle(
        style: TextStyle(
          color: effectiveTextColor,
          fontSize: 14,
          fontFamily: theme.typography.fontFamily,
        ),
        child: child,
      ),
    );

    if (withArrow) {
      dropdown = Stack(
        clipBehavior: Clip.none,
        children: [
          dropdown,
          Positioned(
            left: _getArrowLeft(position),
            top: _getArrowTop(position),
            right: _getArrowRight(position),
            bottom: _getArrowBottom(position),
            child: _PopoverArrow(
              position: position,
              size: arrowSize,
              color: effectiveBackgroundColor,
              borderColor: context.isDarkMode
                  ? const Color(0xFF373A40)
                  : const Color(0xFFE9ECEF),
              radius: arrowRadius,
            ),
          ),
        ],
      );
    }

    return CompositedTransformFollower(
      link: layerLink,
      showWhenUnlinked: false,
      targetAnchor: _getTargetAnchor(),
      followerAnchor: _getFollowerAnchor(),
      offset: _getOffset(),
      child: dropdown,
    );
  }

  double? _getArrowLeft(MantinePopoverPosition position) {
    return switch (position) {
      MantinePopoverPosition.bottom || MantinePopoverPosition.top => 0,
      MantinePopoverPosition.bottomStart ||
      MantinePopoverPosition.topStart =>
        arrowOffset,
      MantinePopoverPosition.left ||
      MantinePopoverPosition.leftStart ||
      MantinePopoverPosition.leftEnd =>
        null,
      MantinePopoverPosition.right ||
      MantinePopoverPosition.rightStart ||
      MantinePopoverPosition.rightEnd =>
        -arrowSize,
      _ => null,
    };
  }

  double? _getArrowRight(MantinePopoverPosition position) {
    return switch (position) {
      MantinePopoverPosition.bottom || MantinePopoverPosition.top => 0,
      MantinePopoverPosition.bottomEnd ||
      MantinePopoverPosition.topEnd =>
        arrowOffset,
      MantinePopoverPosition.left ||
      MantinePopoverPosition.leftStart ||
      MantinePopoverPosition.leftEnd =>
        -arrowSize,
      _ => null,
    };
  }

  double? _getArrowTop(MantinePopoverPosition position) {
    return switch (position) {
      MantinePopoverPosition.bottom ||
      MantinePopoverPosition.bottomStart ||
      MantinePopoverPosition.bottomEnd =>
        -arrowSize,
      MantinePopoverPosition.left || MantinePopoverPosition.right => 0,
      MantinePopoverPosition.leftStart ||
      MantinePopoverPosition.rightStart =>
        arrowOffset,
      _ => null,
    };
  }

  double? _getArrowBottom(MantinePopoverPosition position) {
    return switch (position) {
      MantinePopoverPosition.top ||
      MantinePopoverPosition.topStart ||
      MantinePopoverPosition.topEnd =>
        -arrowSize,
      MantinePopoverPosition.left || MantinePopoverPosition.right => 0,
      MantinePopoverPosition.leftEnd ||
      MantinePopoverPosition.rightEnd =>
        arrowOffset,
      _ => null,
    };
  }
}

class _PopoverArrow extends StatelessWidget {
  const _PopoverArrow({
    required this.position,
    required this.size,
    required this.color,
    required this.borderColor,
    required this.radius,
  });

  final MantinePopoverPosition position;
  final double size;
  final Color color;
  final Color borderColor;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final isHorizontal = position == MantinePopoverPosition.bottom ||
        position == MantinePopoverPosition.top;
    final isVertical = position == MantinePopoverPosition.left ||
        position == MantinePopoverPosition.right;

    Widget arrow = CustomPaint(
      size: Size(size * 2, size),
      painter: _ArrowPainter(
        position: position,
        color: color,
        borderColor: borderColor,
        radius: radius,
      ),
    );

    if (isHorizontal) {
      return Center(
        child: SizedBox(
          width: size * 2,
          height: size,
          child: arrow,
        ),
      );
    }

    if (isVertical) {
      return Center(
        child: SizedBox(
          width: size,
          height: size * 2,
          child: RotatedBox(
            quarterTurns: position == MantinePopoverPosition.left ? 1 : 3,
            child: arrow,
          ),
        ),
      );
    }

    if (position == MantinePopoverPosition.bottomStart ||
        position == MantinePopoverPosition.bottomEnd ||
        position == MantinePopoverPosition.topStart ||
        position == MantinePopoverPosition.topEnd) {
      return arrow;
    }

    if (position == MantinePopoverPosition.leftStart ||
        position == MantinePopoverPosition.leftEnd ||
        position == MantinePopoverPosition.rightStart ||
        position == MantinePopoverPosition.rightEnd) {
      return RotatedBox(
        quarterTurns: (position == MantinePopoverPosition.leftStart ||
                position == MantinePopoverPosition.leftEnd)
            ? 1
            : 3,
        child: arrow,
      );
    }

    return arrow;
  }
}

class _ArrowPainter extends CustomPainter {
  const _ArrowPainter({
    required this.position,
    required this.color,
    required this.borderColor,
    required this.radius,
  });

  final MantinePopoverPosition position;
  final Color color;
  final Color borderColor;
  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final path = Path();

    final isTopPointing = position == MantinePopoverPosition.bottom ||
        position == MantinePopoverPosition.bottomStart ||
        position == MantinePopoverPosition.bottomEnd ||
        position == MantinePopoverPosition.leftStart ||
        position == MantinePopoverPosition.leftEnd ||
        position == MantinePopoverPosition.left ||
        position == MantinePopoverPosition.rightStart ||
        position == MantinePopoverPosition.rightEnd ||
        position == MantinePopoverPosition.right;

    if (isTopPointing) {
      path.moveTo(0, size.height);
      if (radius > 0) {
        path.lineTo(size.width / 2 - radius, radius);
        path.quadraticBezierTo(size.width / 2, 0, size.width / 2 + radius, radius);
      } else {
        path.lineTo(size.width / 2, 0);
      }
      path.lineTo(size.width, size.height);
    } else {
      path.moveTo(0, 0);
      if (radius > 0) {
        path.lineTo(size.width / 2 - radius, size.height - radius);
        path.quadraticBezierTo(
            size.width / 2, size.height, size.width / 2 + radius, size.height - radius);
      } else {
        path.lineTo(size.width / 2, size.height);
      }
      path.lineTo(size.width, 0);
    }

    canvas.drawPath(path, paint);
    canvas.drawPath(path, borderPaint);

    final hideBasePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    if (isTopPointing) {
      canvas.drawLine(
          Offset(0.5, size.height), Offset(size.width - 0.5, size.height), hideBasePaint);
    } else {
      canvas.drawLine(Offset(0.5, 0), Offset(size.width - 0.5, 0), hideBasePaint);
    }
  }

  @override
  bool shouldRepaint(_ArrowPainter old) =>
      old.color != color || old.borderColor != borderColor || old.radius != radius;
}
