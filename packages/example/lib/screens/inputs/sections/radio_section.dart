import 'package:flutter/widgets.dart';
import 'package:mantine/mantine.dart';

class RadioSection extends StatefulWidget {
  const RadioSection({super.key});

  @override
  State<RadioSection> createState() => _RadioSectionState();
}

class _RadioSectionState extends State<RadioSection> {
  String _value = 'react';

  @override
  Widget build(BuildContext context) {
    return MantineStack(
      spacing: MantineSize.md,
      children: [
        const MantineText(
          'Radio group',
          size: MantineSize.sm,
          weight: FontWeight.w500,
        ),
        MantineRadioGroup<String>(
          value: _value,
          onChanged: (v) => setState(() => _value = v),
          label: 'Select your favorite framework',
          description: 'This is a description',
          withAsterisk: true,
          child: const Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: MantineGroup(
              children: [
                MantineRadio(value: 'react', label: 'React'),
                MantineRadio(value: 'svelte', label: 'Svelte'),
                MantineRadio(value: 'angular', label: 'Angular'),
                MantineRadio(value: 'vue', label: 'Vue'),
              ],
            ),
          ),
        ),
        const MantineDivider(),
        const MantineText(
          'Sizes',
          size: MantineSize.sm,
          weight: FontWeight.w500,
        ),
        const MantineStack(
          spacing: MantineSize.xs,
          children: [
            MantineRadio(
              value: 'xs',
              label: 'Extra small',
              size: MantineSize.xs,
              checked: true,
            ),
            MantineRadio(
              value: 'sm',
              label: 'Small',
              size: MantineSize.sm,
              checked: true,
            ),
            MantineRadio(
              value: 'md',
              label: 'Medium',
              size: MantineSize.md,
              checked: true,
            ),
            MantineRadio(
              value: 'lg',
              label: 'Large',
              size: MantineSize.lg,
              checked: true,
            ),
            MantineRadio(
              value: 'xl',
              label: 'Extra large',
              size: MantineSize.xl,
              checked: true,
            ),
          ],
        ),
        const MantineDivider(),
        const MantineText(
          'States',
          size: MantineSize.sm,
          weight: FontWeight.w500,
        ),
        const MantineGroup(
          children: [
            MantineRadio(
              value: 'checked',
              label: 'Checked',
              checked: true,
            ),
            MantineRadio(
              value: 'unchecked',
              label: 'Unchecked',
              checked: false,
            ),
            MantineRadio(
              value: 'disabled',
              label: 'Disabled',
              disabled: true,
            ),
            MantineRadio(
              value: 'disabled-checked',
              label: 'Disabled checked',
              disabled: true,
              checked: true,
            ),
          ],
        ),
        const MantineDivider(),
        const MantineText(
          'Label position',
          size: MantineSize.sm,
          weight: FontWeight.w500,
        ),
        const MantineStack(
          spacing: MantineSize.xs,
          children: [
            MantineRadio(
              value: 'right',
              label: 'Label on the right',
              labelPosition: MantineLabelPosition.right,
            ),
            MantineRadio(
              value: 'left',
              label: 'Label on the left',
              labelPosition: MantineLabelPosition.left,
            ),
          ],
        ),
        const MantineDivider(),
        const MantineText(
          'Colors',
          size: MantineSize.sm,
          weight: FontWeight.w500,
        ),
        const MantineGroup(
          children: [
            MantineRadio(value: 'red', label: 'Red', color: 'red', checked: true),
            MantineRadio(value: 'green', label: 'Green', color: 'green', checked: true),
            MantineRadio(value: 'orange', label: 'Orange', color: 'orange', checked: true),
            MantineRadio(value: 'cyan', label: 'Cyan', color: 'cyan', checked: true),
          ],
        ),
      ],
    );
  }
}
