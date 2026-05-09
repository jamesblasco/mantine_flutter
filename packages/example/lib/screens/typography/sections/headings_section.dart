import 'package:flutter/widgets.dart';
import 'package:mantine/mantine.dart';

class HeadingsSection extends StatelessWidget {
  const HeadingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return MantineStack(
      spacingValue: 4,
      children: MantineTitleOrder.values
          .map((o) => MantineTitle(
                'Heading ${o.name.toUpperCase()}',
                order: o,
              ))
          .toList(),
    );
  }
}
