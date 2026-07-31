import 'package:flutter/widgets.dart';
import '../../foundation/size.dart';
import 'action_icon.dart';
import 'button.dart';

class MantineCloseButton extends StatelessWidget {
  const MantineCloseButton({
    super.key,
    this.onPressed,
    this.size = MantineSize.sm,
    this.variant = MantineButtonVariant.subtle,
    this.color,
    this.radius,
    this.iconSize,
    this.disabled = false,
  });

  final VoidCallback? onPressed;
  final MantineSize size;
  final MantineButtonVariant variant;
  final String? color;
  final MantineSize? radius;
  final double? iconSize;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return MantineActionIcon(
      onPressed: onPressed,
      size: size,
      variant: variant,
      color: color,
      radius: radius,
      iconSize: iconSize,
      disabled: disabled,
      child: const _CloseIcon(),
    );
  }
}

class _CloseIcon extends StatelessWidget {
  const _CloseIcon();

  @override
  Widget build(BuildContext context) {
    final iconTheme = IconTheme.of(context);
    final size = iconTheme.size ?? 18.0;
    return CustomPaint(
      size: Size(size, size),
      painter: _CrossPainter(color: iconTheme.color ?? const Color(0xFF000000)),
    );
  }
}

class _CrossPainter extends CustomPainter {
  const _CrossPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset.zero, Offset(size.width, size.height), paint);
    canvas.drawLine(Offset(size.width, 0), Offset(0, size.height), paint);
  }

  @override
  bool shouldRepaint(_CrossPainter old) => old.color != color;
}
