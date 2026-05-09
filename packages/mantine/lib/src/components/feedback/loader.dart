import 'dart:math' as math;
import 'package:flutter/widgets.dart';
import '../../foundation/size.dart';
import '../../theme/context_extensions.dart';

enum MantineLoaderType { oval, bars, dots }

class MantineLoader extends StatefulWidget {
  const MantineLoader({
    super.key,
    this.type = MantineLoaderType.oval,
    this.size = MantineSize.sm,
    this.sizeValue,
    this.color,
  });

  final MantineLoaderType type;
  final MantineSize size;
  final double? sizeValue;
  final Color? color;

  @override
  State<MantineLoader> createState() => _MantineLoaderState();
}

class _MantineLoaderState extends State<MantineLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final px = widget.sizeValue ??
        switch (widget.size) {
          MantineSize.xs => 18.0,
          MantineSize.sm => 22.0,
          MantineSize.md => 36.0,
          MantineSize.lg => 44.0,
          MantineSize.xl => 58.0,
        };
    final loaderColor = widget.color ?? context.mantinePrimaryColor;

    return SizedBox(
      width: px,
      height: px,
      child: switch (widget.type) {
        MantineLoaderType.oval => AnimatedBuilder(
            animation: _controller,
            builder: (_, __) => CustomPaint(
              painter: _OvalLoaderPainter(
                  progress: _controller.value, color: loaderColor),
            ),
          ),
        MantineLoaderType.bars => AnimatedBuilder(
            animation: _controller,
            builder: (_, __) => CustomPaint(
              painter: _BarsLoaderPainter(
                  progress: _controller.value, color: loaderColor),
            ),
          ),
        MantineLoaderType.dots => AnimatedBuilder(
            animation: _controller,
            builder: (_, __) => CustomPaint(
              painter: _DotsLoaderPainter(
                  progress: _controller.value, color: loaderColor),
            ),
          ),
      },
    );
  }
}

class _OvalLoaderPainter extends CustomPainter {
  _OvalLoaderPainter({required this.progress, required this.color});

  final double progress;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.1
      ..strokeCap = StrokeCap.round;

    final trackPaint = Paint()
      ..color = color.withValues(alpha: 0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.1;

    final rect =
        Rect.fromCircle(center: size.center(Offset.zero), radius: size.width / 2 - size.width * 0.05);

    canvas.drawArc(rect, 0, math.pi * 2, false, trackPaint);

    final startAngle = progress * math.pi * 2 - math.pi / 2;
    const sweepAngle = math.pi * 1.2;
    canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(_OvalLoaderPainter old) => old.progress != progress;
}

class _BarsLoaderPainter extends CustomPainter {
  _BarsLoaderPainter({required this.progress, required this.color});

  final double progress;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final barWidth = size.width * 0.2;
    final barHeight = size.height * 0.6;
    final gap = size.width * 0.12;
    final totalW = 3 * barWidth + 2 * gap;
    final startX = (size.width - totalW) / 2;
    final paint = Paint()..style = PaintingStyle.fill;

    for (int i = 0; i < 3; i++) {
      final phase = (progress - i * 0.15) % 1.0;
      final scale = 0.4 + 0.6 * math.sin(phase * math.pi).clamp(0.0, 1.0);
      final scaledH = barHeight * scale;
      final x = startX + i * (barWidth + gap);
      final y = (size.height - scaledH) / 2;
      paint.color = color;
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(x, y, barWidth, scaledH),
          Radius.circular(barWidth / 2),
        ),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_BarsLoaderPainter old) =>
      old.progress != progress || old.color != color;
}

class _DotsLoaderPainter extends CustomPainter {
  _DotsLoaderPainter({required this.progress, required this.color});

  final double progress;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final dotSize = size.width * 0.22;
    final gap = size.width * 0.12;
    final totalW = 3 * dotSize + 2 * gap;
    final startX = (size.width - totalW) / 2;
    final paint = Paint()..style = PaintingStyle.fill;

    for (int i = 0; i < 3; i++) {
      final phase = (progress - i * 0.18) % 1.0;
      final opacity = 0.3 + 0.7 * math.sin(phase * math.pi).clamp(0.0, 1.0);
      final cx = startX + i * (dotSize + gap) + dotSize / 2;
      paint.color = color.withValues(alpha: opacity);
      canvas.drawCircle(Offset(cx, size.height / 2), dotSize / 2, paint);
    }
  }

  @override
  bool shouldRepaint(_DotsLoaderPainter old) =>
      old.progress != progress || old.color != color;
}
