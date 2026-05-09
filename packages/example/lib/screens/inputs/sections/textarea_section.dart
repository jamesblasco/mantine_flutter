import 'package:flutter/widgets.dart';
import 'package:mantine/mantine.dart';

class TextareaSection extends StatefulWidget {
  const TextareaSection({super.key});

  @override
  State<TextareaSection> createState() => _TextareaSectionState();
}

class _TextareaSectionState extends State<TextareaSection> {
  String _value = '';

  @override
  Widget build(BuildContext context) {
    return MantineBox(
      maxWidth: 400,
      child: MantineStack(
        children: [
          MantineTextarea(
            label: 'Message',
            placeholder: 'Your message',
            onChanged: (v) => setState(() => _value = v),
          ),
          const MantineTextarea(
            label: 'Autosize',
            description: 'This textarea grows with content',
            placeholder: 'Type a lot of text here',
            autosize: true,
            minRows: 2,
            maxRows: 4,
          ),
          const MantineTextarea(
            label: 'Fixed rows',
            placeholder: 'I have 5 rows',
            minRows: 5,
          ),
          const MantineTextarea(
            label: 'With error',
            placeholder: 'Invalid input',
            error: 'Message is too short',
          ),
          const MantineTextarea(
            label: 'Disabled',
            placeholder: 'Cannot edit',
            disabled: true,
            value: 'I am disabled',
          ),
          if (_value.isNotEmpty)
            MantineText(
              'Value: $_value',
              size: MantineSize.sm,
              dimmed: true,
            ),
        ],
      ),
    );
  }
}
