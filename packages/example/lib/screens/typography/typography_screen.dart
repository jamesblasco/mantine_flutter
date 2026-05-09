import 'package:flutter/widgets.dart';

import '../shared.dart';
import 'sections/avatar_section.dart';
import 'sections/badge_divider_section.dart';
import 'sections/headings_section.dart';
import 'sections/styles_section.dart';
import 'sections/text_sizes_section.dart';
import 'sections/truncation_section.dart';

class TypographyScreen extends StatelessWidget {
  const TypographyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const GalleryScreen(
      title: 'Typography',
      sections: [
        GallerySection(title: 'Headings', child: HeadingsSection()),
        GallerySection(title: 'Text sizes', child: TextSizesSection()),
        GallerySection(title: 'Styles', child: StylesSection()),
        GallerySection(title: 'Truncation', child: TruncationSection()),
        GallerySection(title: 'Badge & Divider', child: BadgeDividerSection()),
        GallerySection(title: 'Avatar', child: AvatarSection()),
      ],
    );
  }
}
