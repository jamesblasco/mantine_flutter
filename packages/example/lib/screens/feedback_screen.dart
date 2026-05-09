import 'package:flutter/widgets.dart';
import 'package:mantine/mantine.dart';
import 'shared.dart';

class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GalleryScreen(
      title: 'Feedback',
      sections: [
        GallerySection(
          title: 'Loader — Oval',
          child: MantineGroup(
            align: CrossAxisAlignment.center,
            children: MantineSize.values
                .map((s) => MantineLoader(type: MantineLoaderType.oval, size: s))
                .toList(),
          ),
        ),
        GallerySection(
          title: 'Loader — Bars',
          child: MantineGroup(
            align: CrossAxisAlignment.center,
            children: MantineSize.values
                .map((s) => MantineLoader(type: MantineLoaderType.bars, size: s))
                .toList(),
          ),
        ),
        GallerySection(
          title: 'Loader — Dots',
          child: MantineGroup(
            align: CrossAxisAlignment.center,
            children: MantineSize.values
                .map((s) => MantineLoader(type: MantineLoaderType.dots, size: s))
                .toList(),
          ),
        ),
        GallerySection(
          title: 'Loader colors',
          child: MantineGroup(
            align: CrossAxisAlignment.center,
            children: ['blue', 'violet', 'teal', 'red', 'orange']
                .map((c) => MantineLoader(
                      color: context.mantineTheme.colors.resolve(c)[
                          context.mantineTheme.primaryShade],
                    ))
                .toList(),
          ),
        ),
        GallerySection(
          title: 'Button loading states',
          child: MantineGroup(
            wrap: true,
            children: [
              MantineButton(
                onPressed: () {},
                loading: true,
                child: const Text('Left loader'),
              ),
              MantineButton(
                onPressed: () {},
                loading: true,
                loaderPosition: MantineLoaderPosition.right,
                child: const Text('Right loader'),
              ),
              MantineButton(
                onPressed: () {},
                loading: true,
                loaderPosition: MantineLoaderPosition.center,
                child: const Text('Hidden'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
