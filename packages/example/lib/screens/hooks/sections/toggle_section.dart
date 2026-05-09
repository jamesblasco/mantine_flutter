import 'package:flutter/widgets.dart';
import 'package:mantine/mantine.dart';

class ToggleSection extends StatefulWidget {
  const ToggleSection({super.key});

  @override
  State<ToggleSection> createState() => _ToggleSectionState();
}

class _ToggleSectionState extends State<ToggleSection> {
  final _toggle = MantineToggle('Blue', 'Red');

  @override
  void dispose() {
    _toggle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _toggle,
      builder: (context, value, _) {
        final color = value == 'Blue' ? 'blue' : 'red';

        return MantineStack(
          children: [
            MantineText('Current value: $value'),
            MantineGroup(
              children: [
                MantineButton(
                  onPressed: _toggle.toggle,
                  color: color,
                  child: const Text('Toggle'),
                ),
                MantineButton(
                  onPressed: () => _toggle.set('Blue'),
                  variant: MantineButtonVariant.outline,
                  child: const Text('Set Blue'),
                ),
                MantineButton(
                  onPressed: () => _toggle.set('Red'),
                  variant: MantineButtonVariant.outline,
                  child: const Text('Set Red'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
