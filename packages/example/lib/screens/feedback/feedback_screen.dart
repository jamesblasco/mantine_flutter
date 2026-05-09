import 'package:flutter/widgets.dart';

import '../shared.dart';
import 'sections/button_loading_states_section.dart';
import 'sections/loader_bars_section.dart';
import 'sections/loader_colors_section.dart';
import 'sections/loader_dots_section.dart';
import 'sections/loader_oval_section.dart';
import 'sections/timeout_section.dart';
import 'sections/progress_basic_section.dart';
import 'sections/progress_colors_section.dart';
import 'sections/progress_striped_section.dart';
import 'sections/progress_multi_section.dart';

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
        GallerySection(title: 'MantineTimeout', child: TimeoutSection()),
        GallerySection(title: 'Progress — Basic', child: ProgressBasicSection()),
        GallerySection(title: 'Progress — Colors', child: ProgressColorsSection()),
        GallerySection(title: 'Progress — Striped', child: ProgressStripedSection()),
        GallerySection(title: 'Progress — Multi-section', child: ProgressMultiSection()),
      ],
    );
  }
}
