import 'package:flutter/widgets.dart';
import 'package:mantine/mantine.dart';
import 'shared.dart';

class OverlayScreen extends StatelessWidget {
  const OverlayScreen({super.key});

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
    return GalleryScreen(
      title: 'Overlay',
      sections: [
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
