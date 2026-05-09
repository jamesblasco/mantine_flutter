import 'package:flutter/widgets.dart';
import 'package:mantine/mantine.dart';

class ButtonLoadingStatesSection extends StatelessWidget {
  const ButtonLoadingStatesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return MantineGroup(
      wrap: true,
      children: [
        MantineButton(
          onPressed: () {},
          loading: true,
          child: const Text('Left loader'),
        ),
        MantineButton(
          onPressed: () {},
          loading: true,
          loaderPosition: MantineLoaderPosition.right,
          child: const Text('Right loader'),
        ),
        MantineButton(
          onPressed: () {},
          loading: true,
          loaderPosition: MantineLoaderPosition.center,
          child: const Text('Hidden'),
        ),
      ],
    );
  }
}
