import 'package:flutter/widgets.dart';
import '../../foundation/size.dart';
import '../../foundation/radius.dart';
import '../../theme/context_extensions.dart';

enum MantineBadgeVariant { filled, outline, light, dot, gradient }

class MantineBadge extends StatelessWidget {
  const MantineBadge({
    super.key,
    required this.child,
    this.variant = MantineBadgeVariant.filled,
    this.color,
    this.size = MantineSize.md,
    this.radius,
    this.fullWidth = false,
    this.leftSection,
    this.rightSection,
    this.circle = false,
  });

  final Widget child;
  final MantineBadgeVariant variant;
  final String? color;
  final MantineSize size;
  final MantineSize? radius;
  final bool fullWidth;
  final Widget? leftSection;
  final Widget? rightSection;
  final bool circle;

  @override
  Widget build(BuildContext context) {
    final theme = context.mantineTheme;
    final colorScale = theme.colors.resolve(color ?? theme.primaryColor);
    final isDark = context.isDarkMode;

    final height = switch (size) {
      MantineSize.xs => 16.0,
      MantineSize.sm => 18.0,
      MantineSize.md => 20.0,
      MantineSize.lg => 24.0,
      MantineSize.xl => 26.0,
    };

    final hPad = switch (size) {
      MantineSize.xs => 6.0,
      MantineSize.sm => 8.0,
      MantineSize.md => 10.0,
      MantineSize.lg => 12.0,
      MantineSize.xl => 14.0,
    };

    final fontSize = switch (size) {
      MantineSize.xs => 9.0,
      MantineSize.sm => 10.0,
      MantineSize.md => 11.0,
      MantineSize.lg => 13.0,
      MantineSize.xl => 14.0,
    };

    final resolvedRadius = circle
        ? MantineRadius.circle
        : theme.radius.resolve(radius ?? theme.defaultRadius);

    Color bgColor;
    Color textColor;
    Border? border;

    switch (variant) {
      case MantineBadgeVariant.filled:
        bgColor = colorScale[theme.primaryShade];
        textColor = theme.white;
        border = null;
      case MantineBadgeVariant.outline:
        bgColor = const Color(0x00000000);
        textColor = colorScale[isDark ? 4 : theme.primaryShade];
        border = Border.all(
            color: colorScale[isDark ? 4 : theme.primaryShade], width: 1);
      case MantineBadgeVariant.light:
        bgColor = isDark
            ? colorScale[9].withValues(alpha: 0.35)
            : colorScale[0];
        textColor = colorScale[isDark ? 3 : theme.primaryShade];
        border = null;
      case MantineBadgeVariant.dot:
        bgColor = const Color(0x00000000);
        textColor = context.mantineBodyText;
        border = Border.all(color: context.mantineBorder, width: 1);
      case MantineBadgeVariant.gradient:
        bgColor = colorScale[theme.primaryShade];
        textColor = theme.white;
        border = null;
    }

    Widget content = DefaultTextStyle.merge(
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w700,
        color: textColor,
        height: 1,
        fontFamily: theme.typography.fontFamily,
        letterSpacing: 0.4,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (variant == MantineBadgeVariant.dot) ...[
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: colorScale[theme.primaryShade],
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6),
          ],
          if (leftSection != null) ...[leftSection!, const SizedBox(width: 4)],
          child,
          if (rightSection != null) ...[
            const SizedBox(width: 4),
            rightSection!
          ],
        ],
      ),
    );

    content = DecoratedBox(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(resolvedRadius),
        border: border,
      ),
      child: Padding(
        padding: circle
            ? EdgeInsets.zero
            : EdgeInsets.symmetric(horizontal: hPad),
        child: content,
      ),
    );

    content = SizedBox(
      height: height,
      width: circle ? height : (fullWidth ? double.infinity : null),
      child: Align(
        alignment: Alignment.center,
        child: content,
      ),
    );

    return content;
  }
}
