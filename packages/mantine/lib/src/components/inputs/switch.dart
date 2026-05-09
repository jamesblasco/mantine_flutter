import 'package:flutter/widgets.dart';
import '../../foundation/size.dart';
import '../../theme/context_extensions.dart';
import 'checkbox.dart' show MantineLabelPosition;

class MantineSwitch extends StatefulWidget {
  const MantineSwitch({
    super.key,
    required this.checked,
    required this.onChanged,
    this.label,
    this.description,
    this.color,
    this.size = MantineSize.sm,
    this.disabled = false,
    this.thumbIcon,
    this.labelPosition = MantineLabelPosition.right,
    this.onLabel,
    this.offLabel,
  });

  final bool checked;
  final ValueChanged<bool>? onChanged;
  final String? label;
  final String? description;
  final String? color;
  final MantineSize size;
  final bool disabled;
  final Widget? thumbIcon;
  final MantineLabelPosition labelPosition;
  final String? onLabel;
  final String? offLabel;

  @override
  State<MantineSwitch> createState() => _MantineSwitchState();
}

class _MantineSwitchState extends State<MantineSwitch>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      value: widget.checked ? 1.0 : 0.0,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void didUpdateWidget(MantineSwitch old) {
    super.didUpdateWidget(old);
    if (widget.checked != old.checked) {
      if (widget.checked) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    if (!widget.disabled && widget.onChanged != null) {
      widget.onChanged!(!widget.checked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.mantineTheme;
    final isDark = context.isDarkMode;
    final colorScale =
        theme.colors.resolve(widget.color ?? theme.primaryColor);

    final (trackW, trackH) = switch (widget.size) {
      MantineSize.xs => (32.0, 18.0),
      MantineSize.sm => (38.0, 22.0),
      MantineSize.md => (46.0, 26.0),
      MantineSize.lg => (54.0, 30.0),
      MantineSize.xl => (62.0, 34.0),
    };

    final fontSize = switch (widget.size) {
      MantineSize.xs => 12.0,
      MantineSize.sm => 13.0,
      MantineSize.md => 14.0,
      MantineSize.lg => 16.0,
      MantineSize.xl => 18.0,
    };

    final thumbSize = trackH - 4;
    final thumbTravel = trackW - thumbSize - 4;

    final trackOff = isDark
        ? theme.colors.resolve('dark')[4]
        : theme.colors.resolve('gray')[3];
    final trackOn = colorScale[theme.primaryShade];

    final thumb = DecoratedBox(
      decoration: BoxDecoration(
        color: theme.white,
        shape: BoxShape.circle,
        boxShadow: const [
          BoxShadow(
            color: Color(0x22000000),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: SizedBox(
        width: thumbSize,
        height: thumbSize,
        child: widget.thumbIcon != null
            ? Center(child: widget.thumbIcon)
            : null,
      ),
    );

    Widget track = AnimatedBuilder(
      animation: _animation,
      child: thumb,
      builder: (context, child) {
        final t = _animation.value;
        final trackColor = Color.lerp(trackOff, trackOn, t)!;
        final thumbLeft = 2 + thumbTravel * t;

        return SizedBox(
          width: trackW,
          height: trackH,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: trackColor,
              borderRadius: BorderRadius.circular(trackH / 2),
            ),
            child: Stack(
              children: [
                Positioned(left: thumbLeft, top: 2, child: child!),
              ],
            ),
          ),
        );
      },
    );

    track = GestureDetector(
      onTap: _toggle,
      child: MouseRegion(
        cursor: widget.disabled
            ? SystemMouseCursors.forbidden
            : SystemMouseCursors.click,
        child: track,
      ),
    );

    if (widget.label == null) {
      return Opacity(opacity: widget.disabled ? 0.6 : 1.0, child: track);
    }

    final labelWidget = GestureDetector(
      onTap: _toggle,
      child: MouseRegion(
        cursor: widget.disabled
            ? SystemMouseCursors.forbidden
            : SystemMouseCursors.click,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.label!,
              style: TextStyle(
                fontSize: fontSize,
                color: widget.disabled
                    ? context.mantineDimmedText
                    : context.mantineBodyText,
                fontFamily: theme.typography.fontFamily,
              ),
            ),
            if (widget.description != null)
              Text(
                widget.description!,
                style: TextStyle(
                  fontSize: fontSize - 2,
                  color: context.mantineDimmedText,
                  fontFamily: theme.typography.fontFamily,
                ),
              ),
          ],
        ),
      ),
    );

    return Opacity(
      opacity: widget.disabled ? 0.6 : 1.0,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: widget.labelPosition == MantineLabelPosition.right
            ? [track, const SizedBox(width: 10), labelWidget]
            : [labelWidget, const SizedBox(width: 10), track],
      ),
    );
  }
}
