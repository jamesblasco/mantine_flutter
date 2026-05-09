import 'package:flutter/widgets.dart';
import '../../foundation/size.dart';
import '../../theme/context_extensions.dart';

class MantineText extends StatelessWidget {
  const MantineText(
    this.data, {
    super.key,
    this.size = MantineSize.md,
    this.color,
    this.weight,
    this.italic = false,
    this.underline = false,
    this.strikethrough = false,
    this.dimmed = false,
    this.truncate = false,
    this.lineClamp,
    this.gradient,
    this.textAlign,
    this.style,
  });

  final String data;
  final MantineSize size;
  final Color? color;
  final FontWeight? weight;
  final bool italic;
  final bool underline;
  final bool strikethrough;
  final bool dimmed;
  final bool truncate;
  final int? lineClamp;
  final (Color, Color)? gradient;
  final TextAlign? textAlign;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final theme = context.mantineTheme;
    final baseStyle = theme.typography.resolveSize(size);

    final resolvedColor = dimmed
        ? context.mantineDimmedText
        : (color ?? context.mantineBodyText);

    final computedStyle = (style ?? baseStyle).copyWith(
      color: gradient == null ? resolvedColor : null,
      fontWeight: weight,
      fontStyle: italic ? FontStyle.italic : null,
      decoration: _resolveDecoration(),
      fontFamily: theme.typography.fontFamily,
    );

    final maxLines = lineClamp ?? (truncate ? 1 : null);
    final overflow =
        (lineClamp != null || truncate) ? TextOverflow.ellipsis : null;

    Widget text = Text(
      data,
      style: computedStyle,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );

    if (gradient != null) {
      text = ShaderMask(
        blendMode: BlendMode.srcIn,
        shaderCallback: (bounds) => LinearGradient(
          colors: [gradient!.$1, gradient!.$2],
        ).createShader(bounds),
        child: text,
      );
    }

    return text;
  }

  TextDecoration? _resolveDecoration() {
    if (underline && strikethrough) {
      return TextDecoration.combine(
          [TextDecoration.underline, TextDecoration.lineThrough]);
    }
    if (underline) return TextDecoration.underline;
    if (strikethrough) return TextDecoration.lineThrough;
    return null;
  }
}
