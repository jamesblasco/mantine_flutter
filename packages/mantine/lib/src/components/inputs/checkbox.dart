import 'package:flutter/widgets.dart';
import '../../foundation/size.dart';
import '../../theme/context_extensions.dart';
import '../../utils/uncontrolled.dart';

enum MantineLabelPosition { left, right }

class MantineCheckbox extends StatefulWidget {
  const MantineCheckbox({
    super.key,
    this.checked,
    this.defaultChecked,
    this.onChanged,
    this.label,
    this.description,
    this.color,
    this.size = MantineSize.sm,
    this.radius,
    this.disabled = false,
    this.indeterminate = false,
    this.labelPosition = MantineLabelPosition.right,
  });

  final bool? checked;
  final bool? defaultChecked;
  final ValueChanged<bool>? onChanged;
  final String? label;
  final String? description;
  final String? color;
  final MantineSize size;
  final MantineSize? radius;
  final bool disabled;
  final bool indeterminate;
  final MantineLabelPosition labelPosition;

  @override
  State<MantineCheckbox> createState() => _MantineCheckboxState();
}

class _MantineCheckboxState extends State<MantineCheckbox> {
  late final MantineUncontrolled<bool> _state;
  bool _hovered = false;

  @override
  void initState() {
    super.initState();
    _state = MantineUncontrolled<bool>(
      value: widget.checked,
      defaultValue: widget.defaultChecked,
      finalValue: false,
      onChanged: widget.onChanged,
    );
  }

  @override
  void didUpdateWidget(MantineCheckbox oldWidget) {
    super.didUpdateWidget(oldWidget);
    _state.update(
      value: widget.checked,
      onChanged: widget.onChanged,
    );
  }

  void _toggle() {
    if (!widget.disabled) {
      _state.handleChange(!_state.currentValue);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.mantineTheme;
    final colorScale =
        theme.colors.resolve(widget.color ?? theme.primaryColor);

    final px = switch (widget.size) {
      MantineSize.xs => 16.0,
      MantineSize.sm => 18.0,
      MantineSize.md => 20.0,
      MantineSize.lg => 22.0,
      MantineSize.xl => 24.0,
    };

    final fontSize = switch (widget.size) {
      MantineSize.xs => 12.0,
      MantineSize.sm => 13.0,
      MantineSize.md => 14.0,
      MantineSize.lg => 16.0,
      MantineSize.xl => 18.0,
    };

    final resolvedRadius =
        theme.radius.resolve(widget.radius ?? MantineSize.sm);

    final box = GestureDetector(
      onTap: _toggle,
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        cursor: widget.disabled
            ? SystemMouseCursors.forbidden
            : SystemMouseCursors.click,
        child: CustomPaint(
          size: Size(px, px),
          painter: _CheckboxPainter(
            checked: _state.currentValue || widget.indeterminate,
            indeterminate: widget.indeterminate,
            color: colorScale[theme.primaryShade],
            borderColor: (_state.currentValue || widget.indeterminate || _hovered)
                ? colorScale[theme.primaryShade]
                : context.mantineBorder,
            radius: resolvedRadius,
            disabled: widget.disabled,
            isDark: context.isDarkMode,
            borderWidth: 1.5,
            bgColor: context.mantineSurface,
          ),
        ),
      ),
    );

    if (widget.label == null) return box;

    final labelWidget = GestureDetector(
      onTap: _toggle,
      child: MouseRegion(
        cursor: widget.disabled
            ? SystemMouseCursors.forbidden
            : SystemMouseCursors.click,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.label!,
              style: TextStyle(
                fontSize: fontSize,
                color: widget.disabled
                    ? context.mantineDimmedText
                    : context.mantineBodyText,
                fontFamily: theme.typography.fontFamily,
              ),
            ),
            if (widget.description != null)
              Text(
                widget.description!,
                style: TextStyle(
                  fontSize: fontSize - 2,
                  color: context.mantineDimmedText,
                  fontFamily: theme.typography.fontFamily,
                ),
              ),
          ],
        ),
      ),
    );

    const gap = SizedBox(width: 8);
    return Opacity(
      opacity: widget.disabled ? 0.6 : 1.0,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: widget.labelPosition == MantineLabelPosition.right
            ? [box, gap, labelWidget]
            : [labelWidget, gap, box],
      ),
    );
  }
}

class _CheckboxPainter extends CustomPainter {
  const _CheckboxPainter({
    required this.checked,
    required this.indeterminate,
    required this.color,
    required this.borderColor,
    required this.radius,
    required this.disabled,
    required this.isDark,
    required this.borderWidth,
    required this.bgColor,
  });

  final bool checked;
  final bool indeterminate;
  final Color color;
  final Color borderColor;
  final double radius;
  final bool disabled;
  final bool isDark;
  final double borderWidth;
  final Color bgColor;

  @override
  void paint(Canvas canvas, Size size) {
    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(radius),
    );

    final bgPaint = Paint()
      ..color = checked ? color : bgColor
      ..style = PaintingStyle.fill;
    canvas.drawRRect(rrect, bgPaint);

    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;
    canvas.drawRRect(rrect, borderPaint);

    if (!checked) return;

    final markPaint = Paint()
      ..color = const Color(0xFFFFFFFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.12
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    if (indeterminate) {
      canvas.drawLine(
        Offset(size.width * 0.2, size.height * 0.5),
        Offset(size.width * 0.8, size.height * 0.5),
        markPaint,
      );
    } else {
      final path = Path()
        ..moveTo(size.width * 0.18, size.height * 0.5)
        ..lineTo(size.width * 0.42, size.height * 0.72)
        ..lineTo(size.width * 0.82, size.height * 0.28);
      canvas.drawPath(path, markPaint);
    }
  }

  @override
  bool shouldRepaint(_CheckboxPainter old) =>
      old.checked != checked ||
      old.indeterminate != indeterminate ||
      old.color != color ||
      old.borderColor != borderColor;
}
