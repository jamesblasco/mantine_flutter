import 'package:flutter/widgets.dart';
import 'package:mantine/mantine.dart';

class CardSection extends StatelessWidget {
  const CardSection({super.key});

  @override
  Widget build(BuildContext context) {
    return MantineGroup(
      wrap: true,
      align: CrossAxisAlignment.start,
      children: [
        MantineBox(
          maxWidth: 240,
          child: MantineCard(
            child: MantineStack(
              spacingValue: 8,
              children: [
                const MantineTitle('Card title', order: MantineTitleOrder.h5),
                const MantineText(
                  'Card content with some description text.',
                  dimmed: true,
                ),
                MantineButton(
                  onPressed: () {},
                  size: MantineSize.xs,
                  child: const Text('Action'),
                ),
              ],
            ),
          ),
        ),
        MantineBox(
          maxWidth: 240,
          child: const MantineCard(
            withBorder: true,
            shadow: MantineSize.xs,
            child: MantineStack(
              spacingValue: 8,
              children: [
                MantineTitle('With border', order: MantineTitleOrder.h5),
                MantineText('Border + minimal shadow.', dimmed: true),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
