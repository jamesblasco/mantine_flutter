import 'package:flutter/widgets.dart';
import '../../foundation/size.dart';
import 'box.dart';

/// Centers content vertically and horizontally.
class MantineCenter extends StatelessWidget {
  const MantineCenter({
    super.key,
    required this.child,
    this.inline = false,
    this.width,
    this.height,
    this.padding,
    this.paddingSize,
    this.margin,
    this.marginSize,
    this.color,
    this.radius,
    this.radiusSize,
    this.shadow,
    this.shadowSize,
  });

  final Widget child;

  /// If true, Center will behave as an inline-flex container and will not take up all available width
  final bool inline;

  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final MantineSize? paddingSize;
  final EdgeInsetsGeometry? margin;
  final MantineSize? marginSize;
  final Color? color;
  final double? radius;
  final MantineSize? radiusSize;
  final List<BoxShadow>? shadow;
  final MantineSize? shadowSize;

  @override
  Widget build(BuildContext context) {
    final Widget content = Center(
      widthFactor: inline ? 1.0 : null,
      heightFactor: inline ? 1.0 : null,
      child: child,
    );

    return MantineBox(
      width: width,
      height: height,
      padding: padding,
      paddingSize: paddingSize,
      margin: margin,
      marginSize: marginSize,
      color: color,
      radius: radius,
      radiusSize: radiusSize,
      shadow: shadow,
      shadowSize: shadowSize,
      child: content,
    );
  }
}
