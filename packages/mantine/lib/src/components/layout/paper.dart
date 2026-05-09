import 'package:flutter/widgets.dart';
import '../../foundation/size.dart';
import '../../theme/context_extensions.dart';

class MantinePaper extends StatelessWidget {
  const MantinePaper({
    super.key,
    required this.child,
    this.shadow,
    this.radius,
    this.withBorder = false,
  });

  final Widget child;
  final MantineSize? shadow;
  final MantineSize? radius;
  final bool withBorder;

  @override
  Widget build(BuildContext context) {
    final theme = context.mantineTheme;

    final resolvedRadius =
        theme.radius.resolve(radius ?? theme.defaultRadius);
    final resolvedShadow =
        shadow != null ? theme.shadows.resolve(shadow!) : null;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.mantineSurface,
        borderRadius: BorderRadius.circular(resolvedRadius),
        boxShadow: resolvedShadow,
        border: withBorder
            ? Border.all(color: context.mantineBorder, width: 1)
            : null,
      ),
      child: child,
    );
  }
}
