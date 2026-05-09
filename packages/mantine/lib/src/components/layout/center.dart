import 'package:flutter/widgets.dart';
import 'box.dart';

/// Centers content vertically and horizontally.
class MantineCenter extends StatelessWidget {
  const MantineCenter({
    super.key,
    required this.child,
    this.inline = false,
  });

  final Widget child;

  /// If true, Center will behave as an inline-flex container and will not take up all available width
  final bool inline;

  @override
  Widget build(BuildContext context) {
    final Widget content = inline
        ? FittedBox(fit: BoxFit.scaleDown, child: child)
        : Center(child: child);

    return MantineBox(
      child: content,
    );
  }
}
