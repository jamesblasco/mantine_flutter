import 'package:flutter/widgets.dart';
import 'package:mantine/mantine.dart';

class GridSection extends StatelessWidget {
  const GridSection({super.key});

  @override
  Widget build(BuildContext context) {
    return MantineStack(
      children: [
        const MantineText(
          'Simple grid with 3 columns',
          weight: FontWeight.bold,
        ),
        MantineGrid(
          children: [
            MantineGrid.col(
              span: 4,
              child: _DemoBox('1'),
            ),
            MantineGrid.col(
              span: 4,
              child: _DemoBox('2'),
            ),
            MantineGrid.col(
              span: 4,
              child: _DemoBox('3'),
            ),
          ],
        ),
        const MantineText(
          'Responsive columns (12 on mobile, 6 on tablet, 3 on desktop)',
          weight: FontWeight.bold,
        ),
        MantineGrid(
          children: [
            MantineGrid.col(
              spanValue: {null: 12, MantineSize.sm: 6, MantineSize.lg: 3},
              child: _DemoBox('1'),
            ),
            MantineGrid.col(
              spanValue: {null: 12, MantineSize.sm: 6, MantineSize.lg: 3},
              child: _DemoBox('2'),
            ),
            MantineGrid.col(
              spanValue: {null: 12, MantineSize.sm: 6, MantineSize.lg: 3},
              child: _DemoBox('3'),
            ),
            MantineGrid.col(
              spanValue: {null: 12, MantineSize.sm: 6, MantineSize.lg: 3},
              child: _DemoBox('4'),
            ),
          ],
        ),
        const MantineText(
          'Offset',
          weight: FontWeight.bold,
        ),
        MantineGrid(
          children: [
            MantineGrid.col(
              span: 3,
              child: _DemoBox('1'),
            ),
            MantineGrid.col(
              span: 3,
              offset: 3,
              child: _DemoBox('2 (Offset 3)'),
            ),
          ],
        ),
        const MantineText(
          'Grow',
          weight: FontWeight.bold,
        ),
        MantineGrid(
          grow: true,
          children: [
            MantineGrid.col(
              span: 4,
              child: _DemoBox('1'),
            ),
            MantineGrid.col(
              span: 4,
              child: _DemoBox('2'),
            ),
            MantineGrid.col(
              span: 4,
              child: _DemoBox('3'),
            ),
            MantineGrid.col(
              span: 4,
              child: _DemoBox('4'),
            ),
            MantineGrid.col(
              span: 4,
              child: _DemoBox('5'),
            ),
          ],
        ),
      ],
    );
  }
}

class _DemoBox extends StatelessWidget {
  const _DemoBox(this.label);
  final String label;

  @override
  Widget build(BuildContext context) {
    return MantinePaper(
      withBorder: true,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: MantineText(label),
        ),
      ),
    );
  }
}
