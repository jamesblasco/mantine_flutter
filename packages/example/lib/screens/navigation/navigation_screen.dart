import 'package:flutter/widgets.dart';
import '../shared.dart';
import 'sections/breadcrumbs_section.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const GalleryScreen(
      title: 'Navigation',
      sections: [
        GallerySection(
          title: 'Breadcrumbs',
          child: BreadcrumbsSection(),
        ),
      ],
    );
  }
}
