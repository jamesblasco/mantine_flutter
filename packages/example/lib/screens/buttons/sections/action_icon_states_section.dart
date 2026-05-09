import 'package:flutter/widgets.dart';
import 'package:mantine/mantine.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ActionIconStatesSection extends StatelessWidget {
  const ActionIconStatesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return MantineGroup(
      wrap: true,
      align: CrossAxisAlignment.center,
      children: [
        MantineActionIcon(
          onPressed: () {},
          child: PhosphorIcon(PhosphorIcons.heart()),
        ),
        MantineActionIcon(
          onPressed: () {},
          loading: true,
          child: PhosphorIcon(PhosphorIcons.heart()),
        ),
        MantineActionIcon(
          onPressed: null,
          child: PhosphorIcon(PhosphorIcons.heart()),
        ),
        MantineActionIcon(
          onPressed: () {},
          disabled: true,
          child: PhosphorIcon(PhosphorIcons.heart()),
        ),
      ],
    );
  }
}
