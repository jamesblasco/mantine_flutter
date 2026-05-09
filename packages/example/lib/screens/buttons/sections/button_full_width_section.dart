import 'package:flutter/widgets.dart';
import 'package:mantine/mantine.dart';

class ButtonFullWidthSection extends StatelessWidget {
  const ButtonFullWidthSection({super.key});

  @override
  Widget build(BuildContext context) {
    return MantineButton(
      onPressed: () {},
      fullWidth: true,
      child: const Text('Full width button'),
    );
  }
}
