import 'package:flutter/widgets.dart';
import 'package:mantine/mantine.dart';

class ProgressBasicSection extends StatelessWidget {
  const ProgressBasicSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const MantineStack(
      children: [
        MantineProgress(value: 50),
      ],
    );
  }
}
