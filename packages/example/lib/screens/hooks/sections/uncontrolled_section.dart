import 'package:flutter/widgets.dart';
import 'package:mantine/mantine.dart';

class UncontrolledSection extends StatelessWidget {
  const UncontrolledSection({super.key});

  @override
  Widget build(BuildContext context) {
    return MantineStack(
      children: const [
        MantineText(
          'Components can be used in controlled (state managed by parent) or uncontrolled (state managed internally) mode.',
          dimmed: true,
          size: MantineSize.sm,
        ),
        SizedBox(height: 10),
        MantineText('Uncontrolled components:', weight: FontWeight.bold),
        MantineTextInput(
          label: 'Uncontrolled text input',
          placeholder: 'Type something (internal state)',
          defaultValue: 'Initial value',
        ),
        MantineCheckbox(
          label: 'Uncontrolled checkbox',
          defaultChecked: true,
        ),
        MantineSwitch(
          label: 'Uncontrolled switch',
          defaultChecked: true,
        ),
        SizedBox(height: 10),
        MantineText('Controlled components:', weight: FontWeight.bold),
        _ControlledDemo(),
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
