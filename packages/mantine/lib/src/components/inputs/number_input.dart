import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import '../../foundation/size.dart';
import '../../theme/context_extensions.dart';
import '../../utils/uncontrolled.dart';
import 'text_input.dart';

class MantineNumberInput extends StatefulWidget {
  const MantineNumberInput({
    super.key,
    this.label,
    this.description,
    this.error,
    this.placeholder,
    this.value,
    this.defaultValue,
    this.onChanged,
    this.min,
    this.max,
    this.step = 1,
    this.decimalScale,
    this.clampBehavior = 'blur', // 'strict' | 'blur' | 'none'
    this.size = MantineSize.sm,
    this.radius,
    this.disabled = false,
    this.required = false,
    this.variant = MantineInputVariant.default_,
    this.allowNegative = true,
    this.allowDecimal = true,
  });

  final String? label;
  final String? description;
  final String? error;
  final String? placeholder;
  final double? value;
  final double? defaultValue;
  final ValueChanged<double?>? onChanged;
  final double? min;
  final double? max;
  final double step;
  final int? decimalScale;
  final String clampBehavior;
  final MantineSize size;
  final MantineSize? radius;
  final bool disabled;
  final bool required;
  final MantineInputVariant variant;
  final bool allowNegative;
  final bool allowDecimal;

  @override
  State<MantineNumberInput> createState() => _MantineNumberInputState();
}

class _MantineNumberInputState extends State<MantineNumberInput> {
  late final MantineUncontrolled<double?> _state;
  late final TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _state = MantineUncontrolled<double?>(
      value: widget.value,
      defaultValue: widget.defaultValue,
      finalValue: null,
      onChanged: widget.onChanged,
    );
    _controller = TextEditingController(text: _formatValue(_state.currentValue));
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void didUpdateWidget(MantineNumberInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    _state.update(value: widget.value, onChanged: widget.onChanged);
    if (widget.value != null && widget.value != _parseValue(_controller.text)) {
      _controller.text = _formatValue(widget.value);
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    if (!_focusNode.hasFocus && widget.clampBehavior == 'blur') {
      _clampAndFormat();
    }
  }

  void _clampAndFormat() {
    final current = _parseValue(_controller.text);
    if (current != null) {
      final clamped = _clampValue(current);
      if (clamped != current || _controller.text != _formatValue(clamped)) {
        _updateValue(clamped);
      }
    }
  }

  double _clampValue(double val) {
    if (widget.min != null && val < widget.min!) return widget.min!;
    if (widget.max != null && val > widget.max!) return widget.max!;
    return val;
  }

  double? _parseValue(String text) {
    if (text.isEmpty) return null;
    return double.tryParse(text);
  }

  String _formatValue(double? val) {
    if (val == null) return '';
    if (widget.decimalScale != null) {
      return val.toStringAsFixed(widget.decimalScale!);
    }
    // Remove trailing zeros if it's an integer
    if (val == val.toInt().toDouble()) {
      return val.toInt().toString();
    }
    return val.toString();
  }

  void _updateValue(double? newValue) {
    final clamped = newValue != null ? _clampValue(newValue) : null;
    final formatted = _formatValue(clamped);
    _controller.text = formatted;
    _state.handleChange(clamped);
    setState(() {});
  }

  void _increment() {
    if (widget.disabled) return;
    final current = _parseValue(_controller.text) ?? 0;
    _updateValue(current + widget.step);
  }

  void _decrement() {
    if (widget.disabled) return;
    final current = _parseValue(_controller.text) ?? 0;
    _updateValue(current - widget.step);
  }

  void _onChanged(String text) {
    final val = _parseValue(text);
    if (widget.clampBehavior == 'strict' && val != null) {
      final clamped = _clampValue(val);
      if (clamped != val) {
        _updateValue(clamped);
        return;
      }
    }
    _state.handleChange(val);
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: _focusNode,
      onKeyEvent: (event) {
        if (event is KeyDownEvent) {
          if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
            _increment();
          } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
            _decrement();
          }
        }
      },
      child: MantineTextInput(
        label: widget.label,
        description: widget.description,
        error: widget.error,
        placeholder: widget.placeholder,
        controller: _controller,
        onChanged: _onChanged,
        focusNode: _focusNode,
        size: widget.size,
        radius: widget.radius,
        disabled: widget.disabled,
        required: widget.required,
        variant: widget.variant,
        inputType: TextInputType.numberWithOptions(
          decimal: widget.allowDecimal,
          signed: widget.allowNegative,
        ),
        rightSection: _Stepper(
          size: widget.size,
          disabled: widget.disabled,
          onIncrement: _increment,
          onDecrement: _decrement,
        ),
      ),
    );
  }
}

class _Stepper extends StatelessWidget {
  const _Stepper({
    required this.size,
    required this.disabled,
    required this.onIncrement,
    required this.onDecrement,
  });

  final MantineSize size;
  final bool disabled;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  @override
  Widget build(BuildContext context) {
    final iconSize = switch (size) {
      MantineSize.xs => 10.0,
      MantineSize.sm => 12.0,
      MantineSize.md => 14.0,
      MantineSize.lg => 16.0,
      MantineSize.xl => 18.0,
    };

    final buttonSize = switch (size) {
      MantineSize.xs => 12.0,
      MantineSize.sm => 14.0,
      MantineSize.md => 16.0,
      MantineSize.lg => 18.0,
      MantineSize.xl => 20.0,
    };

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _StepperButton(
          icon: _ChevronUp(size: iconSize),
          onPressed: onIncrement,
          disabled: disabled,
          size: buttonSize,
        ),
        _StepperButton(
          icon: _ChevronDown(size: iconSize),
          onPressed: onDecrement,
          disabled: disabled,
          size: buttonSize,
        ),
      ],
    );
  }
}

class _StepperButton extends StatelessWidget {
  const _StepperButton({
    required this.icon,
    required this.onPressed,
    required this.disabled,
    required this.size,
  });

  final Widget icon;
  final VoidCallback onPressed;
  final bool disabled;
  final double size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: disabled ? null : onPressed,
      child: MouseRegion(
        cursor: disabled ? SystemMouseCursors.basic : SystemMouseCursors.click,
        child: SizedBox(
          width: size * 1.5,
          height: size,
          child: Center(child: icon),
        ),
      ),
    );
  }
}

class _ChevronUp extends StatelessWidget {
  const _ChevronUp({required this.size});
  final double size;

  @override
  Widget build(BuildContext context) {
    final color = context.mantineDimmedText;
    return CustomPaint(
      size: Size(size, size * 0.6),
      painter: _ChevronPainter(color: color, up: true),
    );
  }
}

class _ChevronDown extends StatelessWidget {
  const _ChevronDown({required this.size});
  final double size;

  @override
  Widget build(BuildContext context) {
    final color = context.mantineDimmedText;
    return CustomPaint(
      size: Size(size, size * 0.6),
      painter: _ChevronPainter(color: color, up: false),
    );
  }
}

class _ChevronPainter extends CustomPainter {
  _ChevronPainter({required this.color, required this.up});
  final Color color;
  final bool up;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final path = Path();
    if (up) {
      path.moveTo(0, size.height);
      path.lineTo(size.width / 2, 0);
      path.lineTo(size.width, size.height);
    } else {
      path.moveTo(0, 0);
      path.lineTo(size.width / 2, size.height);
      path.lineTo(size.width, 0);
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
