import 'package:flutter/widgets.dart';
import 'package:mantine/mantine.dart';

class ButtonColorsSection extends StatelessWidget {
  const ButtonColorsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return MantineGroup(
      wrap: true,
      children: ['blue', 'violet', 'teal', 'red', 'orange', 'pink']
          .map((c) => MantineButton(
                onPressed: () {},
                color: c,
                child: Text(c),
              ))
          .toList(),
    );
  }
}
