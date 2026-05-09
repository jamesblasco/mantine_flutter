import 'package:flutter/widgets.dart';
import 'package:mantine/mantine.dart';

class LoaderColorsSection extends StatelessWidget {
  const LoaderColorsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.mantineTheme;

    return MantineGroup(
      align: CrossAxisAlignment.center,
      children: ['blue', 'violet', 'teal', 'red', 'orange']
          .map((c) => MantineLoader(
                color: theme.colors.resolve(c)[theme.primaryShade],
              ))
          .toList(),
    );
  }
}
