import 'package:flutter/widgets.dart';
import 'package:mantine/mantine.dart';

class CloseButtonSection extends StatelessWidget {
  const CloseButtonSection({super.key});

  @override
  Widget build(BuildContext context) {
    return MantineStack(
      children: [
        const MantineText('Sizes', weight: FontWeight.bold),
        MantineGroup(
          children: [
            MantineCloseButton(size: MantineSize.xs, onPressed: () {}),
            MantineCloseButton(size: MantineSize.sm, onPressed: () {}),
            MantineCloseButton(size: MantineSize.md, onPressed: () {}),
            MantineCloseButton(size: MantineSize.lg, onPressed: () {}),
            MantineCloseButton(size: MantineSize.xl, onPressed: () {}),
          ],
        ),
        const MantineText('Variants', weight: FontWeight.bold),
        MantineGroup(
          children: [
            MantineCloseButton(variant: MantineButtonVariant.subtle, onPressed: () {}),
            MantineCloseButton(variant: MantineButtonVariant.filled, onPressed: () {}),
            MantineCloseButton(variant: MantineButtonVariant.outline, onPressed: () {}),
            MantineCloseButton(variant: MantineButtonVariant.light, onPressed: () {}),
            MantineCloseButton(variant: MantineButtonVariant.transparent, onPressed: () {}),
          ],
        ),
        const MantineText('Colors', weight: FontWeight.bold),
        MantineGroup(
          children: [
            MantineCloseButton(color: 'red', onPressed: () {}),
            MantineCloseButton(color: 'blue', onPressed: () {}),
            MantineCloseButton(color: 'green', onPressed: () {}),
          ],
        ),
        const MantineText('Disabled', weight: FontWeight.bold),
        MantineGroup(
          children: [
            MantineCloseButton(disabled: true, onPressed: () {}),
          ],
        ),
        const MantineText('Custom icon size', weight: FontWeight.bold),
        MantineGroup(
          children: [
            MantineCloseButton(size: MantineSize.xl, iconSize: 10, onPressed: () {}),
            MantineCloseButton(size: MantineSize.xl, iconSize: 40, onPressed: () {}),
          ],
        ),
      ],
    );
  }
}
