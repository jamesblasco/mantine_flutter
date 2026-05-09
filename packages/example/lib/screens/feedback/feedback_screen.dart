import 'package:flutter/widgets.dart';

import '../shared.dart';
import 'sections/button_loading_states_section.dart';
import 'sections/loader_bars_section.dart';
import 'sections/loader_colors_section.dart';
import 'sections/loader_dots_section.dart';
import 'sections/loader_oval_section.dart';
import 'sections/skeleton_section.dart';
import 'sections/timeout_section.dart';

class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const GalleryScreen(
      title: 'Feedback',
      sections: [
        GallerySection(title: 'Loader — Oval', child: LoaderOvalSection()),
        GallerySection(title: 'Loader — Bars', child: LoaderBarsSection()),
        GallerySection(title: 'Loader — Dots', child: LoaderDotsSection()),
        GallerySection(title: 'Loader colors', child: LoaderColorsSection()),
        GallerySection(
          title: 'Button loading states',
          child: ButtonLoadingStatesSection(),
        ),
        GallerySection(title: 'Skeleton', child: SkeletonSection()),
        GallerySection(title: 'MantineTimeout', child: TimeoutSection()),
      ],
    );
  }
}
