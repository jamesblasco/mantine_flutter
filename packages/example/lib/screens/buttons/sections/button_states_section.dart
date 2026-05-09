import 'package:flutter/widgets.dart';
import 'package:mantine/mantine.dart';

class ButtonStatesSection extends StatelessWidget {
  const ButtonStatesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return MantineGroup(
      wrap: true,
      align: CrossAxisAlignment.center,
      children: [
        MantineButton(onPressed: () {}, child: const Text('Normal')),
        MantineButton(
          onPressed: () {},
          loading: true,
          child: const Text('Loading'),
        ),
        const MantineButton(onPressed: null, child: Text('Disabled')),
      ],
    );
  }
}
