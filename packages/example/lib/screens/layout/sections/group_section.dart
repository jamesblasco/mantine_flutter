import 'package:flutter/widgets.dart';
import 'package:mantine/mantine.dart';

class GroupSection extends StatelessWidget {
  const GroupSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.mantineTheme;

    return MantineStack(
      children: [
        MantineGroup(
          children: [
            _GroupItem(color: theme.primaryColorScale[0], label: 'Left'),
            _GroupItem(color: theme.primaryColorScale[0], label: 'Center'),
            _GroupItem(color: theme.primaryColorScale[0], label: 'Right'),
          ],
        ),
        MantineGroup(
          justify: MainAxisAlignment.spaceBetween,
          grow: true,
          children: [
            _GroupItem(
              color: theme.colors.resolve('teal')[0],
              label: 'Grow 1',
              alignment: Alignment.center,
            ),
            _GroupItem(
              color: theme.colors.resolve('teal')[0],
              label: 'Grow 2',
              alignment: Alignment.center,
            ),
            _GroupItem(
              color: theme.colors.resolve('teal')[0],
              label: 'Grow 3',
              alignment: Alignment.center,
            ),
          ],
        ),
      ],
    );
  }
}

class _GroupItem extends StatelessWidget {
  const _GroupItem({
    required this.color,
    required this.label,
    this.alignment,
  });

  final Color color;
  final String label;
  final Alignment? alignment;

  @override
  Widget build(BuildContext context) {
    return MantineBox(
      color: color,
      paddingSize: MantineSize.sm,
      radiusSize: MantineSize.sm,
      alignment: alignment,
      child: MantineText(label),
    );
  }
}
