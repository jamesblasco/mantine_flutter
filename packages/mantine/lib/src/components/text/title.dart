import 'package:flutter/widgets.dart';
import '../../theme/context_extensions.dart';

enum MantineTitleOrder { h1, h2, h3, h4, h5, h6 }

class MantineTitle extends StatelessWidget {
  const MantineTitle(
    this.data, {
    super.key,
    this.order = MantineTitleOrder.h1,
    this.size,
    this.color,
    this.textAlign,
    this.style,
  });

  final String data;
  final MantineTitleOrder order;
  final MantineTitleOrder? size;
  final Color? color;
  final TextAlign? textAlign;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final theme = context.mantineTheme;
    final visualOrder = size ?? order;

    final baseStyle = switch (visualOrder) {
      MantineTitleOrder.h1 => theme.typography.h1,
      MantineTitleOrder.h2 => theme.typography.h2,
      MantineTitleOrder.h3 => theme.typography.h3,
      MantineTitleOrder.h4 => theme.typography.h4,
      MantineTitleOrder.h5 => theme.typography.h5,
      MantineTitleOrder.h6 => theme.typography.h6,
    };

    final computedStyle = (style ?? baseStyle).copyWith(
      color: color ?? context.mantineBodyText,
      fontFamily: theme.typography.fontFamily,
    );

    return Text(
      data,
      style: computedStyle,
      textAlign: textAlign,
    );
  }
}
