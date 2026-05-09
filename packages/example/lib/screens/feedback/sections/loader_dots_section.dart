import 'package:flutter/widgets.dart';
import 'package:mantine/mantine.dart';

class LoaderDotsSection extends StatelessWidget {
  const LoaderDotsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return MantineGroup(
      align: CrossAxisAlignment.center,
      children: MantineSize.values
          .map((s) => MantineLoader(type: MantineLoaderType.dots, size: s))
          .toList(),
    );
  }
}
