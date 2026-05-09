import 'package:flutter/widgets.dart';
import 'package:mantine/mantine.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class BreadcrumbsSection extends StatelessWidget {
  const BreadcrumbsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      (title: 'Mantine', href: '#'),
      (title: 'Mantine hooks', href: '#'),
      (title: 'use-id', href: '#'),
    ].map((item) => GestureDetector(
      onTap: () {},
      child: MantineText(
        item.title,
        color: context.mantinePrimaryColor,
        weight: FontWeight.w500,
      ),
    )).toList();

    return MantineStack(
      spacing: MantineSize.xl,
      children: [
        MantineStack(
          spacing: MantineSize.xs,
          children: [
            MantineText('Default breadcrumbs', weight: FontWeight.bold),
            MantineBreadcrumbs(children: items),
          ],
        ),
        MantineStack(
          spacing: MantineSize.xs,
          children: [
            MantineText('Custom separator', weight: FontWeight.bold),
            MantineBreadcrumbs(
              separator: PhosphorIcon(PhosphorIcons.caretRight(), size: 14),
              children: items,
            ),
          ],
        ),
        MantineStack(
          spacing: MantineSize.xs,
          children: [
            MantineText('Different sizes', weight: FontWeight.bold),
            MantineBreadcrumbs(
              size: MantineSize.xs,
              children: items,
            ),
            const SizedBox(height: 8),
            MantineBreadcrumbs(
              size: MantineSize.md,
              children: items,
            ),
            const SizedBox(height: 8),
            MantineBreadcrumbs(
              size: MantineSize.xl,
              children: items,
            ),
          ],
        ),
      ],
    );
  }
}
