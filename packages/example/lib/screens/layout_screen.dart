import 'package:flutter/widgets.dart';
import 'package:mantine/mantine.dart';
import 'shared.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.mantineTheme;

    return GalleryScreen(
      title: 'Layout',
      sections: [
        GallerySection(
          title: 'MantineBox',
          child: MantineGroup(
            wrap: true,
            align: CrossAxisAlignment.center,
            children: [
              MantineBox(
                color: theme.primaryColorScale[0],
                radiusSize: MantineSize.sm,
                paddingSize: MantineSize.md,
                child: const MantineText('Box with bg'),
              ),
              MantineBox(
                color: theme.colors.resolve('teal')[0],
                radiusSize: MantineSize.lg,
                paddingSize: MantineSize.lg,
                shadowSize: MantineSize.md,
                child: const MantineText('Box with shadow'),
              ),
              MantineBox(
                border: Border.all(color: MantineColors.gray[4]),
                radiusSize: MantineSize.sm,
                paddingSize: MantineSize.md,
                child: const MantineText('Box with border'),
              ),
            ],
          ),
        ),
        GallerySection(
          title: 'MantineStack',
          child: MantineBox(
            maxWidth: 300,
            child: MantineStack(
              children: [
                MantineBox(
                  color: theme.primaryColorScale[0],
                  paddingSize: MantineSize.sm,
                  radiusSize: MantineSize.sm,
                  child: const MantineText('Item 1'),
                ),
                MantineBox(
                  color: theme.primaryColorScale[0],
                  paddingSize: MantineSize.sm,
                  radiusSize: MantineSize.sm,
                  child: const MantineText('Item 2'),
                ),
                MantineBox(
                  color: theme.primaryColorScale[0],
                  paddingSize: MantineSize.sm,
                  radiusSize: MantineSize.sm,
                  child: const MantineText('Item 3'),
                ),
              ],
            ),
          ),
        ),
        GallerySection(
          title: 'MantineGroup',
          child: MantineStack(
            children: [
              MantineGroup(
                children: [
                  MantineBox(
                      color: theme.primaryColorScale[0],
                      paddingSize: MantineSize.sm,
                      radiusSize: MantineSize.sm,
                      child: const MantineText('Left')),
                  MantineBox(
                      color: theme.primaryColorScale[0],
                      paddingSize: MantineSize.sm,
                      radiusSize: MantineSize.sm,
                      child: const MantineText('Center')),
                  MantineBox(
                      color: theme.primaryColorScale[0],
                      paddingSize: MantineSize.sm,
                      radiusSize: MantineSize.sm,
                      child: const MantineText('Right')),
                ],
              ),
              MantineGroup(
                justify: MainAxisAlignment.spaceBetween,
                grow: true,
                children: [
                  MantineBox(
                      color: theme.colors.resolve('teal')[0],
                      paddingSize: MantineSize.sm,
                      radiusSize: MantineSize.sm,
                      alignment: Alignment.center,
                      child: const MantineText('Grow 1')),
                  MantineBox(
                      color: theme.colors.resolve('teal')[0],
                      paddingSize: MantineSize.sm,
                      radiusSize: MantineSize.sm,
                      alignment: Alignment.center,
                      child: const MantineText('Grow 2')),
                  MantineBox(
                      color: theme.colors.resolve('teal')[0],
                      paddingSize: MantineSize.sm,
                      radiusSize: MantineSize.sm,
                      alignment: Alignment.center,
                      child: const MantineText('Grow 3')),
                ],
              ),
            ],
          ),
        ),
        GallerySection(
          title: 'Card',
          child: MantineGroup(
            wrap: true,
            align: CrossAxisAlignment.start,
            children: [
              MantineBox(
                maxWidth: 240,
                child: MantineCard(
                  child: MantineStack(
                    spacingValue: 8,
                    children: [
                      const MantineTitle('Card title',
                          order: MantineTitleOrder.h5),
                      const MantineText(
                          'Card content with some description text.',
                          dimmed: true),
                      MantineButton(
                          onPressed: () {},
                          size: MantineSize.xs,
                          child: const Text('Action')),
                    ],
                  ),
                ),
              ),
              MantineBox(
                maxWidth: 240,
                child: MantineCard(
                  withBorder: true,
                  shadow: MantineSize.xs,
                  child: MantineStack(
                    spacingValue: 8,
                    children: [
                      const MantineTitle('With border',
                          order: MantineTitleOrder.h5),
                      const MantineText('Border + minimal shadow.',
                          dimmed: true),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
