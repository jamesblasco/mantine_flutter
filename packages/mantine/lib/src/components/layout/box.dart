import 'package:flutter/widgets.dart';
import '../../foundation/size.dart';
import '../../theme/context_extensions.dart';

class MantineBox extends StatelessWidget {
  const MantineBox({
    super.key,
    this.child,
    this.padding,
    this.paddingSize,
    this.margin,
    this.marginSize,
    this.width,
    this.height,
    this.minWidth,
    this.minHeight,
    this.maxWidth,
    this.maxHeight,
    this.color,
    this.radius,
    this.radiusSize,
    this.border,
    this.shadow,
    this.shadowSize,
    this.opacity,
    this.alignment,
    this.decoration,
  });

  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final MantineSize? paddingSize;
  final EdgeInsetsGeometry? margin;
  final MantineSize? marginSize;
  final double? width;
  final double? height;
  final double? minWidth;
  final double? minHeight;
  final double? maxWidth;
  final double? maxHeight;
  final Color? color;
  final double? radius;
  final MantineSize? radiusSize;
  final BoxBorder? border;
  final List<BoxShadow>? shadow;
  final MantineSize? shadowSize;
  final double? opacity;
  final AlignmentGeometry? alignment;
  final BoxDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    final theme = context.mantineTheme;

    final resolvedPadding = padding ??
        (paddingSize != null
            ? EdgeInsets.all(theme.spacing.resolve(paddingSize!))
            : null);

    final resolvedMargin = margin ??
        (marginSize != null
            ? EdgeInsets.all(theme.spacing.resolve(marginSize!))
            : null);

    final resolvedRadius = radius ??
        (radiusSize != null ? theme.radius.resolve(radiusSize!) : null);

    final resolvedShadow = shadow ??
        (shadowSize != null ? theme.shadows.resolve(shadowSize!) : null);

    final resolvedDecoration = decoration ??
        (color != null ||
                resolvedRadius != null ||
                border != null ||
                resolvedShadow != null
            ? BoxDecoration(
                color: color,
                borderRadius: resolvedRadius != null
                    ? BorderRadius.circular(resolvedRadius)
                    : null,
                border: border,
                boxShadow: resolvedShadow,
              )
            : null);

    Widget result = child ?? const SizedBox.shrink();

    if (alignment != null) {
      result = Align(alignment: alignment!, child: result);
    }

    if (resolvedPadding != null) {
      result = Padding(padding: resolvedPadding, child: result);
    }

    if (resolvedDecoration != null) {
      result = DecoratedBox(decoration: resolvedDecoration, child: result);
    }

    if (width != null ||
        height != null ||
        minWidth != null ||
        minHeight != null ||
        maxWidth != null ||
        maxHeight != null) {
      result = ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: width ?? minWidth ?? 0,
          maxWidth: width ?? maxWidth ?? double.infinity,
          minHeight: height ?? minHeight ?? 0,
          maxHeight: height ?? maxHeight ?? double.infinity,
        ),
        child: result,
      );
    }

    if (resolvedMargin != null) {
      result = Padding(padding: resolvedMargin, child: result);
    }

    if (opacity != null) {
      result = Opacity(opacity: opacity!, child: result);
    }

    return result;
  }
}
