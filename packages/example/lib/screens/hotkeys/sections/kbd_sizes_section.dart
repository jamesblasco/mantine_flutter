import 'package:flutter/widgets.dart';
import 'package:mantine/mantine.dart';

class KbdSizesSection extends StatelessWidget {
  const KbdSizesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Wrap(
      spacing: 16,
      runSpacing: 16,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        MantineKbd(size: MantineSize.xs, children: [Text('xs')]),
        MantineKbd(size: MantineSize.sm, children: [Text('sm')]),
        MantineKbd(size: MantineSize.md, children: [Text('md')]),
        MantineKbd(size: MantineSize.lg, children: [Text('lg')]),
        MantineKbd(size: MantineSize.xl, children: [Text('xl')]),
      ],
    );
  }
}
