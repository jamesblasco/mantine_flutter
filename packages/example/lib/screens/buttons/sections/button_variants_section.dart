import 'package:flutter/widgets.dart';
import 'package:mantine/mantine.dart';

class ButtonVariantsSection extends StatelessWidget {
  const ButtonVariantsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return MantineGroup(
      wrap: true,
      children: [
        MantineButton(onPressed: () {}, child: const Text('Filled')),
        MantineButton(
          onPressed: () {},
          variant: MantineButtonVariant.outline,
          child: const Text('Outline'),
        ),
        MantineButton(
          onPressed: () {},
          variant: MantineButtonVariant.light,
          child: const Text('Light'),
        ),
        MantineButton(
          onPressed: () {},
          variant: MantineButtonVariant.subtle,
          child: const Text('Subtle'),
        ),
        MantineButton(
          onPressed: () {},
          variant: MantineButtonVariant.transparent,
          child: const Text('Transparent'),
        ),
        MantineButton(
          onPressed: () {},
          variant: MantineButtonVariant.white,
          child: const Text('White'),
        ),
        MantineButton(
          onPressed: () {},
          variant: MantineButtonVariant.gradient,
          child: const Text('Gradient'),
        ),
      ],
    );
  }
}
