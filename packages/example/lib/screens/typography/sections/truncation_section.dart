import 'package:flutter/widgets.dart';
import 'package:mantine/mantine.dart';

class TruncationSection extends StatelessWidget {
  const TruncationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return MantineStack(
      children: [
        MantineBox(
          maxWidth: 300,
          child: const MantineText(
            'This text is truncated when it overflows the container width with a single line.',
            truncate: true,
          ),
        ),
        MantineBox(
          maxWidth: 300,
          child: const MantineText(
            'This text is clamped to two lines when it overflows the container. The quick brown fox jumps over the lazy dog.',
            lineClamp: 2,
          ),
        ),
      ],
    );
  }
}
