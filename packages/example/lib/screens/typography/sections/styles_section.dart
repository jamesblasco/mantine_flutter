import 'package:flutter/widgets.dart';
import 'package:mantine/mantine.dart';

class StylesSection extends StatelessWidget {
  const StylesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return MantineStack(
      spacingValue: 4,
      children: [
        const MantineText('Normal text'),
        const MantineText('Bold text', weight: FontWeight.bold),
        const MantineText('Italic text', italic: true),
        const MantineText('Underlined text', underline: true),
        const MantineText('Strikethrough text', strikethrough: true),
        const MantineText('Dimmed text', dimmed: true),
        MantineText(
          'Gradient text',
          gradient: (MantineColors.blue[6], MantineColors.violet[6]),
          size: MantineSize.lg,
          weight: FontWeight.bold,
        ),
      ],
    );
  }
}
