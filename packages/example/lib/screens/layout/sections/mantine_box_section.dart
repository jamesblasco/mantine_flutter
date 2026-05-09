import 'package:flutter/widgets.dart';
import 'package:mantine/mantine.dart';

class MantineBoxSection extends StatelessWidget {
  const MantineBoxSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.mantineTheme;

    return MantineGroup(
      wrap: true,
      align: CrossAxisAlignment.center,
      children: [
        MantineBox(
          color: theme.primaryColorScale[0],
          radiusSize: MantineSize.sm,
          paddingSize: MantineSize.md,
          child: const MantineText('Box with bg'),
        ),
        MantineBox(
          color: theme.colors.resolve('teal')[0],
          radiusSize: MantineSize.lg,
          paddingSize: MantineSize.lg,
          shadowSize: MantineSize.md,
          child: const MantineText('Box with shadow'),
        ),
        MantineBox(
          border: Border.all(color: MantineColors.gray[4]),
          radiusSize: MantineSize.sm,
          paddingSize: MantineSize.md,
          child: const MantineText('Box with border'),
        ),
      ],
    );
  }
}
