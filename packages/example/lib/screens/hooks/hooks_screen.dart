import 'package:flutter/widgets.dart';

import '../shared.dart';
import 'sections/list_state_section.dart';
import 'sections/local_storage_section.dart';
import 'sections/map_state_section.dart';
import 'sections/state_history_section.dart';
import 'sections/toggle_section.dart';
import 'sections/uncontrolled_section.dart';

class HooksScreen extends StatelessWidget {
  const HooksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const GalleryScreen(
      title: 'Hooks & Utils',
      sections: [
        GallerySection(
          title: 'MantineStateHistory',
          child: StateHistorySection(),
        ),
        GallerySection(title: 'MantineMapState', child: MapStateSection()),
        GallerySection(
          title: 'MantineLocalStorage',
          child: LocalStorageSection(),
        ),
        GallerySection(
          title: 'MantineUncontrolled',
          child: UncontrolledSection(),
        ),
        GallerySection(title: 'MantineToggle', child: ToggleSection()),
        GallerySection(title: 'MantineListState', child: ListStateSection()),
      ],
    );
  }
}
