import 'package:flutter/widgets.dart';
import '../../foundation/size.dart';
import '../../theme/context_extensions.dart';
import '../text/text.dart';

class MantineBreadcrumbs extends StatelessWidget {
  const MantineBreadcrumbs({
    super.key,
    required this.children,
    this.separator,
    this.size = MantineSize.md,
  });

  final List<Widget> children;
  final Widget? separator;
  final MantineSize size;

  @override
  Widget build(BuildContext context) {
    if (children.isEmpty) return const SizedBox.shrink();

    final theme = context.mantineTheme;
    final gap = theme.spacing.resolve(size);

    final resolvedSeparator = separator ??
        MantineText(
          '/',
          size: size,
          color: context.mantineDimmedText,
        );

    final items = <Widget>[];

    for (var i = 0; i < children.length; i++) {
      items.add(children[i]);

      if (i < children.length - 1) {
        items.add(
          Padding(
            padding: EdgeInsets.symmetric(horizontal: gap),
            child: resolvedSeparator,
          ),
        );
      }
    }

    return DefaultTextStyle(
      style: theme.typography.resolveSize(size).copyWith(
            color: context.mantineBodyText,
            fontFamily: theme.typography.fontFamily,
          ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: items,
      ),
    );
  }
}
