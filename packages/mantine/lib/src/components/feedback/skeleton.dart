import 'package:flutter/widgets.dart';
import '../../foundation/radius.dart';
import '../../foundation/size.dart';
import '../../foundation/colors.dart';
import '../../theme/context_extensions.dart';

class MantineSkeleton extends StatefulWidget {
  const MantineSkeleton({
    super.key,
    this.visible = true,
    this.animate = true,
    this.circle = false,
    this.radius,
    this.height,
    this.width,
    this.child,
  });

  final bool visible;
  final bool animate;
  final bool circle;
  final MantineSize? radius;
  final double? height;
  final double? width;
  final Widget? child;

  @override
  State<MantineSkeleton> createState() => _MantineSkeletonState();
}

class _MantineSkeletonState extends State<MantineSkeleton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    if (widget.animate && widget.visible) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(MantineSkeleton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animate && widget.visible) {
      if (!_controller.isAnimating) {
        _controller.repeat();
      }
    } else {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.mantineTheme;
    final isDark = context.isDarkMode;

    final backgroundColor = isDark ? MantineColors.dark[6] : MantineColors.gray[1];
    final shimmerColor = isDark ? MantineColors.dark[5] : MantineColors.gray[0];

    final resolvedRadius = widget.circle
        ? MantineRadius.circle
        : theme.radius.resolve(widget.radius ?? theme.defaultRadius);

    Widget skeleton = Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(resolvedRadius),
      ),
      child: (widget.animate && widget.visible)
          ? AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return ShaderMask(
                  blendMode: BlendMode.srcIn,
                  shaderCallback: (bounds) {
                    return LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        backgroundColor,
                        shimmerColor,
                        backgroundColor,
                      ],
                      stops: const [
                        0.1,
                        0.5,
                        0.9,
                      ],
                      transform: _SlideGradientTransform(_controller.value),
                    ).createShader(bounds);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.circular(resolvedRadius),
                    ),
                  ),
                );
              },
            )
          : null,
    );

    if (widget.child == null) {
      return widget.visible ? skeleton : const SizedBox.shrink();
    }

    return Stack(
      fit: StackFit.passthrough,
      children: [
        if (widget.visible)
          Positioned.fill(
            child: skeleton,
          ),
        Opacity(
          opacity: widget.visible ? 0 : 1,
          child: IgnorePointer(
            ignoring: widget.visible,
            child: widget.child,
          ),
        ),
      ],
    );
  }
}

class _SlideGradientTransform extends GradientTransform {
  const _SlideGradientTransform(this.percent);

  final double percent;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * (2 * percent - 1), 0, 0);
  }
}
