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
  final _counter = MantineCounter(0, min: 0, max: 10);
  final _debounced = MantineDebounced<String>('', delay: const Duration(milliseconds: 500));

  @override
  void dispose() {
    _counter.dispose();
    _debounced.dispose();
    super.dispose();
  }

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
        GallerySection(
          title: 'Counter (MantineCounter)',
          child: ValueListenableBuilder(
            valueListenable: _counter,
            builder: (context, value, _) {
              return MantineStack(
                align: CrossAxisAlignment.start,
                children: [
                  MantineText('Count: $value (min: 0, max: 10)'),
                  MantineGroup(
                    children: [
                      MantineButton(
                        onPressed: _counter.decrement,
                        child: const Text('-'),
                      ),
                      MantineButton(
                        onPressed: _counter.increment,
                        child: const Text('+'),
                      ),
                      MantineButton(
                        onPressed: _counter.reset,
                        variant: MantineButtonVariant.outline,
                        child: const Text('Reset'),
                      ),
                      MantineButton(
                        onPressed: () => _counter.set(5),
                        variant: MantineButtonVariant.outline,
                        child: const Text('Set to 5'),
                      ),
                    ],
                  ),
                  const MantineText('Different sizes:'),
                  ...MantineSize.values.map((s) => MantineGroup(
                        children: [
                          MantineButton(
                            onPressed: _counter.decrement,
                            size: s,
                            child: const Text('-'),
                          ),
                          MantineText('$value', size: s),
                          MantineButton(
                            onPressed: _counter.increment,
                            size: s,
                            child: const Text('+'),
                          ),
                        ],
                      )),
                ],
              );
            },
          ),
        ),
        GallerySection(
          title: 'Debounced (MantineDebounced)',
          child: MantineStack(
            align: CrossAxisAlignment.start,
            children: [
              MantineBox(
                maxWidth: 400,
                child: MantineTextInput(
                  label: 'Debounced input',
                  placeholder: 'Type something...',
                  onChanged: _debounced.set,
                ),
              ),
              ValueListenableBuilder(
                valueListenable: _debounced,
                builder: (context, value, _) {
                  return MantineStack(
                    align: CrossAxisAlignment.start,
                    children: [
                      MantineText('Debounced value: $value', weight: FontWeight.bold),
                      const MantineText('Different sizes:'),
                      ...MantineSize.values.map((s) => MantineText(
                            value.isEmpty ? 'Size ${s.name}' : value,
                            size: s,
                          )),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
