import 'package:flutter/widgets.dart';
import '../../foundation/size.dart';
import '../../foundation/radius.dart';
import '../../theme/context_extensions.dart';

class MantineAvatar extends StatefulWidget {
  const MantineAvatar({
    super.key,
    this.image,
    this.initials,
    this.color,
    this.size = MantineSize.md,
    this.radius = MantineRadius.circle,
    this.onTap,
  });

  final Widget? image;
  final String? initials;
  final String? color;
  final MantineSize size;
  final dynamic radius;
  final VoidCallback? onTap;

  @override
  State<MantineAvatar> createState() => _MantineAvatarState();
}

class _MantineAvatarState extends State<MantineAvatar> {
  bool _hasError = false;

  String _extractInitials(String text) {
    if (text.isEmpty) return '';
    final words = text.trim().split(RegExp(r'\s+'));
    return words.map((w) => w.isNotEmpty ? w[0].toUpperCase() : '').join();
  }

  @override
  void didUpdateWidget(MantineAvatar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.image != oldWidget.image) {
      _hasError = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.mantineTheme;
    final isDark = context.isDarkMode;

    final double sizePx = switch (widget.size) {
      MantineSize.xs => 28.0,
      MantineSize.sm => 36.0,
      MantineSize.md => 42.0,
      MantineSize.lg => 50.0,
      MantineSize.xl => 60.0,
    };

    final double resolvedRadius = widget.radius is MantineSize
        ? theme.radius.resolve(widget.radius as MantineSize)
        : (widget.radius is double ? widget.radius as double : MantineRadius.circle);

    final String colorName = widget.color ?? theme.primaryColor;
    final colorScale = theme.colors.resolve(colorName);
    final bgColor = isDark
        ? colorScale[9].withValues(alpha: 0.35)
        : colorScale[0];
    final textColor = colorScale[isDark ? 3 : theme.primaryShade];

    Widget? imageWidget = widget.image;
    if (imageWidget != null && !_hasError) {
      if (imageWidget is Image) {
        imageWidget = Image(
          image: imageWidget.image,
          frameBuilder: imageWidget.frameBuilder,
          loadingBuilder: imageWidget.loadingBuilder,
          errorBuilder: (context, error, stackTrace) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) setState(() => _hasError = true);
            });
            return const SizedBox.shrink();
          },
          semanticLabel: imageWidget.semanticLabel,
          excludeFromSemantics: imageWidget.excludeFromSemantics,
          width: sizePx,
          height: sizePx,
          fit: BoxFit.cover,
          color: imageWidget.color,
          colorBlendMode: imageWidget.colorBlendMode,
          filterQuality: imageWidget.filterQuality,
          alignment: imageWidget.alignment,
          repeat: imageWidget.repeat,
          centerSlice: imageWidget.centerSlice,
          matchTextDirection: imageWidget.matchTextDirection,
          gaplessPlayback: imageWidget.gaplessPlayback,
          isAntiAlias: imageWidget.isAntiAlias,
        );
      }
    }

    final initialsText = _extractInitials(widget.initials ?? '');

    Widget placeholder = CustomPaint(
      size: Size(sizePx, sizePx),
      painter: _AvatarPainter(
        initials: initialsText,
        bgColor: bgColor,
        textColor: textColor,
        radius: resolvedRadius,
        fontSize: sizePx / 2.5,
      ),
    );

    Widget content = (imageWidget != null && !_hasError)
        ? Stack(
            children: [
              placeholder,
              imageWidget,
            ],
          )
        : placeholder;

    content = ClipRRect(
      borderRadius: BorderRadius.circular(resolvedRadius),
      child: SizedBox(
        width: sizePx,
        height: sizePx,
        child: content,
      ),
    );

    if (widget.onTap != null) {
      content = GestureDetector(
        onTap: widget.onTap,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: content,
        ),
      );
    }

    return content;
  }
}

class _AvatarPainter extends CustomPainter {
  final String initials;
  final Color bgColor;
  final Color textColor;
  final double radius;
  final double fontSize;

  _AvatarPainter({
    required this.initials,
    required this.bgColor,
    required this.textColor,
    required this.radius,
    required this.fontSize,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = bgColor;
    final rect = Offset.zero & size;

    if (radius >= size.width / 2) {
      canvas.drawCircle(size.center(Offset.zero), size.width / 2, paint);
    } else {
      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, Radius.circular(radius)),
        paint,
      );
    }

    if (initials.isNotEmpty) {
      final textPainter = TextPainter(
        text: TextSpan(
          text: initials,
          style: TextStyle(
            color: textColor,
            fontSize: fontSize,
            fontWeight: FontWeight.w700,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        size.center(Offset.zero) - Offset(textPainter.width / 2, textPainter.height / 2),
      );
    } else {
      // Draw a default user icon if no initials
      final iconPaint = Paint()
        ..color = textColor
        ..style = PaintingStyle.fill;

      final center = size.center(Offset.zero);
      final radius = size.width / 4;

      // Head
      canvas.drawCircle(center - Offset(0, radius * 0.6), radius * 0.5, iconPaint);

      // Body
      final bodyRect = Rect.fromCenter(
        center: center + Offset(0, radius * 0.8),
        width: radius * 1.5,
        height: radius,
      );
      canvas.drawArc(bodyRect, 3.14, 3.14, true, iconPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _AvatarPainter oldDelegate) {
    return oldDelegate.initials != initials ||
        oldDelegate.bgColor != bgColor ||
        oldDelegate.textColor != textColor ||
        oldDelegate.radius != radius ||
        oldDelegate.fontSize != fontSize;
  }
}
