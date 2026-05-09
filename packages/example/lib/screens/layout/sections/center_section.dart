import 'package:flutter/widgets.dart';
import 'package:mantine/mantine.dart';

class CenterSection extends StatefulWidget {
  const CenterSection({super.key});

  @override
  State<CenterSection> createState() => _CenterSectionState();
}

class _CenterSectionState extends State<CenterSection> {
  bool _inline = false;

  @override
  Widget build(BuildContext context) {
    final theme = context.mantineTheme;

    return MantineStack(
      children: [
        const MantineText('Default (inline: false) - takes full width'),
        MantineCenter(
          height: 100,
          color: theme.primaryColorScale[0],
          radiusSize: MantineSize.sm,
          child: const MantineText('Centered content'),
        ),
        const SizedBox(height: 20),
        MantineGroup(
          children: [
            const MantineText('Inline mode:'),
            MantineSwitch(
              checked: _inline,
              onChanged: (val) => setState(() => _inline = val),
            ),
          ],
        ),
        MantineBox(
          border: Border.all(color: theme.colors.resolve('gray')[3]),
          paddingSize: MantineSize.md,
          child: MantineCenter(
            inline: _inline,
            color: theme.primaryColorScale[0],
            paddingSize: MantineSize.md,
            radiusSize: MantineSize.sm,
            child: const MantineText('Centered content'),
          ),
        ),
        const MantineText('Center with custom dimensions'),
        MantineCenter(
          width: 200,
          height: 100,
          color: theme.colors.resolve('teal')[0],
          radiusSize: MantineSize.md,
          shadowSize: MantineSize.sm,
          child: const MantineText('200x100'),
        ),
      ],
    );
  }
}
