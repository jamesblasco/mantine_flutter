import 'package:flutter/widgets.dart';
import '../../foundation/size.dart';
import '../../theme/context_extensions.dart';
import '../button/button.dart';
import '../button/action_icon.dart';
import '../text/text.dart';

class MantineAlert extends StatelessWidget {
  const MantineAlert({
    super.key,
    required this.child,
    this.title,
    this.icon,
    this.color,
    this.variant = MantineButtonVariant.light,
    this.radius,
    this.withCloseButton = false,
    this.onClose,
    this.size = MantineSize.md,
  });

  final Widget child;
  final String? title;
  final Widget? icon;
  final String? color;
  final MantineButtonVariant variant;
  final MantineSize? radius;
  final bool withCloseButton;
  final VoidCallback? onClose;
  final MantineSize size;

  @override
  Widget build(BuildContext context) {
    final theme = context.mantineTheme;
    final isDark = context.isDarkMode;
    final colorScale = theme.colors.resolve(color ?? theme.primaryColor);
    final shade = theme.primaryShade;

    final resolvedRadius = theme.radius.resolve(radius ?? theme.defaultRadius);

    Color bgColor;
    Color textColor;
    Border? border;

    switch (variant) {
      case MantineButtonVariant.filled:
        bgColor = colorScale[shade];
        textColor = theme.white;
      case MantineButtonVariant.outline:
        final c = colorScale[isDark ? 4 : shade];
        bgColor = const Color(0x00000000);
        textColor = c;
        border = Border.all(color: c, width: 1);
      case MantineButtonVariant.light:
        bgColor = isDark
            ? colorScale[9].withValues(alpha: 0.35)
            : colorScale[0];
        textColor = colorScale[isDark ? 3 : shade];
      case MantineButtonVariant.transparent:
        bgColor = const Color(0x00000000);
        textColor = colorScale[isDark ? 3 : shade];
      default:
        // Default to light if unsupported variant is passed
        bgColor = isDark
            ? colorScale[9].withValues(alpha: 0.35)
            : colorScale[0];
        textColor = colorScale[isDark ? 3 : shade];
    }

    final padding = theme.spacing.resolve(size);

    Widget? titleWidget;
    if (title != null) {
      titleWidget = Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: MantineText(
          title!,
          size: size,
          weight: FontWeight.bold,
          color: textColor,
        ),
      );
    }

    Widget content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (titleWidget != null) titleWidget,
        DefaultTextStyle.merge(
          style: TextStyle(
            color: textColor,
            fontSize: theme.typography.resolveSize(size).fontSize,
            fontFamily: theme.typography.fontFamily,
          ),
          child: child,
        ),
      ],
    );

    return DecoratedBox(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(resolvedRadius),
        border: border,
      ),
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (icon != null)
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: IconTheme.merge(
                  data: IconThemeData(
                    color: textColor,
                    size: theme.typography.resolveSize(size).fontSize! * 1.2,
                  ),
                  child: icon!,
                ),
              ),
            Expanded(child: content),
            if (withCloseButton)
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: MantineActionIcon(
                  onPressed: onClose,
                  variant: MantineButtonVariant.transparent,
                  color: color ?? (isDark ? 'gray' : theme.primaryColor),
                  size: size,
                  child: const _CloseIcon(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _CloseIcon extends StatelessWidget {
  const _CloseIcon();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(16, 16),
      painter: _CloseIconPainter(
        color: IconTheme.of(context).color ?? const Color(0xFF000000),
      ),
    );
  }
}

class _CloseIconPainter extends CustomPainter {
  final Color color;

  _CloseIconPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(Offset(0, 0), Offset(size.width, size.height), paint);
    canvas.drawLine(Offset(size.width, 0), Offset(0, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
