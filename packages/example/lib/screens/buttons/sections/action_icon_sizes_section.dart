import 'package:flutter/widgets.dart';
import 'package:mantine/mantine.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ActionIconSizesSection extends StatelessWidget {
  const ActionIconSizesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return MantineGroup(
      wrap: true,
      align: CrossAxisAlignment.center,
      children: MantineSize.values
          .map((s) => MantineActionIcon(
                onPressed: () {},
                size: s,
                child: PhosphorIcon(PhosphorIcons.heart()),
              ))
          .toList(),
    );
  }
}
