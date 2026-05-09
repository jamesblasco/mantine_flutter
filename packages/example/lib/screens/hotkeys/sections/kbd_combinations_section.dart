import 'package:flutter/widgets.dart';
import 'package:mantine/mantine.dart';

class KbdCombinationsSection extends StatelessWidget {
  const KbdCombinationsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        MantineKbd(children: [Text('Shift')]),
        SizedBox(width: 4),
        MantineText('+'),
        SizedBox(width: 4),
        MantineKbd(children: [Text('Alt')]),
        SizedBox(width: 4),
        MantineText('+'),
        SizedBox(width: 4),
        MantineKbd(children: [Text('Enter')]),
      ],
    );
  }
}
