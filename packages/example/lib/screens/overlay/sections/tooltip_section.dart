import 'package:flutter/widgets.dart';
import 'package:mantine/mantine.dart';

class TooltipSection extends StatelessWidget {
  const TooltipSection({super.key});

  @override
  Widget build(BuildContext context) {
    return MantineStack(
      children: [
        const MantineText('Basic Tooltip'),
        MantineGroup(
          children: [
            MantineTooltip(
              label: const Text('Tooltip'),
              child: MantineButton(
                variant: MantineButtonVariant.outline,
                onPressed: () {},
                child: const Text('Button with tooltip'),
              ),
            ),
          ],
        ),
        const MantineText('Tooltip positions'),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: MantinePopoverPosition.values.map((pos) {
            return MantineTooltip(
              position: pos,
              label: Text(pos.name),
              child: MantineButton(
                size: MantineSize.xs,
                variant: MantineButtonVariant.outline,
                onPressed: () {},
                child: Text(pos.name),
              ),
            );
          }).toList(),
        ),
        const MantineText('Tooltip colors'),
        MantineGroup(
          children: [
            MantineTooltip(
              color: 'blue',
              label: const Text('Blue tooltip'),
              child: MantineButton(
                color: 'blue',
                variant: MantineButtonVariant.outline,
                onPressed: () {},
                child: const Text('Blue color'),
              ),
            ),
            MantineTooltip(
              color: 'red',
              label: const Text('Red tooltip'),
              child: MantineButton(
                color: 'red',
                variant: MantineButtonVariant.outline,
                onPressed: () {},
                child: const Text('Red color'),
              ),
            ),
          ],
        ),
        const MantineText('Multiline and width'),
        MantineGroup(
          children: [
            MantineTooltip(
              multiline: true,
              width: 200,
              label: const Text(
                'This is a multiline tooltip with custom width. It will wrap to multiple lines if the content is too long.',
              ),
              child: MantineButton(
                variant: MantineButtonVariant.outline,
                onPressed: () {},
                child: const Text('Multiline tooltip'),
              ),
            ),
          ],
        ),
        const MantineText('Tooltip with arrow'),
        MantineGroup(
          children: [
            MantineTooltip(
              withArrow: true,
              label: const Text('Tooltip with arrow'),
              child: MantineButton(
                variant: MantineButtonVariant.outline,
                onPressed: () {},
                child: const Text('With arrow'),
              ),
            ),
          ],
        ),
        const MantineText('Tooltip Group (coordinated delays)'),
        MantineTooltipGroup(
          openDelay: 500,
          closeDelay: 100,
          child: MantineGroup(
            children: [
              MantineTooltip(
                label: const Text('Tooltip 1'),
                child: MantineButton(
                  variant: MantineButtonVariant.outline,
                  onPressed: () {},
                  child: const Text('Tooltip 1'),
                ),
              ),
              MantineTooltip(
                label: const Text('Tooltip 2'),
                child: MantineButton(
                  variant: MantineButtonVariant.outline,
                  onPressed: () {},
                  child: const Text('Tooltip 2'),
                ),
              ),
              MantineTooltip(
                label: const Text('Tooltip 3'),
                child: MantineButton(
                  variant: MantineButtonVariant.outline,
                  onPressed: () {},
                  child: const Text('Tooltip 3'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
