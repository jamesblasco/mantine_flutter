import 'package:flutter/widgets.dart';
import 'package:mantine/mantine.dart';
import 'shared.dart';

class TypographyScreen extends StatelessWidget {
  const TypographyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GalleryScreen(
      title: 'Typography',
      sections: [
        GallerySection(
          title: 'Headings',
          child: MantineStack(
            spacingValue: 4,
            children: MantineTitleOrder.values
                .map((o) => MantineTitle(
                      'Heading ${o.name.toUpperCase()}',
                      order: o,
                    ))
                .toList(),
          ),
        ),
        GallerySection(
          title: 'Text sizes',
          child: MantineStack(
            spacingValue: 4,
            children: MantineSize.values
                .map((s) => MantineText(
                      'Size ${s.name} — The quick brown fox jumps over the lazy dog',
                      size: s,
                    ))
                .toList(),
          ),
        ),
        GallerySection(
          title: 'Styles',
          child: MantineStack(
            spacingValue: 4,
            children: [
              const MantineText('Normal text'),
              const MantineText('Bold text', weight: FontWeight.bold),
              const MantineText('Italic text', italic: true),
              const MantineText('Underlined text', underline: true),
              const MantineText('Strikethrough text', strikethrough: true),
              const MantineText('Dimmed text', dimmed: true),
              MantineText(
                'Gradient text',
                gradient: (MantineColors.blue[6], MantineColors.violet[6]),
                size: MantineSize.lg,
                weight: FontWeight.bold,
              ),
            ],
          ),
        ),
        GallerySection(
          title: 'Truncation',
          child: MantineStack(
            children: [
              MantineBox(
                maxWidth: 300,
                child: const MantineText(
                  'This text is truncated when it overflows the container width with a single line.',
                  truncate: true,
                ),
              ),
              MantineBox(
                maxWidth: 300,
                child: const MantineText(
                  'This text is clamped to two lines when it overflows the container. The quick brown fox jumps over the lazy dog.',
                  lineClamp: 2,
                ),
              ),
            ],
          ),
        ),
        GallerySection(
          title: 'Badge & Divider',
          child: MantineStack(
            children: [
              MantineGroup(
                wrap: true,
                children: [
                  MantineBadge(child: const Text('Default')),
                  MantineBadge(
                      variant: MantineBadgeVariant.outline,
                      child: const Text('Outline')),
                  MantineBadge(
                      variant: MantineBadgeVariant.light,
                      child: const Text('Light')),
                  MantineBadge(
                      variant: MantineBadgeVariant.dot,
                      child: const Text('With dot')),
                  MantineBadge(
                      color: 'red', child: const Text('Red')),
                  MantineBadge(
                      color: 'teal', child: const Text('Teal')),
                ],
              ),
              const MantineDivider(my: 8),
              const MantineDivider(
                  variant: MantineDividerVariant.dashed, my: 8),
              const MantineDivider(
                  variant: MantineDividerVariant.dotted, my: 8),
              MantineDivider(
                label: const Text('Section label'),
                my: 8,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
