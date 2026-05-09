import 'package:flutter/widgets.dart';
import '../../foundation/size.dart';
import '../../theme/context_extensions.dart';

enum MantineInputVariant { default_, filled, unstyled }

class MantineTextInput extends StatefulWidget {
  const MantineTextInput({
    super.key,
    this.label,
    this.description,
    this.error,
    this.placeholder,
    this.value,
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
  });

  final String? label;
  final String? description;
  final String? error;
  final String? placeholder;
  final String? value;
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

  @override
  State<MantineTextInput> createState() => _MantineTextInputState();
}

class _MantineTextInputState extends State<MantineTextInput> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _focused = false;
  bool _ownsController = false;
  bool _ownsFocusNode = false;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _controller = TextEditingController(text: widget.value);
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
    if (widget.value != null && widget.value != _controller.text) {
      _controller.text = widget.value!;
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
              readOnly: widget.disabled,
              style: textStyle,
              cursorColor: theme.primaryColorValue,
              backgroundCursorColor: const Color(0xFF888888),
              keyboardType: widget.inputType,
              obscureText: widget.obscureText,
              maxLines: widget.obscureText ? 1 : widget.maxLines,
              autofocus: widget.autofocus,
              onChanged: widget.onChanged,
            ),
          ],
        );
      },
    );

    Widget wrapper = DecoratedBox(
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
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label != null) ...[
          _InputLabel(
            label: widget.label!,
            required: widget.required,
            size: widget.size,
          ),
          const SizedBox(height: 4),
        ],
        if (widget.description != null) ...[
          _InputDescription(
              description: widget.description!, size: widget.size),
          const SizedBox(height: 4),
        ],
        wrapper,
        if (hasError) ...[
          const SizedBox(height: 4),
          _InputError(error: widget.error!, size: widget.size),
        ],
      ],
    );
  }
}

class _InputLabel extends StatelessWidget {
  const _InputLabel({
    required this.label,
    required this.required,
    required this.size,
  });

  final String label;
  final bool required;
  final MantineSize size;

  @override
  Widget build(BuildContext context) {
    final theme = context.mantineTheme;
    final fontSize = switch (size) {
      MantineSize.xs => 11.0,
      MantineSize.sm => 13.0,
      MantineSize.md => 14.0,
      MantineSize.lg => 16.0,
      MantineSize.xl => 18.0,
    };

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w500,
            color: context.mantineBodyText,
            fontFamily: theme.typography.fontFamily,
          ),
        ),
        if (required)
          Text(
            ' *',
            style: TextStyle(
              fontSize: fontSize,
              color: theme.colors.resolve('red')[6],
              fontFamily: theme.typography.fontFamily,
            ),
          ),
      ],
    );
  }
}

class _InputDescription extends StatelessWidget {
  const _InputDescription(
      {required this.description, required this.size});

  final String description;
  final MantineSize size;

  @override
  Widget build(BuildContext context) {
    final theme = context.mantineTheme;
    final fontSize = switch (size) {
      MantineSize.xs => 10.0,
      MantineSize.sm => 11.0,
      MantineSize.md => 12.0,
      MantineSize.lg => 13.0,
      MantineSize.xl => 14.0,
    };

    return Text(
      description,
      style: TextStyle(
        fontSize: fontSize,
        color: context.mantineDimmedText,
        fontFamily: theme.typography.fontFamily,
      ),
    );
  }
}

class _InputError extends StatelessWidget {
  const _InputError({required this.error, required this.size});

  final String error;
  final MantineSize size;

  @override
  Widget build(BuildContext context) {
    final theme = context.mantineTheme;
    final fontSize = switch (size) {
      MantineSize.xs => 10.0,
      MantineSize.sm => 11.0,
      MantineSize.md => 12.0,
      MantineSize.lg => 13.0,
      MantineSize.xl => 14.0,
    };

    return Text(
      error,
      style: TextStyle(
        fontSize: fontSize,
        color: theme.colors.resolve('red')[6],
        fontFamily: theme.typography.fontFamily,
      ),
    );
  }
}
