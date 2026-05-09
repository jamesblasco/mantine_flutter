import 'package:flutter/widgets.dart';
import 'package:mantine/mantine.dart';

class CheckboxSection extends StatefulWidget {
  const CheckboxSection({super.key});

  @override
  State<CheckboxSection> createState() => _CheckboxSectionState();
}

class _CheckboxSectionState extends State<CheckboxSection> {
  bool _checked1 = false;
  bool _checked2 = true;
  bool _checked3 = false;

  @override
  Widget build(BuildContext context) {
    return MantineStack(
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
        const MantineCheckbox(
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
        const MantineCheckbox(
          checked: true,
          onChanged: null,
          label: 'Disabled',
          disabled: true,
        ),
      ],
    );
  }
}
