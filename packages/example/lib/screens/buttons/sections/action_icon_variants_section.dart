import 'package:flutter/widgets.dart';
import 'package:mantine/mantine.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ActionIconVariantsSection extends StatelessWidget {
  const ActionIconVariantsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return MantineGroup(
      wrap: true,
      children: [
        MantineActionIcon(
          onPressed: () {},
          child: PhosphorIcon(PhosphorIcons.heart()),
        ),
        MantineActionIcon(
          onPressed: () {},
          variant: MantineButtonVariant.outline,
          child: PhosphorIcon(PhosphorIcons.heart()),
        ),
        MantineActionIcon(
          onPressed: () {},
          variant: MantineButtonVariant.light,
          child: PhosphorIcon(PhosphorIcons.heart()),
        ),
        MantineActionIcon(
          onPressed: () {},
          variant: MantineButtonVariant.subtle,
          child: PhosphorIcon(PhosphorIcons.heart()),
        ),
        MantineActionIcon(
          onPressed: () {},
          variant: MantineButtonVariant.transparent,
          child: PhosphorIcon(PhosphorIcons.heart()),
        ),
        MantineActionIcon(
          onPressed: () {},
          variant: MantineButtonVariant.white,
          child: PhosphorIcon(PhosphorIcons.heart()),
        ),
        MantineActionIcon(
          onPressed: () {},
          variant: MantineButtonVariant.gradient,
          child: PhosphorIcon(PhosphorIcons.heart()),
        ),
      ],
    );
  }
}
