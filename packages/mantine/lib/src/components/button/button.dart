import 'package:flutter/widgets.dart';
import '../../foundation/size.dart';
import '../../theme/context_extensions.dart';
import '../feedback/loader.dart';

enum MantineButtonVariant {
  filled,
  outline,
  light,
  subtle,
  transparent,
  white,
  gradient,
}

enum MantineLoaderPosition { left, right, center }

class MantineButton extends StatefulWidget {
  const MantineButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.variant = MantineButtonVariant.filled,
    this.color,
    this.size = MantineSize.sm,
    this.radius,
    this.fullWidth = false,
    this.leftSection,
    this.rightSection,
    this.loading = false,
    this.loaderPosition = MantineLoaderPosition.left,
    this.gradient,
  });

  final VoidCallback? onPressed;
  final Widget child;
  final MantineButtonVariant variant;
  final String? color;
  final MantineSize size;
  final MantineSize? radius;
  final bool fullWidth;
  final Widget? leftSection;
  final Widget? rightSection;
  final bool loading;
  final MantineLoaderPosition loaderPosition;
  final (Color, Color)? gradient;

  @override
  State<MantineButton> createState() => _MantineButtonState();
}

class _MantineButtonState extends State<MantineButton> {
  bool _hovered = false;
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final isDisabled = widget.onPressed == null;
    final theme = context.mantineTheme;
    final isDark = context.isDarkMode;
    final colorScale =
        theme.colors.resolve(widget.color ?? theme.primaryColor);
    final shade = theme.primaryShade;

    final height = switch (widget.size) {
      MantineSize.xs => 28.0,
      MantineSize.sm => 36.0,
      MantineSize.md => 42.0,
      MantineSize.lg => 50.0,
      MantineSize.xl => 60.0,
    };
    final hPad = switch (widget.size) {
      MantineSize.xs => 14.0,
      MantineSize.sm => 18.0,
      MantineSize.md => 22.0,
      MantineSize.lg => 26.0,
      MantineSize.xl => 32.0,
    };
    final fontSize = switch (widget.size) {
      MantineSize.xs => 12.0,
      MantineSize.sm => 14.0,
      MantineSize.md => 16.0,
      MantineSize.lg => 18.0,
      MantineSize.xl => 20.0,
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

    Widget leftContent;
    if (widget.loading && widget.loaderPosition == MantineLoaderPosition.left) {
      leftContent = Padding(
          padding: const EdgeInsets.only(right: 8),
          child: MantineLoader(size: widget.size, color: textColor));
    } else if (widget.leftSection != null) {
      leftContent = Padding(
          padding: const EdgeInsets.only(right: 8), child: widget.leftSection!);
    } else {
      leftContent = const SizedBox.shrink();
    }

    Widget rightContent;
    if (widget.loading && widget.loaderPosition == MantineLoaderPosition.right) {
      rightContent = Padding(
          padding: const EdgeInsets.only(left: 8),
          child: MantineLoader(size: widget.size, color: textColor));
    } else if (widget.rightSection != null) {
      rightContent = Padding(
          padding: const EdgeInsets.only(left: 8), child: widget.rightSection!);
    } else {
      rightContent = const SizedBox.shrink();
    }

    Widget label = widget.loading &&
            widget.loaderPosition == MantineLoaderPosition.center
        ? MantineLoader(size: widget.size, color: textColor)
        : DefaultTextStyle.merge(
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
              color: textColor,
              height: 1,
              fontFamily: theme.typography.fontFamily,
            ),
            child: widget.child,
          );

    Widget content = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [leftContent, label, rightContent],
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

    Widget button = DecoratedBox(
      decoration: decoration,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: hPad),
        child: SizedBox(height: height, child: content),
      ),
    );

    if (widget.fullWidth) {
      button = SizedBox(width: double.infinity, child: button);
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
          child: button,
        ),
      ),
    );
  }
}
