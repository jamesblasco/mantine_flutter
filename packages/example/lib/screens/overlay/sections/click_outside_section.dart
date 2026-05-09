import 'package:flutter/widgets.dart';
import 'package:mantine/mantine.dart';

class ClickOutsideSection extends StatefulWidget {
  const ClickOutsideSection({super.key});

  @override
  State<ClickOutsideSection> createState() => _ClickOutsideSectionState();
}

class _ClickOutsideSectionState extends State<ClickOutsideSection> {
  bool _opened = false;

  @override
  Widget build(BuildContext context) {
    final theme = context.mantineTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const MantineText('Click outside the box to hide it.'),
        const SizedBox(height: 8),
        if (!_opened)
          MantineButton(
            onPressed: () => setState(() => _opened = true),
            child: const Text('Open dropdown'),
          )
        else
          MantineClickOutside(
            onClickOutside: () => setState(() => _opened = false),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: context.mantineSurface,
                borderRadius: BorderRadius.circular(theme.radius.sm),
                border: Border.all(color: context.mantineBorder),
                boxShadow: theme.shadows.resolve(MantineSize.sm),
              ),
              width: 200,
              child: const Column(
                children: [
                  MantineText('Click outside to close'),
                  MantineDivider(my: 8),
                  MantineText('I am a dropdown!'),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
