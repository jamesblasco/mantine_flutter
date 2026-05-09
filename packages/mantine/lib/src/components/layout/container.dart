import 'package:flutter/widgets.dart';
import '../../foundation/size.dart';
import '../../theme/context_extensions.dart';

class MantineContainer extends StatelessWidget {
  const MantineContainer({
    super.key,
    required this.child,
    this.size,
    this.maxWidth,
    this.fluid = false,
    this.padding,
  });

  final Widget child;
  final MantineSize? size;
  final double? maxWidth;
  final bool fluid;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final theme = context.mantineTheme;
    final resolvedPadding = padding ??
        EdgeInsets.symmetric(horizontal: theme.spacing.md);

    Widget content = Padding(padding: resolvedPadding, child: child);

    if (fluid) {
      return Align(
        alignment: Alignment.topCenter,
        child: content,
      );
    }

    final resolvedMax = maxWidth ??
        (size != null ? theme.breakpoints.resolve(size!) : theme.breakpoints.md);

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: resolvedMax),
        child: content,
      ),
    );
  }
}
