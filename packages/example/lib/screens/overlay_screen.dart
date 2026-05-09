import 'package:flutter/widgets.dart';
import 'package:mantine/mantine.dart';
import 'shared.dart';

class OverlayScreen extends StatefulWidget {
  const OverlayScreen({super.key});

  @override
  State<OverlayScreen> createState() => _OverlayScreenState();
}

class _OverlayScreenState extends State<OverlayScreen> {
  bool _clickOutsideOpened = false;

  void _openBasic(BuildContext context) {
    showMantineModal(
      context: context,
      title: const Text('Basic modal'),
      builder: (_) => MantineStack(
        children: [
          const MantineText(
            'This is a basic modal. Click outside or press Escape to close.',
          ),
          const MantineDivider(my: 4),
          MantineGroup(
            justify: MainAxisAlignment.end,
            children: [
              MantineButton(
                onPressed: () => Navigator.of(context).pop(),
                variant: MantineButtonVariant.subtle,
                child: const Text('Cancel'),
              ),
              MantineButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Confirm'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _openCentered(BuildContext context) {
    showMantineModal(
      context: context,
      title: const Text('Centered modal'),
      centered: true,
      builder: (_) => MantineStack(
        children: [
          const MantineText('This modal is vertically centered on screen.'),
          const MantineDivider(my: 4),
          MantineButton(
            onPressed: () => Navigator.of(context).pop(),
            fullWidth: true,
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _openSized(BuildContext context, MantineSize size) {
    showMantineModal(
      context: context,
      size: size,
      title: Text('Size: ${size.name}'),
      builder: (_) => Column(
        children: [
          MantineText(
              'Modal width corresponds to MantineSize.${size.name}.'),
          const SizedBox(height: 16),
          MantineButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.mantineTheme;

    return GalleryScreen(
      title: 'Overlay',
      sections: [
        GallerySection(
          title: 'Click outside',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const MantineText(
                'Click outside the box to hide it.',
              ),
              const SizedBox(height: 8),
              if (!_clickOutsideOpened)
                MantineButton(
                  onPressed: () => setState(() => _clickOutsideOpened = true),
                  child: const Text('Open dropdown'),
                )
              else
                MantineClickOutside(
                  onClickOutside: () =>
                      setState(() => _clickOutsideOpened = false),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: context.mantineSurface,
                      borderRadius:
                          BorderRadius.circular(theme.radius.sm),
                      border: Border.all(color: context.mantineBorder),
                      boxShadow: theme.shadows.resolve(MantineSize.sm),
                    ),
                    width: 200,
                    child: const Column(
                      children: [
                        MantineText('Click outside to close'),
                        MantineDivider(my: 8),
                        MantineText('I am a dropdown!'),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
        GallerySection(
          title: 'Modal variants',
          child: MantineGroup(
            wrap: true,
            children: [
              MantineButton(
                onPressed: () => _openBasic(context),
                child: const Text('Basic modal'),
              ),
              MantineButton(
                onPressed: () => _openCentered(context),
                variant: MantineButtonVariant.outline,
                child: const Text('Centered'),
              ),
            ],
          ),
        ),
        GallerySection(
          title: 'Sizes',
          child: MantineGroup(
            wrap: true,
            children: MantineSize.values
                .map((s) => MantineButton(
                      onPressed: () => _openSized(context, s),
                      variant: MantineButtonVariant.light,
                      size: MantineSize.sm,
                      child: Text('Size ${s.name}'),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}
