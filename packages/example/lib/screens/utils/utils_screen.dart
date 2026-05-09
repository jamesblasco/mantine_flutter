import 'package:flutter/widgets.dart';

import '../shared.dart';
import 'sections/idle_section.dart';
import 'sections/interval_section.dart';
import 'sections/pagination_section.dart';
import 'sections/queue_section.dart';
import 'sections/set_state_section.dart';
import 'sections/validated_state_section.dart';

class UtilsScreen extends StatelessWidget {
  const UtilsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const GalleryScreen(
      title: 'Utilities',
      sections: [
        GallerySection(
          title: 'MantinePaginationState',
          child: PaginationSection(),
        ),
        GallerySection(title: 'MantineSetState', child: SetStateSection()),
        GallerySection(title: 'MantineInterval', child: IntervalSection()),
        GallerySection(title: 'MantineIdle', child: IdleSection()),
        GallerySection(title: 'MantineQueue', child: QueueSection()),
        GallerySection(
          title: 'MantineValidatedState',
          child: ValidatedStateSection(),
        ),
      ],
    );
  }
}
