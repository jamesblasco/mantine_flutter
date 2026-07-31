import 'package:flutter/widgets.dart';
import 'package:mantine/mantine.dart';

class ScrollAreaSection extends StatelessWidget {
  const ScrollAreaSection({super.key});

  @override
  Widget build(BuildContext context) {
    return MantineStack(
      spacingValue: context.mantineTheme.spacing.md,
      children: [
        const MantineText('Vertical scroll area with hover scrollbars:'),
        SizedBox(
          height: 200,
          child: MantinePaper(
            withBorder: true,
            child: MantineScrollArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: List.generate(
                    20,
                    (index) => Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: MantineText('Item $index - Scrollable content'),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const MantineText('Horizontal scroll area with always visible scrollbars:'),
        SizedBox(
          height: 60,
          child: MantinePaper(
            withBorder: true,
            child: MantineScrollArea(
              type: MantineScrollAreaType.always,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: List.generate(
                    15,
                    (index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: MantineBadge(child: Text('Badge $index')),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const MantineText('Both axes with offset scrollbars:'),
        SizedBox(
          height: 200,
          width: 300,
          child: MantinePaper(
            withBorder: true,
            child: MantineScrollArea(
              type: MantineScrollAreaType.scroll,
              offsetScrollbars: true,
              scrollbarSize: MantineSize.md,
              child: SizedBox(
                width: 600,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: List.generate(
                      20,
                      (index) => Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: MantineText(
                            'Item $index - This is a very long line of text that should cause horizontal scrolling as well.'),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
