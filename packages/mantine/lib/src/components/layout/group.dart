import 'package:flutter/widgets.dart';
import '../../foundation/size.dart';
import '../../theme/context_extensions.dart';

class MantineGroup extends StatelessWidget {
  const MantineGroup({
    super.key,
    required this.children,
    this.spacing = MantineSize.md,
    this.spacingValue,
    this.align = CrossAxisAlignment.center,
    this.justify = MainAxisAlignment.start,
    this.wrap = false,
    this.grow = false,
  });

  final List<Widget> children;
  final MantineSize spacing;
  final double? spacingValue;
  final CrossAxisAlignment align;
  final MainAxisAlignment justify;
  final bool wrap;
  final bool grow;

  @override
  Widget build(BuildContext context) {
    final gap =
        spacingValue ?? context.mantineTheme.spacing.resolve(spacing);

    if (wrap) {
      return Wrap(
        spacing: gap,
        runSpacing: gap,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: grow
            ? children.map((c) => Expanded(child: c)).toList()
            : children,
      );
    }

    final items = <Widget>[];
    for (var i = 0; i < children.length; i++) {
      final child = grow ? Expanded(child: children[i]) : children[i];
      items.add(child);
      if (i < children.length - 1) {
        items.add(SizedBox(width: gap));
      }
    }

    return Row(
      crossAxisAlignment: align,
      mainAxisAlignment: justify,
      mainAxisSize: grow ? MainAxisSize.max : MainAxisSize.min,
      children: items,
    );
  }
}
