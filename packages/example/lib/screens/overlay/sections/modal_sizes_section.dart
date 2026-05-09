import 'package:flutter/widgets.dart';
import 'package:mantine/mantine.dart';

class ModalSizesSection extends StatelessWidget {
  const ModalSizesSection({super.key});

  void _openSized(BuildContext context, MantineSize size) {
    showMantineModal(
      context: context,
      size: size,
      title: Text('Size: ${size.name}'),
      builder: (_) => Column(
        children: [
          MantineText('Modal width corresponds to MantineSize.${size.name}.'),
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
    return MantineGroup(
      wrap: true,
      children: MantineSize.values
          .map((s) => MantineButton(
                onPressed: () => _openSized(context, s),
                variant: MantineButtonVariant.light,
                size: MantineSize.sm,
                child: Text('Size ${s.name}'),
              ))
          .toList(),
    );
  }
}
