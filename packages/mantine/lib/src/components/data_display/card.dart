import 'package:flutter/widgets.dart';
import '../../foundation/size.dart';
import '../../theme/context_extensions.dart';

class MantineCard extends StatelessWidget {
  const MantineCard({
    super.key,
    required this.child,
    this.padding = MantineSize.md,
    this.paddingValue,
    this.radius,
    this.shadow = MantineSize.sm,
    this.withBorder = false,
    this.color,
  });

  final Widget child;
  final MantineSize padding;
  final double? paddingValue;
  final MantineSize? radius;
  final MantineSize shadow;
  final bool withBorder;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = context.mantineTheme;

    final resolvedPadding =
        paddingValue ?? theme.spacing.resolve(padding);
    final resolvedRadius =
        theme.radius.resolve(radius ?? theme.defaultRadius);
    final resolvedShadow = theme.shadows.resolve(shadow);
    final bgColor = color ?? context.mantineSurface;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(resolvedRadius),
        boxShadow: resolvedShadow,
        border: withBorder
            ? Border.all(color: context.mantineBorder, width: 1)
            : null,
      ),
      child: Padding(
        padding: EdgeInsets.all(resolvedPadding),
        child: child,
      ),
    );
  }
}

class MantineCardSection extends StatelessWidget {
  const MantineCardSection({
    super.key,
    required this.child,
    this.withBorder = false,
    this.inheritPadding = false,
    this.padding,
  });

  final Widget child;
  final bool withBorder;
  final bool inheritPadding;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    Widget content = child;

    if (padding != null) {
      content = Padding(padding: padding!, child: content);
    }

    if (withBorder) {
      content = DecoratedBox(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: context.mantineBorder, width: 1),
          ),
        ),
        child: content,
      );
    }

    return content;
  }
}
