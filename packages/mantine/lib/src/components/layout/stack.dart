import 'package:flutter/widgets.dart';
import '../../foundation/size.dart';
import '../../theme/context_extensions.dart';

class MantineStack extends StatelessWidget {
  const MantineStack({
    super.key,
    required this.children,
    this.spacing = MantineSize.md,
    this.spacingValue,
    this.align = CrossAxisAlignment.stretch,
  });

  final List<Widget> children;
  final MantineSize spacing;
  final double? spacingValue;
  final CrossAxisAlignment align;

  @override
  Widget build(BuildContext context) {
    final gap =
        spacingValue ?? context.mantineTheme.spacing.resolve(spacing);

    final items = <Widget>[];
    for (var i = 0; i < children.length; i++) {
      items.add(children[i]);
      if (i < children.length - 1) {
        items.add(SizedBox(height: gap));
      }
    }

    return Column(
      crossAxisAlignment: align,
      mainAxisSize: MainAxisSize.min,
      children: items,
    );
  }
}
