import 'package:flutter/widgets.dart';
import 'package:mantine/mantine.dart';

class TextInputSection extends StatefulWidget {
  const TextInputSection({super.key});

  @override
  State<TextInputSection> createState() => _TextInputSectionState();
}

class _TextInputSectionState extends State<TextInputSection> {
  String _inputValue = '';

  @override
  Widget build(BuildContext context) {
    return MantineBox(
      maxWidth: 400,
      child: MantineStack(
        children: [
          MantineTextInput(
            label: 'Your name',
            placeholder: 'Enter your name',
            onChanged: (v) => setState(() => _inputValue = v),
          ),
          const MantineTextInput(
            label: 'Email',
            description: 'We will never share your email.',
            placeholder: 'hello@example.com',
            inputType: TextInputType.emailAddress,
            required: true,
          ),
          const MantineTextInput(
            label: 'With error',
            placeholder: 'Enter value',
            error: 'This field is required',
            value: '',
          ),
          const MantineTextInput(
            label: 'Disabled',
            placeholder: 'Cannot edit',
            value: 'Disabled value',
            disabled: true,
          ),
          const MantineTextInput(
            label: 'Filled variant',
            placeholder: 'Filled background',
            variant: MantineInputVariant.filled,
          ),
          if (_inputValue.isNotEmpty)
            MantineText(
              'Value: $_inputValue',
              size: MantineSize.sm,
              dimmed: true,
            ),
        ],
      ),
    );
  }
}
