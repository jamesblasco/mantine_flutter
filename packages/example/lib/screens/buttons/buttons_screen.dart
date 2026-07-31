import 'package:flutter/widgets.dart';

import '../shared.dart';
import 'sections/action_icon_sizes_section.dart';
import 'sections/action_icon_states_section.dart';
import 'sections/action_icon_variants_section.dart';
import 'sections/close_button_section.dart';
import 'sections/button_colors_section.dart';
import 'sections/button_full_width_section.dart';
import 'sections/button_sizes_section.dart';
import 'sections/button_states_section.dart';
import 'sections/button_variants_section.dart';

class ButtonsScreen extends StatelessWidget {
  const ButtonsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const GalleryScreen(
      title: 'Button',
      sections: [
        GallerySection(title: 'Variants', child: ButtonVariantsSection()),
        GallerySection(title: 'Sizes', child: ButtonSizesSection()),
        GallerySection(title: 'Colors', child: ButtonColorsSection()),
        GallerySection(title: 'States', child: ButtonStatesSection()),
        GallerySection(title: 'Full width', child: ButtonFullWidthSection()),
        GallerySection(
          title: 'ActionIcon variants',
          child: ActionIconVariantsSection(),
        ),
        GallerySection(
          title: 'ActionIcon sizes',
          child: ActionIconSizesSection(),
        ),
        GallerySection(
          title: 'ActionIcon states',
          child: ActionIconStatesSection(),
        ),
        GallerySection(
          title: 'CloseButton',
          child: CloseButtonSection(),
        ),
      ],
    );
  }
}
