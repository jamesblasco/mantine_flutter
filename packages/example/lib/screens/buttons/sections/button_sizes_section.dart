import 'package:flutter/widgets.dart';
import 'package:mantine/mantine.dart';

class ButtonSizesSection extends StatelessWidget {
  const ButtonSizesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return MantineGroup(
      wrap: true,
      align: CrossAxisAlignment.center,
      children: MantineSize.values
          .map((s) => MantineButton(
                onPressed: () {},
                size: s,
                child: Text(s.name.toUpperCase()),
              ))
          .toList(),
    );
  }
}
