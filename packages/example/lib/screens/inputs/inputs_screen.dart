import 'package:flutter/widgets.dart';

import '../shared.dart';
import 'sections/checkbox_section.dart';
import 'sections/counter_section.dart';
import 'sections/debounced_section.dart';
import 'sections/radio_section.dart';
import 'sections/switch_section.dart';
import 'sections/text_input_section.dart';
import 'sections/throttled_counter_section.dart';

class InputsScreen extends StatelessWidget {
  const InputsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const GalleryScreen(
      title: 'Inputs',
      sections: [
        GallerySection(title: 'TextInput', child: TextInputSection()),
        GallerySection(title: 'Checkbox', child: CheckboxSection()),
        GallerySection(title: 'Radio', child: RadioSection()),
        GallerySection(title: 'Switch', child: SwitchSection()),
        GallerySection(
          title: 'Counter (MantineCounter)',
          child: CounterSection(),
        ),
        GallerySection(
          title: 'Throttled Counter (MantineThrottled)',
          child: ThrottledCounterSection(),
        ),
        GallerySection(
          title: 'Debounced (MantineDebounced)',
          child: DebouncedSection(),
        ),
      ],
    );
  }
}
