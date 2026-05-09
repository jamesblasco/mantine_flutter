import 'package:flutter/widgets.dart';

import '../shared.dart';
import 'sections/hotkeys_section.dart';
import 'sections/kbd_combinations_section.dart';
import 'sections/kbd_sizes_section.dart';

class HotkeysScreen extends StatelessWidget {
  const HotkeysScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const GalleryScreen(
      title: 'Hotkeys & Kbd',
      sections: [
        GallerySection(
          title: 'MantineHotkeys',
          child: HotkeysSection(),
        ),
        GallerySection(
          title: 'MantineKbd Sizes',
          child: KbdSizesSection(),
        ),
        GallerySection(
          title: 'Combinations',
          child: KbdCombinationsSection(),
        ),
      ],
    );
  }
}
