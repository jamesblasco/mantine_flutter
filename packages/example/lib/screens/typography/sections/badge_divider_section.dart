import 'package:flutter/widgets.dart';
import 'package:mantine/mantine.dart';

class BadgeDividerSection extends StatelessWidget {
  const BadgeDividerSection({super.key});

  @override
  Widget build(BuildContext context) {
    return MantineStack(
      children: [
        MantineGroup(
          wrap: true,
          children: [
            MantineBadge(child: const Text('Default')),
            MantineBadge(
              variant: MantineBadgeVariant.outline,
              child: const Text('Outline'),
            ),
            MantineBadge(
              variant: MantineBadgeVariant.light,
              child: const Text('Light'),
            ),
            MantineBadge(
              variant: MantineBadgeVariant.dot,
              child: const Text('With dot'),
            ),
            MantineBadge(color: 'red', child: const Text('Red')),
            MantineBadge(color: 'teal', child: const Text('Teal')),
          ],
        ),
        const MantineDivider(my: 8),
        const MantineDivider(variant: MantineDividerVariant.dashed, my: 8),
        const MantineDivider(variant: MantineDividerVariant.dotted, my: 8),
        MantineDivider(label: const Text('Section label'), my: 8),
      ],
    );
  }
}
