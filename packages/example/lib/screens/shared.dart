import 'package:flutter/widgets.dart';
import 'package:mantine/mantine.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({
    super.key,
    required this.title,
    required this.sections,
  });

  final String title;
  final List<GallerySection> sections;

  @override
  Widget build(BuildContext context) {
    final theme = context.mantineTheme;
    final isDark = context.isDarkMode;
    final bgColor =
        isDark ? MantineColors.dark[7] : MantineColors.gray[0];

    return DecoratedBox(
      decoration: BoxDecoration(color: bgColor),
      child: SingleChildScrollView(
        padding: EdgeInsets.all(theme.spacing.xl),
        child: MantineStack(
          spacingValue: theme.spacing.xl,
          children: [
            MantineTitle(title, order: MantineTitleOrder.h2),
            const MantineDivider(),
            ...sections,
          ],
        ),
      ),
    );
  }
}

class GallerySection extends StatelessWidget {
  const GallerySection({
    super.key,
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = context.mantineTheme;

    return MantineStack(
      spacingValue: theme.spacing.sm,
      children: [
        MantineTitle(title, order: MantineTitleOrder.h5),
        child,
      ],
    );
  }
}
