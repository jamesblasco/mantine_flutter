import 'package:flutter/widgets.dart';
import 'package:mantine/mantine.dart';

class StackSection extends StatelessWidget {
  const StackSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.mantineTheme;

    return MantineBox(
      maxWidth: 300,
      child: MantineStack(
        children: [
          _StackItem(color: theme.primaryColorScale[0], label: 'Item 1'),
          _StackItem(color: theme.primaryColorScale[0], label: 'Item 2'),
          _StackItem(color: theme.primaryColorScale[0], label: 'Item 3'),
        ],
      ),
    );
  }
}

class _StackItem extends StatelessWidget {
  const _StackItem({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return MantineBox(
      color: color,
      paddingSize: MantineSize.sm,
      radiusSize: MantineSize.sm,
      child: MantineText(label),
    );
  }
}
