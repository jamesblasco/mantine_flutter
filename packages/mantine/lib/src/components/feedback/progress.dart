import 'package:flutter/widgets.dart';
import '../../foundation/size.dart';
import '../../foundation/colors.dart';
import '../../theme/context_extensions.dart';

class MantineProgressSection {
  const MantineProgressSection({
    required this.value,
    this.color,
    this.striped = false,
    this.animated = false,
    this.label,
  });

  final double value;
  final Color? color;
  final bool striped;
  final bool animated;
  final Widget? label;
}

class MantineProgress extends StatefulWidget {
  const MantineProgress({
    super.key,
    this.value,
    this.color,
    this.size = MantineSize.md,
    this.radius = MantineSize.sm,
    this.striped = false,
    this.animated = false,
    this.sections,
  });

  final double? value;
  final Color? color;
  final MantineSize size;
  final MantineSize radius;
  final bool striped;
  final bool animated;
  final List<MantineProgressSection>? sections;

  @override
  State<MantineProgress> createState() => _MantineProgressState();
}

class _MantineProgressState extends State<MantineProgress> with SingleTickerProviderStateMixin {
  late AnimationController _stripeController;

  @override
  void initState() {
    super.initState();
    _stripeController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    if (_shouldAnimate) {
      _stripeController.repeat();
    }
  }

  bool get _shouldAnimate {
    if (widget.animated && widget.striped) return true;
    if (widget.sections != null) {
      return widget.sections!.any((s) => s.animated && s.striped);
    }
    return false;
  }

  @override
  void didUpdateWidget(MantineProgress oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_shouldAnimate) {
      if (!_stripeController.isAnimating) {
        _stripeController.repeat();
      }
    } else {
      _stripeController.stop();
    }
  }

  @override
  void dispose() {
    _stripeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = switch (widget.size) {
      MantineSize.xs => 3.0,
      MantineSize.sm => 5.0,
      MantineSize.md => 8.0,
      MantineSize.lg => 12.0,
      MantineSize.xl => 16.0,
    };

    final radiusValue = context.mantineTheme.radius.resolve(widget.radius);
    final effectiveBorderRadius = BorderRadius.circular(radiusValue);

    final backgroundColor = context.isDarkMode ? MantineColors.dark[4] : MantineColors.gray[2];

    Widget content;
    if (widget.sections != null) {
      double totalValue = 0;
      final List<Widget> children = [];
      for (final section in widget.sections!) {
        totalValue += section.value;
        children.add(
          _AnimatedFlexible(
            value: section.value,
            child: _ProgressFill(
              value: 1.0,
              color: section.color ?? context.mantinePrimaryColor,
              striped: section.striped,
              animated: section.animated,
              stripeAnimation: _stripeController,
              label: section.label,
            ),
          ),
        );
      }

      if (totalValue < 100) {
        children.add(
          _AnimatedFlexible(
            value: 100 - totalValue,
            child: const SizedBox.expand(),
          ),
        );
      }

      content = Row(children: children);
    } else {
      content = _ProgressFill(
        value: (widget.value ?? 0) / 100,
        color: widget.color ?? context.mantinePrimaryColor,
        striped: widget.striped,
        animated: widget.animated,
        stripeAnimation: _stripeController,
      );
    }

    return Container(
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: effectiveBorderRadius,
      ),
      clipBehavior: Clip.antiAlias,
      child: content,
    );
  }
}

class _AnimatedFlexible extends StatelessWidget {
  const _AnimatedFlexible({required this.value, required this.child});

  final double value;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: value, end: value),
      duration: const Duration(milliseconds: 200),
      builder: (context, val, child) {
        // Use a larger multiplier for flex to handle decimals better
        final flex = (val * 100).toInt();
        if (flex <= 0) return const SizedBox.shrink();
        return Flexible(
          flex: flex,
          child: child!,
        );
      },
      child: child,
    );
  }
}

class _ProgressFill extends StatelessWidget {
  const _ProgressFill({
    required this.value,
    required this.color,
    required this.striped,
    required this.animated,
    required this.stripeAnimation,
    this.label,
  });

  final double value;
  final Color color;
  final bool striped;
  final bool animated;
  final Animation<double> stripeAnimation;
  final Widget? label;

  @override
  Widget build(BuildContext context) {
    return AnimatedFractionallySizedBox(
      duration: const Duration(milliseconds: 200),
      alignment: Alignment.centerLeft,
      widthFactor: value,
      heightFactor: 1.0,
      child: Container(
        color: color,
        child: Stack(
          children: [
            if (striped)
              Positioned.fill(
                child: AnimatedBuilder(
                  animation: stripeAnimation,
                  builder: (context, child) {
                    return CustomPaint(
                      painter: _StripedPainter(
                        progress: animated ? stripeAnimation.value : 0.0,
                        color: const Color(0xFFFFFFFF).withValues(alpha: 0.15),
                      ),
                    );
                  },
                ),
              ),
            if (label != null) Center(child: label),
          ],
        ),
      ),
    );
  }
}

class _StripedPainter extends CustomPainter {
  _StripedPainter({required this.progress, required this.color});

  final double progress;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    const stripeWidth = 20.0;
    final gap = stripeWidth;
    final totalWidth = stripeWidth + gap;

    final offset = progress * totalWidth;

    canvas.save();
    canvas.translate(-totalWidth + offset, 0);

    final count = (size.width / totalWidth).ceil() + 2;

    for (int i = 0; i < count; i++) {
      final path = Path();
      final x = i * totalWidth;

      path.moveTo(x, 0);
      path.lineTo(x + stripeWidth, 0);
      path.lineTo(x + stripeWidth - 10, size.height); // diagonal
      path.lineTo(x - 10, size.height);
      path.close();

      canvas.drawPath(path, paint);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(_StripedPainter old) => old.progress != progress || old.color != color;
}
