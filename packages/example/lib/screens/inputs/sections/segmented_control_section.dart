import 'package:flutter/widgets.dart';
import 'package:mantine/mantine.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SegmentedControlSection extends StatefulWidget {
  const SegmentedControlSection({super.key});

  @override
  State<SegmentedControlSection> createState() => _SegmentedControlSectionState();
}

class _SegmentedControlSectionState extends State<SegmentedControlSection> {
  String _controlledValue = 'react';

  @override
  Widget build(BuildContext context) {
    return MantineStack(
      spacingValue: 20,
      children: [
        _DemoGroup(
          label: 'Default',
          child: MantineSegmentedControl<String>(
            data: const [
              MantineSegmentedControlItem(label: Text('React'), value: 'react'),
              MantineSegmentedControlItem(label: Text('Angular'), value: 'ng'),
              MantineSegmentedControlItem(label: Text('Vue'), value: 'vue'),
              MantineSegmentedControlItem(label: Text('Svelte'), value: 'svelte'),
            ],
          ),
        ),
        _DemoGroup(
          label: 'Controlled',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MantineSegmentedControl<String>(
                value: _controlledValue,
                onChanged: (val) => setState(() => _controlledValue = val),
                data: const [
                  MantineSegmentedControlItem(label: Text('React'), value: 'react'),
                  MantineSegmentedControlItem(label: Text('Angular'), value: 'ng'),
                  MantineSegmentedControlItem(label: Text('Vue'), value: 'vue'),
                ],
              ),
              const SizedBox(height: 8),
              MantineText('Value: $_controlledValue', size: MantineSize.sm),
            ],
          ),
        ),
        _DemoGroup(
          label: 'Full width',
          child: MantineSegmentedControl<String>(
            fullWidth: true,
            data: const [
              MantineSegmentedControlItem(label: Text('React'), value: 'react'),
              MantineSegmentedControlItem(label: Text('Angular'), value: 'ng'),
              MantineSegmentedControlItem(label: Text('Vue'), value: 'vue'),
            ],
          ),
        ),
        _DemoGroup(
          label: 'Vertical',
          child: SizedBox(
            width: 200,
            child: MantineSegmentedControl<String>(
              orientation: MantineSegmentedControlOrientation.vertical,
              data: const [
                MantineSegmentedControlItem(label: Text('React'), value: 'react'),
                MantineSegmentedControlItem(label: Text('Angular'), value: 'ng'),
                MantineSegmentedControlItem(label: Text('Vue'), value: 'vue'),
              ],
            ),
          ),
        ),
        _DemoGroup(
          label: 'Custom Color',
          child: MantineSegmentedControl<String>(
            color: 'orange',
            data: const [
              MantineSegmentedControlItem(label: Text('React'), value: 'react'),
              MantineSegmentedControlItem(label: Text('Angular'), value: 'ng'),
              MantineSegmentedControlItem(label: Text('Vue'), value: 'vue'),
            ],
          ),
        ),
        _DemoGroup(
          label: 'With Icons',
          child: MantineSegmentedControl<String>(
            data: [
              MantineSegmentedControlItem(
                label: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    PhosphorIcon(PhosphorIcons.eye(), size: 16),
                    const SizedBox(width: 8),
                    const Text('Preview'),
                  ],
                ),
                value: 'preview',
              ),
              MantineSegmentedControlItem(
                label: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    PhosphorIcon(PhosphorIcons.code(), size: 16),
                    const SizedBox(width: 8),
                    const Text('Code'),
                  ],
                ),
                value: 'code',
              ),
              MantineSegmentedControlItem(
                label: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    PhosphorIcon(PhosphorIcons.export(), size: 16),
                    const SizedBox(width: 8),
                    const Text('Export'),
                  ],
                ),
                value: 'export',
              ),
            ],
          ),
        ),
        _DemoGroup(
          label: 'Sizes',
          child: MantineStack(
            spacingValue: 12,
            children: MantineSize.values.map((size) {
              return MantineSegmentedControl<String>(
                size: size,
                data: const [
                  MantineSegmentedControlItem(label: Text('React'), value: 'react'),
                  MantineSegmentedControlItem(label: Text('Angular'), value: 'ng'),
                  MantineSegmentedControlItem(label: Text('Vue'), value: 'vue'),
                ],
              );
            }).toList(),
          ),
        ),
        _DemoGroup(
          label: 'Disabled',
          child: MantineStack(
            spacingValue: 12,
            children: [
              MantineSegmentedControl<String>(
                disabled: true,
                data: const [
                  MantineSegmentedControlItem(label: Text('React'), value: 'react'),
                  MantineSegmentedControlItem(label: Text('Angular'), value: 'ng'),
                  MantineSegmentedControlItem(label: Text('Vue'), value: 'vue'),
                ],
              ),
              MantineSegmentedControl<String>(
                data: const [
                  MantineSegmentedControlItem(label: Text('React'), value: 'react', disabled: true),
                  MantineSegmentedControlItem(label: Text('Angular'), value: 'ng'),
                  MantineSegmentedControlItem(label: Text('Vue'), value: 'vue'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DemoGroup extends StatelessWidget {
  const _DemoGroup({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MantineText(label, size: MantineSize.sm, weight: FontWeight.w500),
        const SizedBox(height: 8),
        child,
      ],
    );
  }
}
