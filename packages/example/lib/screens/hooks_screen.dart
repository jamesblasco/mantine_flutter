import 'package:flutter/widgets.dart';
import 'package:mantine/mantine.dart';
import '../utils/storage_backend.dart';
import 'shared.dart';

class HooksScreen extends StatefulWidget {
  const HooksScreen({super.key});

  @override
  State<HooksScreen> createState() => _HooksScreenState();
}

class _HooksScreenState extends State<HooksScreen> {
  late final MantineLocalStorage<String> _textStorage;
  late final MantineLocalStorage<int> _counterStorage;
  late final MantineLocalStorage<bool> _boolStorage;

  @override
  void initState() {
    super.initState();
    const backend = SharedPreferencesBackend();
    _textStorage = MantineLocalStorage<String>(
      key: 'demo-text',
      defaultValue: '',
      backend: backend,
    );
    _counterStorage = MantineLocalStorage<int>(
      key: 'demo-counter',
      defaultValue: 0,
      backend: backend,
    );
    _boolStorage = MantineLocalStorage<bool>(
      key: 'demo-bool',
      defaultValue: false,
      backend: backend,
    );
  }

  @override
  void dispose() {
    _textStorage.dispose();
    _counterStorage.dispose();
    _boolStorage.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GalleryScreen(
      title: 'Hooks & Utils',
      sections: [
        GallerySection(
          title: 'MantineLocalStorage',
          child: MantineStack(
            children: [
              const MantineText(
                'Values persisted to SharedPreferences. Try changing them and reloading the app.',
                dimmed: true,
                size: MantineSize.sm,
              ),
              const SizedBox(height: 10),

              // Text Storage
              ValueListenableBuilder(
                valueListenable: _textStorage,
                builder: (context, value, _) {
                  return MantineTextInput(
                    label: 'Stored Text',
                    value: value,
                    onChanged: (v) => _textStorage.value = v,
                    placeholder: 'Type something to persist...',
                  );
                },
              ),

              // Counter Storage
              ValueListenableBuilder(
                valueListenable: _counterStorage,
                builder: (context, value, _) {
                  return GallerySection(
                    title: 'Stored Counter',
                    child: MantineGroup(
                      children: [
                        MantineText('Count: $value'),
                        MantineButton(
                          onPressed: () => _counterStorage.value++,
                          child: const Text('Increment'),
                        ),
                        MantineButton(
                          onPressed: () => _counterStorage.value = 0,
                          variant: MantineButtonVariant.outline,
                          child: const Text('Reset'),
                        ),
                      ],
                    ),
                  );
                },
              ),

              // Bool Storage
              ValueListenableBuilder(
                valueListenable: _boolStorage,
                builder: (context, value, _) {
                  return MantineSwitch(
                    label: 'Stored Switch',
                    checked: value,
                    onChanged: (v) => _boolStorage.value = v,
                  );
                },
              ),

              const MantineDivider(),

              GallerySection(
                title: 'MantineUncontrolled',
                child: MantineStack(
                  children: [
                    const MantineText(
                      'Components can be used in controlled (state managed by parent) or uncontrolled (state managed internally) mode.',
                      dimmed: true,
                      size: MantineSize.sm,
                    ),
                    const SizedBox(height: 10),
                    const MantineText('Uncontrolled components:',
                        weight: FontWeight.bold),
                    const MantineTextInput(
                      label: 'Uncontrolled text input',
                      placeholder: 'Type something (internal state)',
                      defaultValue: 'Initial value',
                    ),
                    const MantineCheckbox(
                      label: 'Uncontrolled checkbox',
                      defaultChecked: true,
                    ),
                    const MantineSwitch(
                      label: 'Uncontrolled switch',
                      defaultChecked: true,
                    ),
                    const SizedBox(height: 10),
                    const MantineText('Controlled components:',
                        weight: FontWeight.bold),
                    const _ControlledDemo(),
                  ],
                ),
              ),

              const MantineDivider(),
              const MantineText('Size variants (visual check):'),
              MantineGroup(
                align: CrossAxisAlignment.center,
                children: MantineSize.values.map((s) {
                  return MantineButton(
                    size: s,
                    child: Text(s.name.toUpperCase()),
                    onPressed: () {},
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ControlledDemo extends StatefulWidget {
  const _ControlledDemo();

  @override
  State<_ControlledDemo> createState() => _ControlledDemoState();
}

class _ControlledDemoState extends State<_ControlledDemo> {
  String _value = '';
  bool _checked = false;

  @override
  Widget build(BuildContext context) {
    return MantineStack(
      children: [
        MantineTextInput(
          label: 'Controlled text input',
          value: _value,
          onChanged: (v) => setState(() => _value = v),
        ),
        MantineText('Value: $_value', size: MantineSize.xs, dimmed: true),
        MantineCheckbox(
          label: 'Controlled checkbox',
          checked: _checked,
          onChanged: (v) => setState(() => _checked = v),
        ),
        MantineSwitch(
          label: 'Controlled switch',
          checked: _checked,
          onChanged: (v) => setState(() => _checked = v),
        ),
        MantineText('Checked: $_checked', size: MantineSize.xs, dimmed: true),
      ],
    );
  }
}
