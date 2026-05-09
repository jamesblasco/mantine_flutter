import 'package:flutter/widgets.dart';
import '../../foundation/size.dart';
import '../../theme/context_extensions.dart';
import '../../utils/uncontrolled.dart';
import 'input_components.dart';

enum MantineInputVariant { default_, filled, unstyled }

class MantineTextInput extends StatefulWidget {
  const MantineTextInput({
    super.key,
    this.label,
    this.description,
    this.error,
    this.placeholder,
    this.value,
    this.defaultValue,
    this.onChanged,
    this.controller,
    this.focusNode,
    this.size = MantineSize.sm,
    this.radius,
    this.disabled = false,
    this.required = false,
    this.leftSection,
    this.rightSection,
    this.variant = MantineInputVariant.default_,
    this.inputType = TextInputType.text,
    this.obscureText = false,
    this.maxLines = 1,
    this.maxLength,
    this.autofocus = false,
    this.readOnly = false,
    this.onTap,
  });

  final String? label;
  final String? description;
  final String? error;
  final String? placeholder;
  final String? value;
  final String? defaultValue;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final MantineSize size;
  final MantineSize? radius;
  final bool disabled;
  final bool required;
  final Widget? leftSection;
  final Widget? rightSection;
  final MantineInputVariant variant;
  final TextInputType inputType;
  final bool obscureText;
  final int? maxLines;
  final int? maxLength;
  final bool autofocus;
  final bool readOnly;
  final VoidCallback? onTap;

  @override
  State<MantineTextInput> createState() => _MantineTextInputState();
}

class _MantineTextInputState extends State<MantineTextInput> {
  late final MantineUncontrolled<String> _state;
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _focused = false;
  bool _ownsController = false;
  bool _ownsFocusNode = false;

  @override
  void initState() {
    super.initState();
    _state = MantineUncontrolled<String>(
      value: widget.value,
      defaultValue: widget.defaultValue,
      finalValue: '',
      onChanged: widget.onChanged,
    );

    if (widget.controller == null) {
      _controller = TextEditingController(text: _state.currentValue);
      _ownsController = true;
    } else {
      _controller = widget.controller!;
    }
    if (widget.focusNode == null) {
      _focusNode = FocusNode();
      _ownsFocusNode = true;
    } else {
      _focusNode = widget.focusNode!;
    }
    _focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    setState(() => _focused = _focusNode.hasFocus);
  }

  @override
  void didUpdateWidget(MantineTextInput old) {
    super.didUpdateWidget(old);
    _state.update(
      value: widget.value,
      onChanged: widget.onChanged,
    );

    if (_state.value != null && _state.value != _controller.text) {
      _controller.text = _state.value!;
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    if (_ownsController) _controller.dispose();
    if (_ownsFocusNode) _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.mantineTheme;
    final isDark = context.isDarkMode;
    final hasError = widget.error != null && widget.error!.isNotEmpty;

    final fontSize = switch (widget.size) {
      MantineSize.xs => 12.0,
      MantineSize.sm => 14.0,
      MantineSize.md => 16.0,
      MantineSize.lg => 18.0,
      MantineSize.xl => 20.0,
    };

    final resolvedRadius =
        theme.radius.resolve(widget.radius ?? theme.defaultRadius);

    Color borderColor;
    if (hasError) {
      borderColor = theme.colors.resolve('red')[6];
    } else if (_focused) {
      borderColor = theme.primaryColorValue;
    } else if (widget.disabled) {
      borderColor = context.mantineBorder.withValues(alpha: 0.5);
    } else {
      borderColor = context.mantineBorder;
    }

    Color bgColor;
    if (widget.variant == MantineInputVariant.filled) {
      bgColor = isDark
          ? theme.colors.resolve('dark')[6]
          : theme.colors.resolve('gray')[0];
    } else {
      bgColor = isDark ? theme.colors.resolve('dark')[6] : theme.white;
    }

    if (widget.disabled) {
      bgColor = bgColor.withValues(alpha: 0.6);
    }

    final textStyle = TextStyle(
      fontSize: fontSize,
      color: widget.disabled
          ? context.mantineDimmedText
          : context.mantineBodyText,
      fontFamily: theme.typography.fontFamily,
      height: 1.55,
    );

    final hintStyle = textStyle.copyWith(color: context.mantineDimmedText);

    // EditableText is the pure-widgets.dart text input primitive.
    // We layer a hint Text underneath via Stack.
    Widget editableText = ValueListenableBuilder<TextEditingValue>(
      valueListenable: _controller,
      builder: (context, value, _) {
        return Stack(
          alignment: Alignment.centerLeft,
          children: [
            if (value.text.isEmpty && widget.placeholder != null)
              Text(widget.placeholder!, style: hintStyle, maxLines: 1),
            EditableText(
              controller: _controller,
              focusNode: _focusNode,
              readOnly: widget.disabled || widget.readOnly,
              style: textStyle,
              cursorColor: theme.primaryColorValue,
              backgroundCursorColor: const Color(0xFF888888),
              keyboardType: widget.inputType,
              obscureText: widget.obscureText,
              maxLines: widget.obscureText ? 1 : widget.maxLines,
              autofocus: widget.autofocus,
              onChanged: (v) {
                _state.handleChange(v);
              },
            ),
          ],
        );
      },
    );

    Widget wrapper = GestureDetector(
      onTap: widget.disabled ? null : widget.onTap,
      behavior: HitTestBehavior.opaque,
      child: DecoratedBox(
        decoration: widget.variant == MantineInputVariant.unstyled
            ? const BoxDecoration()
            : BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(resolvedRadius),
                border: Border.all(
                    color: borderColor, width: _focused ? 1.5 : 1),
              ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              if (widget.leftSection != null) ...[
                widget.leftSection!,
                const SizedBox(width: 8),
              ],
              Expanded(child: editableText),
              if (widget.rightSection != null) ...[
                const SizedBox(width: 8),
                widget.rightSection!,
              ],
            ],
          ),
        ),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label != null) ...[
          MantineInputLabel(
            label: widget.label!,
            required: widget.required,
            size: widget.size,
          ),
          const SizedBox(height: 4),
        ],
        if (widget.description != null) ...[
          MantineInputDescription(
              description: widget.description!, size: widget.size),
          const SizedBox(height: 4),
        ],
        wrapper,
        if (hasError) ...[
          const SizedBox(height: 4),
          MantineInputError(error: widget.error!, size: widget.size),
        ],
      ],
    );
  }
}
