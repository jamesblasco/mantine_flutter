import 'package:flutter/widgets.dart';
import 'package:mantine/mantine.dart';
import 'shared.dart';

class InputsScreen extends StatefulWidget {
  const InputsScreen({super.key});

  @override
  State<InputsScreen> createState() => _InputsScreenState();
}

class _InputsScreenState extends State<InputsScreen> {
  bool _checked1 = false;
  bool _checked2 = true;
  bool _checked3 = false;
  bool _switch1 = false;
  bool _switch2 = true;
  String _inputValue = '';

  @override
  Widget build(BuildContext context) {
    return GalleryScreen(
      title: 'Inputs',
      sections: [
        GallerySection(
          title: 'TextInput',
          child: MantineBox(
            maxWidth: 400,
            child: MantineStack(
              children: [
                MantineTextInput(
                  label: 'Your name',
                  placeholder: 'Enter your name',
                  onChanged: (v) => setState(() => _inputValue = v),
                ),
                MantineTextInput(
                  label: 'Email',
                  description: 'We will never share your email.',
                  placeholder: 'hello@example.com',
                  inputType: TextInputType.emailAddress,
                  required: true,
                ),
                MantineTextInput(
                  label: 'With error',
                  placeholder: 'Enter value',
                  error: 'This field is required',
                  value: '',
                ),
                MantineTextInput(
                  label: 'Disabled',
                  placeholder: 'Cannot edit',
                  value: 'Disabled value',
                  disabled: true,
                ),
                MantineTextInput(
                  label: 'Filled variant',
                  placeholder: 'Filled background',
                  variant: MantineInputVariant.filled,
                ),
                if (_inputValue.isNotEmpty)
                  MantineText('Value: $_inputValue', size: MantineSize.sm,
                      dimmed: true),
              ],
            ),
          ),
        ),
        GallerySection(
          title: 'Checkbox',
          child: MantineStack(
            spacingValue: 10,
            align: CrossAxisAlignment.start,
            children: [
              MantineCheckbox(
                checked: _checked1,
                onChanged: (v) => setState(() => _checked1 = v),
                label: 'Unchecked by default',
              ),
              MantineCheckbox(
                checked: _checked2,
                onChanged: (v) => setState(() => _checked2 = v),
                label: 'Checked by default',
                description: 'With a description below',
              ),
              MantineCheckbox(
                checked: true,
                onChanged: null,
                label: 'Indeterminate',
                indeterminate: true,
              ),
              MantineCheckbox(
                checked: _checked3,
                onChanged: (v) => setState(() => _checked3 = v),
                label: 'Custom color',
                color: 'teal',
              ),
              MantineCheckbox(
                checked: true,
                onChanged: null,
                label: 'Disabled',
                disabled: true,
              ),
            ],
          ),
        ),
        GallerySection(
          title: 'Switch',
          child: MantineStack(
            spacingValue: 12,
            align: CrossAxisAlignment.start,
            children: [
              MantineSwitch(
                checked: _switch1,
                onChanged: (v) => setState(() => _switch1 = v),
                label: 'Off by default',
              ),
              MantineSwitch(
                checked: _switch2,
                onChanged: (v) => setState(() => _switch2 = v),
                label: 'On by default',
                description: 'With a description',
              ),
              MantineSwitch(
                checked: true,
                onChanged: null,
                label: 'Disabled',
                disabled: true,
              ),
              MantineSwitch(
                checked: _switch1,
                onChanged: (v) => setState(() => _switch1 = v),
                label: 'Custom color',
                color: 'teal',
              ),
              ...MantineSize.values.map((s) => MantineSwitch(
                    checked: _switch2,
                    onChanged: (v) => setState(() => _switch2 = v),
                    label: 'Size ${s.name}',
                    size: s,
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
