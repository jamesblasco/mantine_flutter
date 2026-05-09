import 'package:flutter/widgets.dart';
import 'package:mantine/mantine.dart';

class PaperSection extends StatelessWidget {
  const PaperSection({super.key});

  @override
  Widget build(BuildContext context) {
    return MantineStack(
      children: [
        const MantineText('Shadows:'),
        MantineGroup(
          wrap: true,
          children: [
            MantinePaper(
              shadow: MantineSize.xs,
              child: _PaperContent(label: 'xs shadow'),
            ),
            MantinePaper(
              shadow: MantineSize.sm,
              child: _PaperContent(label: 'sm shadow'),
            ),
            MantinePaper(
              shadow: MantineSize.md,
              child: _PaperContent(label: 'md shadow'),
            ),
            MantinePaper(
              shadow: MantineSize.lg,
              child: _PaperContent(label: 'lg shadow'),
            ),
            MantinePaper(
              shadow: MantineSize.xl,
              child: _PaperContent(label: 'xl shadow'),
            ),
          ],
        ),
        const MantineText('With border and radius:'),
        MantineGroup(
          wrap: true,
          children: [
            MantinePaper(
              withBorder: true,
              radius: MantineSize.xs,
              child: _PaperContent(label: 'xs radius + border'),
            ),
            MantinePaper(
              withBorder: true,
              radius: MantineSize.sm,
              child: _PaperContent(label: 'sm radius + border'),
            ),
            MantinePaper(
              withBorder: true,
              radius: MantineSize.md,
              child: _PaperContent(label: 'md radius + border'),
            ),
            MantinePaper(
              withBorder: true,
              radius: MantineSize.lg,
              child: _PaperContent(label: 'lg radius + border'),
            ),
            MantinePaper(
              withBorder: true,
              radius: MantineSize.xl,
              child: _PaperContent(label: 'xl radius + border'),
            ),
          ],
        ),
      ],
    );
  }
}

class _PaperContent extends StatelessWidget {
  const _PaperContent({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: MantineText(label),
    );
  }
}
