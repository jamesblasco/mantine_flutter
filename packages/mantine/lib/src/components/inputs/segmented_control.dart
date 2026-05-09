import 'package:flutter/widgets.dart';
import '../../foundation/size.dart';
import '../../theme/context_extensions.dart';
import '../../utils/uncontrolled.dart';
import '../../foundation/colors.dart';
import '../../foundation/color_utils.dart';

class MantineSegmentedControlItem<T> {
  const MantineSegmentedControlItem({
    required this.label,
    required this.value,
    this.disabled = false,
  });

  final Widget label;
  final T value;
  final bool disabled;
}

enum MantineSegmentedControlOrientation { horizontal, vertical }

class MantineSegmentedControl<T> extends StatefulWidget {
  const MantineSegmentedControl({
    super.key,
    required this.data,
    this.value,
    this.defaultValue,
    this.onChanged,
    this.size = MantineSize.sm,
    this.radius,
    this.color,
    this.fullWidth = false,
    this.orientation = MantineSegmentedControlOrientation.horizontal,
    this.disabled = false,
    this.transitionDuration = const Duration(milliseconds: 200),
    this.transitionCurve = Curves.easeInOut,
    this.readOnly = false,
    this.autoContrast = false,
  });

  final List<MantineSegmentedControlItem<T>> data;
  final T? value;
  final T? defaultValue;
  final ValueChanged<T>? onChanged;
  final MantineSize size;
  final MantineSize? radius;
  final String? color;
  final bool fullWidth;
  final MantineSegmentedControlOrientation orientation;
  final bool disabled;
  final Duration transitionDuration;
  final Curve transitionCurve;
  final bool readOnly;
  final bool autoContrast;

  static MantineSegmentedControl<String> strings({
    Key? key,
    required List<String> data,
    String? value,
    String? defaultValue,
    ValueChanged<String>? onChanged,
    MantineSize size = MantineSize.sm,
    MantineSize? radius,
    String? color,
    bool fullWidth = false,
    MantineSegmentedControlOrientation orientation =
        MantineSegmentedControlOrientation.horizontal,
    bool disabled = false,
    Duration transitionDuration = const Duration(milliseconds: 200),
    Curve transitionCurve = Curves.easeInOut,
    bool readOnly = false,
    bool autoContrast = false,
  }) {
    return MantineSegmentedControl<String>(
      key: key,
      data: data
          .map((s) => MantineSegmentedControlItem<String>(
                label: Text(s),
                value: s,
              ))
          .toList(),
      value: value,
      defaultValue: defaultValue,
      onChanged: onChanged,
      size: size,
      radius: radius,
      color: color,
      fullWidth: fullWidth,
      orientation: orientation,
      disabled: disabled,
      transitionDuration: transitionDuration,
      transitionCurve: transitionCurve,
      readOnly: readOnly,
      autoContrast: autoContrast,
    );
  }

  @override
  State<MantineSegmentedControl<T>> createState() =>
      _MantineSegmentedControlState<T>();
}

class _MantineSegmentedControlState<T> extends State<MantineSegmentedControl<T>>
    with SingleTickerProviderStateMixin {
  late final MantineUncontrolled<T> _state;
  late AnimationController _controller;
  late Animation<double> _animation;

  final List<GlobalKey> _itemKeys = [];
  final GlobalKey _stackKey = GlobalKey();
  Rect _indicatorRect = Rect.zero;
  Rect _targetRect = Rect.zero;
  Rect _sourceRect = Rect.zero;

  @override
  void initState() {
    super.initState();
    _state = MantineUncontrolled<T>(
      value: widget.value,
      defaultValue: widget.defaultValue,
      finalValue: widget.data.isNotEmpty ? widget.data.first.value : null as T,
      onChanged: widget.onChanged,
    );

    _controller = AnimationController(
      vsync: this,
      duration: widget.transitionDuration,
    );
    _setupAnimation();

    _updateKeys();
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateIndicator(animate: false));
  }

  void _setupAnimation() {
    _animation = CurvedAnimation(
      parent: _controller,
      curve: widget.transitionCurve,
    )..addListener(_handleAnimationTick);
  }

  void _handleAnimationTick() {
    setState(() {
      _indicatorRect = Rect.lerp(_sourceRect, _targetRect, _animation.value)!;
    });
  }

  void _updateKeys() {
    _itemKeys.clear();
    for (var i = 0; i < widget.data.length; i++) {
      _itemKeys.add(GlobalKey());
    }
  }

  @override
  void didUpdateWidget(MantineSegmentedControl<T> old) {
    super.didUpdateWidget(old);
    if (widget.data.length != old.data.length) {
      _updateKeys();
    }
    _state.update(
      value: widget.value,
      onChanged: widget.onChanged,
    );

    if (widget.transitionDuration != old.transitionDuration ||
        widget.transitionCurve != old.transitionCurve) {
      _controller.duration = widget.transitionDuration;
      _animation.removeListener(_handleAnimationTick);
      _setupAnimation();
    }

    WidgetsBinding.instance.addPostFrameCallback((_) => _updateIndicator());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _updateIndicator({bool animate = true}) {
    if (!mounted) return;

    final index = widget.data.indexWhere((item) => item.value == _state.currentValue);
    if (index == -1) return;

    final renderBox = _itemKeys[index].currentContext?.findRenderObject() as RenderBox?;
    final stackBox = _stackKey.currentContext?.findRenderObject() as RenderBox?;

    if (renderBox != null && stackBox != null) {
      final position = renderBox.localToGlobal(Offset.zero, ancestor: stackBox);
      final newTarget = Rect.fromLTWH(
        position.dx,
        position.dy,
        renderBox.size.width,
        renderBox.size.height,
      );

      if (newTarget == _targetRect) return;

      if (animate && _indicatorRect != Rect.zero) {
        _sourceRect = _indicatorRect;
        _targetRect = newTarget;
        _controller.forward(from: 0);
      } else {
        setState(() {
          _indicatorRect = newTarget;
          _targetRect = newTarget;
          _sourceRect = newTarget;
        });
      }
    }
  }

  void _handleSelect(T value, bool itemDisabled) {
    if (widget.disabled || widget.readOnly || itemDisabled) return;
    if (value == _state.currentValue) return;

    _state.handleChange(value);
    _updateIndicator();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.mantineTheme;
    final isDark = context.isDarkMode;

    final borderRadius = theme.radius.resolve(widget.radius ?? theme.defaultRadius);

    final bgColor = isDark ? MantineColors.dark[8] : MantineColors.gray[1];

    final indicatorColor = widget.color != null
        ? theme.colors.resolve(widget.color!)[theme.primaryShade]
        : (isDark ? MantineColors.dark[5] : theme.white);

    final indicatorShadow = widget.color == null && !isDark
        ? [
            BoxShadow(
              color: const Color(0x0A000000),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
            BoxShadow(
              color: const Color(0x1A000000),
              blurRadius: 1,
              offset: const Offset(0, 0),
            ),
          ]
        : null;

    final children = widget.data.asMap().entries.map((entry) {
      final i = entry.key;
      final item = entry.value;
      final isSelected = item.value == _state.currentValue;
      final itemDisabled = widget.disabled || item.disabled;

      Widget content = _SegmentItem(
        key: _itemKeys[i],
        label: item.label,
        isSelected: isSelected,
        disabled: itemDisabled,
        size: widget.size,
        color: widget.color,
        indicatorColor: indicatorColor,
        autoContrast: widget.autoContrast,
      );

      if (widget.fullWidth && widget.orientation == MantineSegmentedControlOrientation.horizontal) {
        content = Expanded(child: content);
      }

      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => _handleSelect(item.value, item.disabled),
        child: content,
      );
    }).toList();

    Widget body = widget.orientation == MantineSegmentedControlOrientation.horizontal
        ? Row(
            mainAxisSize: widget.fullWidth ? MainAxisSize.max : MainAxisSize.min,
            children: children,
          )
        : Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: children,
          );

    return Opacity(
      opacity: widget.disabled ? 0.6 : 1.0,
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        padding: const EdgeInsets.all(4),
        child: Stack(
          key: _stackKey,
          children: [
            if (_indicatorRect != Rect.zero)
              Positioned.fromRect(
                rect: _indicatorRect,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: indicatorColor,
                    borderRadius: BorderRadius.circular(borderRadius - 2 > 0 ? borderRadius - 2 : 0),
                    boxShadow: indicatorShadow,
                  ),
                ),
              ),
            body,
          ],
        ),
      ),
    );
  }
}

class _SegmentItem extends StatelessWidget {
  const _SegmentItem({
    super.key,
    required this.label,
    required this.isSelected,
    required this.disabled,
    required this.size,
    this.color,
    this.indicatorColor,
    this.autoContrast = false,
  });

  final Widget label;
  final bool isSelected;
  final bool disabled;
  final MantineSize size;
  final String? color;
  final Color? indicatorColor;
  final bool autoContrast;

  @override
  Widget build(BuildContext context) {
    final theme = context.mantineTheme;
    final isDark = context.isDarkMode;

    final fontSize = switch (size) {
      MantineSize.xs => 12.0,
      MantineSize.sm => 13.0,
      MantineSize.md => 14.0,
      MantineSize.lg => 16.0,
      MantineSize.xl => 18.0,
    };

    final padding = switch (size) {
      MantineSize.xs => const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      MantineSize.sm => const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      MantineSize.md => const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      MantineSize.lg => const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      MantineSize.xl => const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    };

    Color textColor;
    if (disabled) {
      textColor = context.mantineDimmedText;
    } else if (isSelected) {
      if (autoContrast && indicatorColor != null) {
        textColor = MantineColorUtils.getContrastColor(indicatorColor!);
      } else if (color != null) {
        textColor = theme.white;
      } else {
        textColor = isDark ? theme.white : theme.black;
      }
    } else {
      textColor = context.mantineDimmedText;
    }

    return MouseRegion(
      cursor: disabled ? SystemMouseCursors.forbidden : SystemMouseCursors.click,
      child: Padding(
        padding: padding,
        child: Center(
          child: DefaultTextStyle(
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w500,
              color: textColor,
              fontFamily: theme.typography.fontFamily,
            ),
            child: label,
          ),
        ),
      ),
    );
  }
}
