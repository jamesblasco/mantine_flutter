import 'package:flutter/widgets.dart';
import '../../foundation/size.dart';
import '../../foundation/radius.dart';
import '../../foundation/colors.dart';
import '../../theme/context_extensions.dart';

enum MantineStepperOrientation { horizontal, vertical }

class MantineStep extends StatelessWidget {
  const MantineStep({
    super.key,
    this.label,
    this.description,
    this.icon,
    this.loading = false,
    this.error = false,
    required this.child,
  });

  final Widget? label;
  final Widget? description;
  final Widget? icon;
  final bool loading;
  final bool error;
  final Widget child;

  @override
  Widget build(BuildContext context) => child;
}

class MantineStepperCompleted extends StatelessWidget {
  const MantineStepperCompleted({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) => child;
}

class MantineStepper extends StatelessWidget {
  const MantineStepper({
    super.key,
    required this.active,
    this.onStepClick,
    this.allowNextStepsSelect = true,
    this.orientation = MantineStepperOrientation.horizontal,
    this.iconSize,
    this.size = MantineSize.md,
    this.color,
    this.radius = MantineRadius.circle,
    this.completedIcon,
    this.progressIcon,
    required this.children,
  });

  final int active;
  final ValueChanged<int>? onStepClick;
  final bool allowNextStepsSelect;
  final MantineStepperOrientation orientation;
  final double? iconSize;
  final MantineSize size;
  final String? color;
  final dynamic radius;
  final Widget? completedIcon;
  final Widget? progressIcon;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final steps = children.whereType<MantineStep>().toList();
    final completed = children.whereType<MantineStepperCompleted>().toList();

    final double effectiveIconSize = iconSize ??
        switch (size) {
          MantineSize.xs => 34.0,
          MantineSize.sm => 38.0,
          MantineSize.md => 42.0,
          MantineSize.lg => 48.0,
          MantineSize.xl => 52.0,
        };

    final content = active >= 0 && active < steps.length
        ? steps[active].child
        : (completed.isNotEmpty ? completed.first.child : null);

    if (orientation == MantineStepperOrientation.horizontal) {
      final List<Widget> items = [];
      for (int i = 0; i < steps.length; i++) {
        final step = steps[i];
        items.add(
          _Step(
            index: i,
            active: i == active,
            completed: i < active,
            error: step.error,
            icon: step.icon,
            label: step.label,
            description: step.description,
            loading: step.loading,
            size: size,
            iconSize: effectiveIconSize,
            color: color,
            radius: radius,
            completedIcon: completedIcon,
            progressIcon: progressIcon,
            orientation: orientation,
            onTap: onStepClick != null && (allowNextStepsSelect || i <= active)
                ? () => onStepClick!(i)
                : null,
          ),
        );

        if (i < steps.length - 1) {
          items.add(
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: effectiveIconSize / 2),
                child: _Separator(
                  orientation: orientation,
                  active: i < active,
                  color: color,
                  iconSize: effectiveIconSize,
                ),
              ),
            ),
          );
        }
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: items,
          ),
          if (content != null) ...[
            const SizedBox(height: 20),
            content,
          ],
        ],
      );
    } else {
      final List<Widget> items = [];
      for (int i = 0; i < steps.length; i++) {
        final step = steps[i];
        final isStepActive = i == active;

        items.add(
          _Step(
            index: i,
            active: isStepActive,
            completed: i < active,
            error: step.error,
            icon: step.icon,
            label: step.label,
            description: step.description,
            loading: step.loading,
            size: size,
            iconSize: effectiveIconSize,
            color: color,
            radius: radius,
            completedIcon: completedIcon,
            progressIcon: progressIcon,
            orientation: orientation,
            onTap: onStepClick != null && (allowNextStepsSelect || i <= active)
                ? () => onStepClick!(i)
                : null,
          ),
        );

        if (isStepActive) {
          items.add(
            Padding(
              padding: EdgeInsets.only(
                left: effectiveIconSize + 12,
                top: 8,
                bottom: 8,
              ),
              child: step.child,
            ),
          );
        }

        if (i < steps.length - 1) {
          items.add(
            _Separator(
              orientation: orientation,
              active: i < active,
              color: color,
              iconSize: effectiveIconSize,
            ),
          );
        }
      }

      if (active >= steps.length && completed.isNotEmpty) {
        items.add(const SizedBox(height: 20));
        items.add(completed.first.child);
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items,
      );
    }
  }
}

class _Step extends StatelessWidget {
  const _Step({
    required this.index,
    required this.active,
    required this.completed,
    required this.error,
    this.icon,
    this.label,
    this.description,
    required this.loading,
    required this.size,
    required this.iconSize,
    this.color,
    this.radius,
    this.completedIcon,
    this.progressIcon,
    required this.orientation,
    this.onTap,
  });

  final int index;
  final bool active;
  final bool completed;
  final bool error;
  final Widget? icon;
  final Widget? label;
  final Widget? description;
  final bool loading;
  final MantineSize size;
  final double iconSize;
  final String? color;
  final dynamic radius;
  final Widget? completedIcon;
  final Widget? progressIcon;
  final MantineStepperOrientation orientation;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.mantineTheme;
    final isDark = context.isDarkMode;

    final String effectiveColorName = color ?? theme.primaryColor;
    final colorScale = theme.colors.resolve(effectiveColorName);

    Color stepBg;
    Color stepBorder;
    Color stepIconColor;

    if (error) {
      final redScale = MantineColors.red;
      stepBg = isDark ? redScale[9].withValues(alpha: 0.3) : redScale[0];
      stepBorder = redScale[isDark ? 8 : 6];
      stepIconColor = redScale[isDark ? 5 : 7];
    } else if (active) {
      stepBg = isDark ? theme.black : theme.white;
      stepBorder = colorScale[theme.primaryShade];
      stepIconColor = colorScale[theme.primaryShade];
    } else if (completed) {
      stepBg = colorScale[theme.primaryShade];
      stepBorder = colorScale[theme.primaryShade];
      stepIconColor = theme.white;
    } else {
      stepBg = isDark ? MantineColors.dark[6] : MantineColors.gray[1];
      stepBorder = isDark ? MantineColors.dark[4] : MantineColors.gray[3];
      stepIconColor = isDark ? MantineColors.dark[2] : MantineColors.gray[6];
    }

    final double resolvedRadius = radius is MantineSize
        ? theme.radius.resolve(radius as MantineSize)
        : (radius is double ? radius as double : MantineRadius.circle);

    Widget iconWidget;
    if (loading) {
      iconWidget = _CircularLoader(color: stepIconColor, size: iconSize * 0.5);
    } else if (error) {
      iconWidget = CustomPaint(
        size: Size(iconSize * 0.4, iconSize * 0.4),
        painter: _CrossPainter(color: stepIconColor),
      );
    } else if (completed) {
      iconWidget = completedIcon ??
          CustomPaint(
            size: Size(iconSize * 0.45, iconSize * 0.45),
            painter: _CheckPainter(color: stepIconColor),
          );
    } else if (active && progressIcon != null) {
      iconWidget = progressIcon!;
    } else if (icon != null) {
      iconWidget = icon!;
    } else {
      iconWidget = Text(
        '${index + 1}',
        style: TextStyle(
          color: stepIconColor,
          fontSize: iconSize * 0.4,
          fontWeight: FontWeight.w700,
          fontFamily: theme.typography.fontFamily,
        ),
      );
    }

    final stepCircle = Container(
      width: iconSize,
      height: iconSize,
      decoration: BoxDecoration(
        color: stepBg,
        border: Border.all(color: stepBorder, width: 2),
        borderRadius: BorderRadius.circular(resolvedRadius),
      ),
      child: Center(child: iconWidget),
    );

    final stepLabels = (label != null || description != null)
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (label != null)
                DefaultTextStyle(
                  style: TextStyle(
                    fontSize: switch (size) {
                      MantineSize.xs => 12.0,
                      MantineSize.sm => 14.0,
                      MantineSize.md => 16.0,
                      MantineSize.lg => 18.0,
                      MantineSize.xl => 20.0,
                    },
                    fontWeight: FontWeight.w500,
                    color: isDark ? MantineColors.dark[0] : MantineColors.gray[9],
                    fontFamily: theme.typography.fontFamily,
                  ),
                  child: label!,
                ),
              if (description != null)
                DefaultTextStyle(
                  style: TextStyle(
                    fontSize: switch (size) {
                      MantineSize.xs => 10.0,
                      MantineSize.sm => 12.0,
                      MantineSize.md => 14.0,
                      MantineSize.lg => 16.0,
                      MantineSize.xl => 18.0,
                    },
                    color: context.mantineDimmedText,
                    fontFamily: theme.typography.fontFamily,
                  ),
                  child: description!,
                ),
            ],
          )
        : null;

    Widget content;
    if (orientation == MantineStepperOrientation.horizontal) {
      content = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          stepCircle,
          if (stepLabels != null) ...[
            const SizedBox(width: 12),
            stepLabels,
          ],
        ],
      );
    } else {
      content = Row(
        children: [
          stepCircle,
          if (stepLabels != null) ...[
            const SizedBox(width: 12),
            stepLabels,
          ],
        ],
      );
    }

    if (onTap != null) {
      return MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onTap,
          behavior: HitTestBehavior.opaque,
          child: content,
        ),
      );
    }

    return content;
  }
}

class _Separator extends StatelessWidget {
  const _Separator({
    required this.orientation,
    required this.active,
    this.color,
    required this.iconSize,
  });

  final MantineStepperOrientation orientation;
  final bool active;
  final String? color;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final theme = context.mantineTheme;
    final isDark = context.isDarkMode;

    final String effectiveColorName = color ?? theme.primaryColor;
    final colorScale = theme.colors.resolve(effectiveColorName);

    final lineColor = active
        ? colorScale[theme.primaryShade]
        : (isDark ? MantineColors.dark[4] : MantineColors.gray[3]);

    if (orientation == MantineStepperOrientation.horizontal) {
      return Container(
        height: 2,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: CustomPaint(
          size: const Size(double.infinity, 2),
          painter: _LinePainter(color: lineColor, horizontal: true),
        ),
      );
    } else {
      return Container(
        width: 2,
        height: 30,
        margin: EdgeInsets.only(left: iconSize / 2 - 1),
        child: CustomPaint(
          size: const Size(2, 30),
          painter: _LinePainter(color: lineColor, horizontal: false),
        ),
      );
    }
  }
}

class _LinePainter extends CustomPainter {
  final Color color;
  final bool horizontal;

  _LinePainter({required this.color, required this.horizontal});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = horizontal ? size.height : size.width
      ..style = PaintingStyle.stroke;

    if (horizontal) {
      canvas.drawLine(
        Offset(0, size.height / 2),
        Offset(size.width, size.height / 2),
        paint,
      );
    } else {
      canvas.drawLine(
        Offset(size.width / 2, 0),
        Offset(size.width / 2, size.height),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _LinePainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.horizontal != horizontal;
}

class _CheckPainter extends CustomPainter {
  final Color color;
  _CheckPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final path = Path()
      ..moveTo(size.width * 0.1, size.height * 0.5)
      ..lineTo(size.width * 0.4, size.height * 0.8)
      ..lineTo(size.width * 0.9, size.height * 0.2);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _CheckPainter oldDelegate) => oldDelegate.color != color;
}

class _CrossPainter extends CustomPainter {
  final Color color;
  _CrossPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(Offset.zero, Offset(size.width, size.height), paint);
    canvas.drawLine(Offset(size.width, 0), Offset(0, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant _CrossPainter oldDelegate) => oldDelegate.color != color;
}

class _CircularLoader extends StatefulWidget {
  final Color color;
  final double size;
  const _CircularLoader({required this.color, required this.size});

  @override
  State<_CircularLoader> createState() => _CircularLoaderState();
}

class _CircularLoaderState extends State<_CircularLoader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 1))..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: _controller.value * 2 * 3.14159,
          child: CustomPaint(
            size: Size(widget.size, widget.size),
            painter: _LoaderPainter(color: widget.color),
          ),
        );
      },
    );
  }
}

class _LoaderPainter extends CustomPainter {
  final Color color;
  _LoaderPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Offset.zero & size,
      0,
      3.14159 * 1.5,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _LoaderPainter oldDelegate) => oldDelegate.color != color;
}
