import 'package:flutter/widgets.dart';
import '../../foundation/colors.dart';
import '../../foundation/size.dart';
import '../../theme/context_extensions.dart';
import '../../utils/uncontrolled.dart';
import '../data_display/collapse.dart';

enum MantineNavLinkVariant {
  filled,
  light,
  subtle,
}

class MantineNavLink extends StatefulWidget {
  const MantineNavLink({
    super.key,
    required this.label,
    this.description,
    this.leftSection,
    this.rightSection,
    this.active = false,
    this.disabled = false,
    this.variant = MantineNavLinkVariant.subtle,
    this.color,
    this.size = MantineSize.sm,
    this.onTap,
    this.children,
    this.childrenOffset = 16.0,
    this.defaultOpened = false,
    this.opened,
    this.onChange,
  });

  final Widget label;
  final Widget? description;
  final Widget? leftSection;
  final Widget? rightSection;
  final bool active;
  final bool disabled;
  final MantineNavLinkVariant variant;
  final String? color;
  final MantineSize size;
  final VoidCallback? onTap;
  final List<Widget>? children;
  final double childrenOffset;
  final bool defaultOpened;
  final bool? opened;
  final ValueChanged<bool>? onChange;

  @override
  State<MantineNavLink> createState() => _MantineNavLinkState();
}

class _MantineNavLinkState extends State<MantineNavLink> {
  bool _hovered = false;
  bool _pressed = false;

  late final MantineUncontrolled<bool> _openedState;

  @override
  void initState() {
    super.initState();
    _openedState = MantineUncontrolled<bool>(
      value: widget.opened,
      defaultValue: widget.defaultOpened,
      finalValue: false,
      onChanged: widget.onChange,
    );
  }

  @override
  void didUpdateWidget(MantineNavLink oldWidget) {
    super.didUpdateWidget(oldWidget);
    _openedState.update(
      value: widget.opened,
      onChanged: widget.onChange,
    );
  }

  void _handleTap() {
    if (widget.disabled) return;
    widget.onTap?.call();
    if (widget.children != null && widget.children!.isNotEmpty) {
      _openedState.handleChange(!_openedState.currentValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.mantineTheme;
    final isDark = context.isDarkMode;
    final colorScale =
        theme.colors.resolve(widget.color ?? theme.primaryColor);
    final shade = theme.primaryShade;

    final verticalPadding = switch (widget.size) {
      MantineSize.xs => 4.0,
      MantineSize.sm => 8.0,
      MantineSize.md => 10.0,
      MantineSize.lg => 12.0,
      MantineSize.xl => 16.0,
    };

    final horizontalPadding = 12.0;

    final labelFontSize = switch (widget.size) {
      MantineSize.xs => 12.0,
      MantineSize.sm => 14.0,
      MantineSize.md => 16.0,
      MantineSize.lg => 18.0,
      MantineSize.xl => 20.0,
    };

    final descriptionFontSize = labelFontSize - 2.0;

    Color bgColor = const Color(0x00000000);
    Color textColor = context.mantineBodyText;
    Color? descriptionColor = context.mantineDimmedText;

    if (widget.active) {
      switch (widget.variant) {
        case MantineNavLinkVariant.filled:
          bgColor = colorScale[shade];
          textColor = theme.white;
          descriptionColor = theme.white.withValues(alpha: 0.8);
        case MantineNavLinkVariant.light:
          bgColor = isDark
              ? colorScale[9].withValues(alpha: 0.35)
              : colorScale[0];
          textColor = colorScale[isDark ? 3 : shade];
          descriptionColor = textColor.withValues(alpha: 0.8);
        case MantineNavLinkVariant.subtle:
          bgColor = const Color(0x00000000);
          textColor = colorScale[isDark ? 3 : shade];
          descriptionColor = textColor.withValues(alpha: 0.8);
      }
    }

    if (_hovered && !widget.disabled) {
      if (widget.active) {
        switch (widget.variant) {
          case MantineNavLinkVariant.filled:
            bgColor = colorScale[(shade + 1).clamp(0, 9)];
          case MantineNavLinkVariant.light:
            bgColor = isDark
                ? colorScale[9].withValues(alpha: 0.45)
                : colorScale[1];
          case MantineNavLinkVariant.subtle:
            bgColor = isDark
                ? colorScale[9].withValues(alpha: 0.35)
                : colorScale[0];
        }
      } else {
        bgColor = isDark ? MantineColors.dark[6] : MantineColors.gray[0];
      }
    }

    if (_pressed && !widget.disabled) {
      if (widget.active) {
        switch (widget.variant) {
          case MantineNavLinkVariant.filled:
            bgColor = colorScale[(shade + 1).clamp(0, 9)];
          case MantineNavLinkVariant.light:
            bgColor = isDark
                ? colorScale[9].withValues(alpha: 0.55)
                : colorScale[2];
          case MantineNavLinkVariant.subtle:
            bgColor = isDark
                ? colorScale[9].withValues(alpha: 0.45)
                : colorScale[1];
        }
      } else {
        bgColor = isDark ? MantineColors.dark[5] : MantineColors.gray[1];
      }
    }

    final hasChildren = widget.children != null && widget.children!.isNotEmpty;

    Widget? rightSection = widget.rightSection;
    if (rightSection == null && hasChildren) {
      rightSection = _Chevron(
        opened: _openedState.currentValue,
        color: textColor.withValues(alpha: 0.5),
      );
    }

    Widget content = Padding(
      padding: EdgeInsets.symmetric(
        vertical: verticalPadding,
        horizontal: horizontalPadding,
      ),
      child: Row(
        children: [
          if (widget.leftSection != null) ...[
            DefaultTextStyle.merge(
              style: TextStyle(color: textColor),
              child: IconTheme.merge(
                data: IconThemeData(color: textColor, size: 16),
                child: widget.leftSection!,
              ),
            ),
            const SizedBox(width: 12),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                DefaultTextStyle.merge(
                  style: TextStyle(
                    fontSize: labelFontSize,
                    fontWeight: widget.active ? FontWeight.w600 : FontWeight.w400,
                    color: textColor,
                    fontFamily: theme.typography.fontFamily,
                  ),
                  child: widget.label,
                ),
                if (widget.description != null)
                  DefaultTextStyle.merge(
                    style: TextStyle(
                      fontSize: descriptionFontSize,
                      color: descriptionColor,
                      fontFamily: theme.typography.fontFamily,
                    ),
                    child: widget.description!,
                  ),
              ],
            ),
          ),
          if (rightSection != null) ...[
            const SizedBox(width: 12),
            DefaultTextStyle.merge(
              style: TextStyle(color: textColor),
              child: IconTheme.merge(
                data: IconThemeData(color: textColor, size: 16),
                child: rightSection,
              ),
            ),
          ],
        ],
      ),
    );

    Widget link = MouseRegion(
      cursor: widget.disabled
          ? SystemMouseCursors.forbidden
          : SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() {
        _hovered = false;
        _pressed = false;
      }),
      child: GestureDetector(
        onTapDown: widget.disabled ? null : (_) => setState(() => _pressed = true),
        onTapUp: widget.disabled ? null : (_) => setState(() => _pressed = false),
        onTapCancel: widget.disabled ? null : () => setState(() => _pressed = false),
        onTap: _handleTap,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(theme.radius.sm),
          ),
          child: Opacity(
            opacity: widget.disabled ? 0.4 : 1.0,
            child: content,
          ),
        ),
      ),
    );

    if (hasChildren) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          link,
          MantineCollapse(
            opened: _openedState.currentValue,
            child: Padding(
              padding: EdgeInsets.only(left: widget.childrenOffset),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: widget.children!,
              ),
            ),
          ),
        ],
      );
    }

    return link;
  }
}

class _Chevron extends StatelessWidget {
  const _Chevron({
    required this.opened,
    required this.color,
  });

  final bool opened;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return AnimatedRotation(
      duration: const Duration(milliseconds: 200),
      turns: opened ? 0.25 : 0,
      child: CustomPaint(
        size: const Size(14, 14),
        painter: _ChevronPainter(color: color),
      ),
    );
  }
}

class _ChevronPainter extends CustomPainter {
  _ChevronPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final path = Path();
    path.moveTo(size.width * 0.35, size.height * 0.25);
    path.lineTo(size.width * 0.65, size.height * 0.5);
    path.lineTo(size.width * 0.35, size.height * 0.75);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _ChevronPainter oldDelegate) =>
      color != oldDelegate.color;
}
