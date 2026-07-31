import 'package:flutter/widgets.dart';

import '../shared.dart';
import 'sections/click_outside_section.dart';
import 'sections/modal_sizes_section.dart';
import 'sections/modal_variants_section.dart';
import 'sections/popover_section.dart';
import 'sections/tooltip_section.dart';

class OverlayScreen extends StatelessWidget {
  const OverlayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const GalleryScreen(
      title: 'Overlay',
      sections: [
        GallerySection(title: 'Tooltip', child: TooltipSection()),
        GallerySection(title: 'Popover', child: PopoverSection()),
        GallerySection(title: 'Click outside', child: ClickOutsideSection()),
        GallerySection(title: 'Modal variants', child: ModalVariantsSection()),
        GallerySection(title: 'Sizes', child: ModalSizesSection()),
      ],
    );
  }
}
