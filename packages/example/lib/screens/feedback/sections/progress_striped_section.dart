import 'package:flutter/widgets.dart';
import 'package:mantine/mantine.dart';

class ProgressStripedSection extends StatelessWidget {
  const ProgressStripedSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const MantineStack(
      children: [
        MantineProgress(value: 75, striped: true),
        MantineProgress(value: 75, striped: true, animated: true),
      ],
    );
  }
}
