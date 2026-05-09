import 'package:flutter/widgets.dart';
import '../../foundation/size.dart';
import '../../theme/context_extensions.dart';
import '../../utils/uncontrolled.dart';
import 'checkbox.dart' show MantineLabelPosition;

class MantineRadioGroup<T> extends StatefulWidget {
  const MantineRadioGroup({
    super.key,
    required this.child,
    this.value,
    this.defaultValue,
    this.onChanged,
    this.name,
    this.label,
    this.description,
    this.error,
    this.withAsterisk = false,
    this.size = MantineSize.sm,
    this.color,
  });

  final Widget child;
  final T? value;
  final T? defaultValue;
  final ValueChanged<T>? onChanged;
  final String? name;
  final String? label;
  final String? description;
  final String? error;
  final bool withAsterisk;
  final MantineSize size;
  final String? color;

  @override
  State<MantineRadioGroup<T>> createState() => _MantineRadioGroupState<T>();
}

class _MantineRadioGroupState<T> extends State<MantineRadioGroup<T>> {
  late final MantineUncontrolled<T?> _state;

  @override
  void initState() {
    super.initState();
    _state = MantineUncontrolled<T?>(
      value: widget.value,
      defaultValue: widget.defaultValue,
      finalValue: null,
      onChanged: (v) => widget.onChanged?.call(v as T),
    );
  }

  @override
  void didUpdateWidget(MantineRadioGroup<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    _state.update(
      value: widget.value,
      onChanged: (v) => widget.onChanged?.call(v as T),
    );
  }

  void _handleChanged(T newValue) {
    _state.handleChange(newValue);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.mantineTheme;
    final fontSize = switch (widget.size) {
      MantineSize.xs => 12.0,
      MantineSize.sm => 14.0,
      MantineSize.md => 16.0,
      MantineSize.lg => 18.0,
      MantineSize.xl => 20.0,
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label != null) ...[
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label!,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w500,
                  color: context.mantineBodyText,
                  fontFamily: theme.typography.fontFamily,
                ),
              ),
              if (widget.withAsterisk)
                Text(
                  ' *',
                  style: TextStyle(
                    fontSize: fontSize,
                    color: theme.colors.resolve('red')[6],
                    fontFamily: theme.typography.fontFamily,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 4),
        ],
        if (widget.description != null) ...[
          Text(
            widget.description!,
            style: TextStyle(
              fontSize: fontSize - 2,
              color: context.mantineDimmedText,
              fontFamily: theme.typography.fontFamily,
            ),
          ),
          const SizedBox(height: 4),
        ],
        _RadioGroupScope<T>(
          value: _state.currentValue,
          onChanged: _handleChanged,
          size: widget.size,
          color: widget.color,
          child: widget.child,
        ),
        if (widget.error != null) ...[
          const SizedBox(height: 4),
          Text(
            widget.error!,
            style: TextStyle(
              fontSize: fontSize - 2,
              color: theme.colors.resolve('red')[6],
              fontFamily: theme.typography.fontFamily,
            ),
          ),
        ],
      ],
    );
  }
}

class _RadioGroupScope<T> extends InheritedWidget {
  const _RadioGroupScope({
    required super.child,
    required this.value,
    required this.onChanged,
    required this.size,
    required this.color,
  });

  final T? value;
  final ValueChanged<T> onChanged;
  final MantineSize size;
  final String? color;

  static _RadioGroupScope<T>? of<T>(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_RadioGroupScope<T>>();
  }

  @override
  bool updateShouldNotify(_RadioGroupScope<T> oldWidget) {
    return oldWidget.value != value ||
        oldWidget.size != size ||
        oldWidget.color != color;
  }
}

class MantineRadio<T> extends StatefulWidget {
  const MantineRadio({
    super.key,
    required this.value,
    this.checked,
    this.onChanged,
    this.label,
    this.description,
    this.color,
    this.size,
    this.disabled = false,
    this.labelPosition = MantineLabelPosition.right,
  });

  final T value;
  final bool? checked;
  final ValueChanged<T>? onChanged;
  final String? label;
  final String? description;
  final String? color;
  final MantineSize? size;
  final bool disabled;
  final MantineLabelPosition labelPosition;

  @override
  State<MantineRadio<T>> createState() => _MantineRadioState<T>();
}

class _MantineRadioState<T> extends State<MantineRadio<T>> {
  bool _hovered = false;

  void _handleTap() {
    if (widget.disabled) return;

    final scope = _RadioGroupScope.of<T>(context);
    if (scope != null) {
      scope.onChanged(widget.value);
    } else {
      widget.onChanged?.call(widget.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final scope = _RadioGroupScope.of<T>(context);
    final theme = context.mantineTheme;

    final effectiveSize = widget.size ?? scope?.size ?? MantineSize.sm;
    final effectiveColor = widget.color ?? scope?.color ?? theme.primaryColor;
    final isChecked = widget.checked ?? (scope?.value == widget.value);

    final colorScale = theme.colors.resolve(effectiveColor);

    final px = switch (effectiveSize) {
      MantineSize.xs => 16.0,
      MantineSize.sm => 18.0,
      MantineSize.md => 20.0,
      MantineSize.lg => 22.0,
      MantineSize.xl => 24.0,
    };

    final fontSize = switch (effectiveSize) {
      MantineSize.xs => 12.0,
      MantineSize.sm => 13.0,
      MantineSize.md => 14.0,
      MantineSize.lg => 16.0,
      MantineSize.xl => 18.0,
    };

    final box = GestureDetector(
      onTap: _handleTap,
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        cursor: widget.disabled
            ? SystemMouseCursors.forbidden
            : SystemMouseCursors.click,
        child: CustomPaint(
          size: Size(px, px),
          painter: _RadioPainter(
            checked: isChecked,
            color: colorScale[theme.primaryShade],
            borderColor: (isChecked || _hovered)
                ? colorScale[theme.primaryShade]
                : context.mantineBorder,
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
      onTap: _handleTap,
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

class _RadioPainter extends CustomPainter {
  const _RadioPainter({
    required this.checked,
    required this.color,
    required this.borderColor,
    required this.disabled,
    required this.isDark,
    required this.borderWidth,
    required this.bgColor,
  });

  final bool checked;
  final Color color;
  final Color borderColor;
  final bool disabled;
  final bool isDark;
  final double borderWidth;
  final Color bgColor;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final bgPaint = Paint()
      ..color = bgColor
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius, bgPaint);

    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;
    canvas.drawCircle(center, radius - borderWidth / 2, borderPaint);

    if (checked) {
      final dotPaint = Paint()
        ..color = color
        ..style = PaintingStyle.fill;
      canvas.drawCircle(center, radius * 0.5, dotPaint);
    }
  }

  @override
  bool shouldRepaint(_RadioPainter old) =>
      old.checked != checked ||
      old.color != color ||
      old.borderColor != borderColor;
}
