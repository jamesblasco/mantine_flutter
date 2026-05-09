import 'package:flutter/widgets.dart';
import 'package:mantine/mantine.dart';

class ProgressColorsSection extends StatelessWidget {
  const ProgressColorsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return MantineStack(
      children: [
        MantineProgress(value: 30, color: MantineColors.blue[6]),
        MantineProgress(value: 50, color: MantineColors.red[6]),
        MantineProgress(value: 70, color: MantineColors.green[6]),
        MantineProgress(value: 90, color: MantineColors.orange[6]),
      ],
    );
  }
}
