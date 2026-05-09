import 'package:flutter/widgets.dart';
import 'package:mantine/mantine.dart';

class LoaderBarsSection extends StatelessWidget {
  const LoaderBarsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return MantineGroup(
      align: CrossAxisAlignment.center,
      children: MantineSize.values
          .map((s) => MantineLoader(type: MantineLoaderType.bars, size: s))
          .toList(),
    );
  }
}
