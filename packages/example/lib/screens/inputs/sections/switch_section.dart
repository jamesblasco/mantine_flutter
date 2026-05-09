import 'package:flutter/widgets.dart';
import 'package:mantine/mantine.dart';

class SwitchSection extends StatefulWidget {
  const SwitchSection({super.key});

  @override
  State<SwitchSection> createState() => _SwitchSectionState();
}

class _SwitchSectionState extends State<SwitchSection> {
  bool _switch1 = false;
  bool _switch2 = true;

  @override
  Widget build(BuildContext context) {
    return MantineStack(
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
        const MantineSwitch(
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
    );
  }
}
