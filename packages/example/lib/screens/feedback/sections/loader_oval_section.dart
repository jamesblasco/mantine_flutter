import 'package:flutter/widgets.dart';
import 'package:mantine/mantine.dart';

class LoaderOvalSection extends StatelessWidget {
  const LoaderOvalSection({super.key});

  @override
  Widget build(BuildContext context) {
    return MantineGroup(
      align: CrossAxisAlignment.center,
      children: MantineSize.values
          .map((s) => MantineLoader(type: MantineLoaderType.oval, size: s))
          .toList(),
    );
  }
}
