import 'package:flutter/widgets.dart';
import 'package:mantine/mantine.dart';
import 'shared.dart';

class ButtonsScreen extends StatelessWidget {
  const ButtonsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GalleryScreen(
      title: 'Button',
      sections: [
        GallerySection(
          title: 'Variants',
          child: MantineGroup(
            wrap: true,
            children: [
              MantineButton(
                  onPressed: () {}, child: const Text('Filled')),
              MantineButton(
                  onPressed: () {},
                  variant: MantineButtonVariant.outline,
                  child: const Text('Outline')),
              MantineButton(
                  onPressed: () {},
                  variant: MantineButtonVariant.light,
                  child: const Text('Light')),
              MantineButton(
                  onPressed: () {},
                  variant: MantineButtonVariant.subtle,
                  child: const Text('Subtle')),
              MantineButton(
                  onPressed: () {},
                  variant: MantineButtonVariant.transparent,
                  child: const Text('Transparent')),
              MantineButton(
                  onPressed: () {},
                  variant: MantineButtonVariant.white,
                  child: const Text('White')),
              MantineButton(
                  onPressed: () {},
                  variant: MantineButtonVariant.gradient,
                  child: const Text('Gradient')),
            ],
          ),
        ),
        GallerySection(
          title: 'Sizes',
          child: MantineGroup(
            wrap: true,
            align: CrossAxisAlignment.center,
            children: MantineSize.values
                .map((s) => MantineButton(
                    onPressed: () {},
                    size: s,
                    child: Text(s.name.toUpperCase())))
                .toList(),
          ),
        ),
        GallerySection(
          title: 'Colors',
          child: MantineGroup(
            wrap: true,
            children: ['blue', 'violet', 'teal', 'red', 'orange', 'pink']
                .map((c) => MantineButton(
                    onPressed: () {}, color: c, child: Text(c)))
                .toList(),
          ),
        ),
        GallerySection(
          title: 'States',
          child: MantineGroup(
            wrap: true,
            align: CrossAxisAlignment.center,
            children: [
              MantineButton(onPressed: () {}, child: const Text('Normal')),
              MantineButton(
                  onPressed: () {},
                  loading: true,
                  child: const Text('Loading')),
              MantineButton(
                  onPressed: null, child: const Text('Disabled')),
            ],
          ),
        ),
        GallerySection(
          title: 'Full width',
          child: MantineButton(
            onPressed: () {},
            fullWidth: true,
            child: const Text('Full width button'),
          ),
        ),
      ],
    );
  }
}
