import 'package:flutter/widgets.dart';
import 'package:mantine/mantine.dart';

class FlexSection extends StatelessWidget {
  const FlexSection({super.key});

  @override
  Widget build(BuildContext context) {
    return MantineStack(
      children: [
        const MantineText('Basic usage:'),
        MantineFlex(
          gap: MantineSize.md,
          justify: MainAxisAlignment.center,
          align: CrossAxisAlignment.center,
          children: [
            _box(context, '1'),
            _box(context, '2'),
            _box(context, '3'),
          ],
        ),
        const MantineText('Direction column:'),
        MantineFlex(
          direction: Axis.vertical,
          gap: MantineSize.xs,
          children: [
            _box(context, '1'),
            _box(context, '2'),
          ],
        ),
        const MantineText('Wrap:'),
        MantineFlex(
          wrap: true,
          gap: MantineSize.sm,
          children: List.generate(
            10,
            (i) => _box(context, 'Box $i', width: 100),
          ),
        ),
      ],
    );
  }

  Widget _box(BuildContext context, String text, {double width = 50}) {
    final theme = context.mantineTheme;
    final primaryColor = theme.primaryColorValue;

    return Container(
      width: width,
      height: 50,
      decoration: BoxDecoration(
        color: primaryColor.withValues(alpha: 0.2),
        border: Border.all(color: primaryColor),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
        child: MantineText(text),
      ),
    );
  }
}
