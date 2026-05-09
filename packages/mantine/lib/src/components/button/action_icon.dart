import 'package:flutter/widgets.dart';
import '../../foundation/size.dart';
import '../../theme/context_extensions.dart';
import '../feedback/loader.dart';
import 'button.dart';

class MantineActionIcon extends StatefulWidget {
  const MantineActionIcon({
    super.key,
    required this.onPressed,
    required this.child,
    this.variant = MantineButtonVariant.filled,
    this.color,
    this.size = MantineSize.sm,
    this.radius,
    this.loading = false,
    this.gradient,
    this.disabled = false,
    this.iconSize,
  });

  final VoidCallback? onPressed;
  final Widget child;
  final MantineButtonVariant variant;
  final String? color;
  final MantineSize size;
  final MantineSize? radius;
  final bool loading;
  final (Color, Color)? gradient;
  final bool disabled;
  final double? iconSize;

  @override
  State<MantineActionIcon> createState() => _MantineActionIconState();
}

class _MantineActionIconState extends State<MantineActionIcon> {
  bool _hovered = false;
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final isDisabled =
        widget.disabled || widget.onPressed == null || widget.loading;
    final theme = context.mantineTheme;
    final isDark = context.isDarkMode;
    final colorScale =
        theme.colors.resolve(widget.color ?? theme.primaryColor);
    final shade = theme.primaryShade;

    final boxSize = switch (widget.size) {
      MantineSize.xs => 28.0,
      MantineSize.sm => 36.0,
      MantineSize.md => 42.0,
      MantineSize.lg => 50.0,
      MantineSize.xl => 60.0,
    };

    final iconSize = widget.iconSize ??
        switch (widget.size) {
          MantineSize.xs => 14.0,
          MantineSize.sm => 18.0,
          MantineSize.md => 22.0,
          MantineSize.lg => 26.0,
          MantineSize.xl => 32.0,
        };

    final resolvedRadius = theme.radius.resolve(widget.radius ?? theme.defaultRadius);

    Color bgColor;
    Color textColor;
    Border? border;
    List<Color>? gradientColors;

    switch (widget.variant) {
      case MantineButtonVariant.filled:
        bgColor = _hovered || _pressed
            ? colorScale[(shade + 1).clamp(0, 9)]
            : colorScale[shade];
        textColor = theme.white;
      case MantineButtonVariant.outline:
        final c = colorScale[isDark ? 4 : shade];
        bgColor = _hovered
            ? (isDark
                ? colorScale[9].withValues(alpha: 0.1)
                : colorScale[0])
            : const Color(0x00000000);
        textColor = c;
        border = Border.all(color: c, width: 1);
      case MantineButtonVariant.light:
        bgColor = _hovered
            ? (isDark
                ? colorScale[9].withValues(alpha: 0.45)
                : colorScale[1])
            : (isDark ? colorScale[9].withValues(alpha: 0.35) : colorScale[0]);
        textColor = colorScale[isDark ? 3 : shade];
      case MantineButtonVariant.subtle:
        bgColor = _hovered
            ? (isDark ? colorScale[9].withValues(alpha: 0.35) : colorScale[0])
            : const Color(0x00000000);
        textColor = colorScale[isDark ? 3 : shade];
      case MantineButtonVariant.transparent:
        bgColor = const Color(0x00000000);
        textColor = colorScale[isDark ? 3 : shade];
      case MantineButtonVariant.white:
        bgColor = _hovered ? const Color(0xFFF1F3F5) : theme.white;
        textColor = colorScale[shade];
      case MantineButtonVariant.gradient:
        final g = widget.gradient ?? (colorScale[shade], colorScale[(shade - 2).clamp(0, 9)]);
        gradientColors = [g.$1, g.$2];
        bgColor = const Color(0x00000000);
        textColor = theme.white;
    }

    Widget content = widget.loading
        ? MantineLoader(sizeValue: iconSize, color: textColor)
        : IconTheme.merge(
            data: IconThemeData(
              size: iconSize,
              color: textColor,
            ),
            child: widget.child,
          );

    BoxDecoration decoration;
    if (gradientColors != null) {
      decoration = BoxDecoration(
        gradient: LinearGradient(colors: gradientColors),
        borderRadius: BorderRadius.circular(resolvedRadius),
        border: border,
      );
    } else {
      decoration = BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(resolvedRadius),
        border: border,
      );
    }

    return MouseRegion(
      cursor: isDisabled
          ? SystemMouseCursors.forbidden
          : SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() {
        _hovered = false;
        _pressed = false;
      }),
      child: GestureDetector(
        onTapDown: isDisabled
            ? null
            : (_) => setState(() => _pressed = true),
        onTapUp: isDisabled
            ? null
            : (_) => setState(() => _pressed = false),
        onTapCancel: isDisabled
            ? null
            : () => setState(() => _pressed = false),
        onTap: isDisabled ? null : widget.onPressed,
        child: Opacity(
          opacity: isDisabled ? 0.6 : 1.0,
          child: Container(
            width: boxSize,
            height: boxSize,
            decoration: decoration,
            alignment: Alignment.center,
            child: content,
          ),
        ),
      ),
    );
  }
}
