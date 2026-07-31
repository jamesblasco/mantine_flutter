import 'package:flutter/widgets.dart';

import '../shared.dart';
import 'sections/card_section.dart';
import 'sections/center_section.dart';
import 'sections/group_section.dart';
import 'sections/mantine_box_section.dart';
import 'sections/paper_section.dart';
import 'sections/scroll_area_section.dart';
import 'sections/stack_section.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const GalleryScreen(
      title: 'Layout',
      sections: [
        GallerySection(title: 'MantineBox', child: MantineBoxSection()),
        GallerySection(title: 'MantineCenter', child: CenterSection()),
        GallerySection(title: 'MantineStack', child: StackSection()),
        GallerySection(title: 'MantineGroup', child: GroupSection()),
        GallerySection(title: 'MantinePaper', child: PaperSection()),
        GallerySection(title: 'Card', child: CardSection()),
        GallerySection(title: 'ScrollArea', child: ScrollAreaSection()),
      ],
    );
  }
}
