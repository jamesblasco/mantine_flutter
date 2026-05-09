import 'package:flutter/widgets.dart';
import 'package:mantine/mantine.dart';

class ProgressMultiSection extends StatelessWidget {
  const ProgressMultiSection({super.key});

  @override
  Widget build(BuildContext context) {
    return MantineStack(
      children: [
        MantineProgress(
          sections: [
            MantineProgressSection(value: 35, color: MantineColors.cyan[6], label: const Text('35%', style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 10))),
            MantineProgressSection(value: 15, color: MantineColors.pink[6], label: const Text('15%', style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 10))),
            MantineProgressSection(value: 30, color: MantineColors.orange[6], label: const Text('30%', style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 10))),
          ],
        ),
      ],
    );
  }
}
