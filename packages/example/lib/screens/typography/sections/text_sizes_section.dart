import 'package:flutter/widgets.dart';
import 'package:mantine/mantine.dart';

class TextSizesSection extends StatelessWidget {
  const TextSizesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return MantineStack(
      spacingValue: 4,
      children: MantineSize.values
          .map((s) => MantineText(
                'Size ${s.name} — The quick brown fox jumps over the lazy dog',
                size: s,
              ))
          .toList(),
    );
  }
}
