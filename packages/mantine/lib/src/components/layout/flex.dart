import 'package:flutter/widgets.dart';
import '../../foundation/size.dart';
import '../../theme/context_extensions.dart';

class MantineFlex extends StatelessWidget {
  const MantineFlex({
    super.key,
    required this.children,
    this.gap = MantineSize.md,
    this.gapValue,
    this.direction = Axis.horizontal,
    this.align = CrossAxisAlignment.stretch,
    this.justify = MainAxisAlignment.start,
    this.wrap = false,
  });

  final List<Widget> children;
  final MantineSize gap;
  final double? gapValue;
  final Axis direction;
  final CrossAxisAlignment align;
  final MainAxisAlignment justify;
  final bool wrap;

  @override
  Widget build(BuildContext context) {
    final spacing = gapValue ?? context.mantineTheme.spacing.resolve(gap);

    if (wrap) {
      return Wrap(
        direction: direction,
        alignment: _mapMainAxisAlignmentToWrapAlignment(justify),
        crossAxisAlignment: _mapCrossAxisAlignmentToWrapCrossAlignment(align),
        spacing: spacing,
        runSpacing: spacing,
        children: children,
      );
    }

    final items = <Widget>[];
    for (var i = 0; i < children.length; i++) {
      items.add(children[i]);
      if (i < children.length - 1) {
        items.add(
          direction == Axis.horizontal
              ? SizedBox(width: spacing)
              : SizedBox(height: spacing),
        );
      }
    }

    return Flex(
      direction: direction,
      crossAxisAlignment: align,
      mainAxisAlignment: justify,
      mainAxisSize: MainAxisSize.min,
      children: items,
    );
  }

  WrapAlignment _mapMainAxisAlignmentToWrapAlignment(
      MainAxisAlignment alignment) {
    switch (alignment) {
      case MainAxisAlignment.start:
        return WrapAlignment.start;
      case MainAxisAlignment.end:
        return WrapAlignment.end;
      case MainAxisAlignment.center:
        return WrapAlignment.center;
      case MainAxisAlignment.spaceBetween:
        return WrapAlignment.spaceBetween;
      case MainAxisAlignment.spaceAround:
        return WrapAlignment.spaceAround;
      case MainAxisAlignment.spaceEvenly:
        return WrapAlignment.spaceEvenly;
    }
  }

  WrapCrossAlignment _mapCrossAxisAlignmentToWrapCrossAlignment(
      CrossAxisAlignment alignment) {
    switch (alignment) {
      case CrossAxisAlignment.start:
        return WrapCrossAlignment.start;
      case CrossAxisAlignment.end:
        return WrapCrossAlignment.end;
      case CrossAxisAlignment.center:
        return WrapCrossAlignment.center;
      case CrossAxisAlignment.stretch:
      case CrossAxisAlignment.baseline:
        // Wrap does not support stretch or baseline, defaulting to start
        return WrapCrossAlignment.start;
    }
  }
}
