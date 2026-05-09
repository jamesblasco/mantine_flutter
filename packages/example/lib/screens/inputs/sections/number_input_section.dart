import 'package:flutter/widgets.dart';
import 'package:mantine/mantine.dart';

class NumberInputSection extends StatefulWidget {
  const NumberInputSection({super.key});

  @override
  State<NumberInputSection> createState() => _NumberInputSectionState();
}

class _NumberInputSectionState extends State<NumberInputSection> {
  double? _value1 = 0;
  double? _value2 = 10;
  double? _value3 = 0.5;

  @override
  Widget build(BuildContext context) {
    return MantineBox(
      maxWidth: 400,
      child: MantineStack(
        children: [
          MantineNumberInput(
            label: 'Basic number input',
            placeholder: 'Enter a number',
            value: _value1,
            onChanged: (v) => setState(() => _value1 = v),
          ),
          MantineNumberInput(
            label: 'With min/max and step',
            description: 'Min: 0, Max: 100, Step: 10',
            min: 0,
            max: 100,
            step: 10,
            value: _value2,
            onChanged: (v) => setState(() => _value2 = v),
          ),
          MantineNumberInput(
            label: 'With decimal scale',
            description: 'Decimal scale: 2, Step: 0.01',
            decimalScale: 2,
            step: 0.01,
            value: _value3,
            onChanged: (v) => setState(() => _value3 = v),
          ),
          const MantineNumberInput(
            label: 'Strict clamp behavior',
            description: 'Min: 0, Max: 10, clamped immediately',
            min: 0,
            max: 10,
            clampBehavior: 'strict',
          ),
          const MantineNumberInput(
            label: 'Disabled',
            disabled: true,
            defaultValue: 42,
          ),
          const MantineNumberInput(
            label: 'Filled variant',
            variant: MantineInputVariant.filled,
          ),
          MantineStack(
            spacingValue: 10,
            children: [
              const MantineText('Sizes:', size: MantineSize.xs, dimmed: true),
              const MantineNumberInput(size: MantineSize.xs, placeholder: 'xs size'),
              const MantineNumberInput(size: MantineSize.sm, placeholder: 'sm size'),
              const MantineNumberInput(size: MantineSize.md, placeholder: 'md size'),
              const MantineNumberInput(size: MantineSize.lg, placeholder: 'lg size'),
              const MantineNumberInput(size: MantineSize.xl, placeholder: 'xl size'),
            ],
          ),
        ],
      ),
    );
  }
}
