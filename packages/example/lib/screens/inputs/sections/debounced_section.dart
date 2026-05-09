import 'package:flutter/widgets.dart';
import 'package:mantine/mantine.dart';

class DebouncedSection extends StatefulWidget {
  const DebouncedSection({super.key});

  @override
  State<DebouncedSection> createState() => _DebouncedSectionState();
}

class _DebouncedSectionState extends State<DebouncedSection> {
  final _debounced = MantineDebounced<String>(
    '',
    delay: const Duration(milliseconds: 500),
  );

  @override
  void dispose() {
    _debounced.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MantineStack(
      align: CrossAxisAlignment.start,
      children: [
        MantineBox(
          maxWidth: 400,
          child: MantineTextInput(
            label: 'Debounced input',
            placeholder: 'Type something...',
            onChanged: _debounced.set,
          ),
        ),
        ValueListenableBuilder(
          valueListenable: _debounced,
          builder: (context, value, _) {
            return MantineStack(
              align: CrossAxisAlignment.start,
              children: [
                MantineText(
                  'Debounced value: $value',
                  weight: FontWeight.bold,
                ),
                const MantineText('Different sizes:'),
                ...MantineSize.values.map((s) => MantineText(
                      value.isEmpty ? 'Size ${s.name}' : value,
                      size: s,
                    )),
              ],
            );
          },
        ),
      ],
    );
  }
}
