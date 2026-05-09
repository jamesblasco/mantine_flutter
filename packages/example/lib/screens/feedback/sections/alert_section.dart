import 'package:flutter/widgets.dart';
import 'package:mantine/mantine.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AlertSection extends StatelessWidget {
  const AlertSection({super.key});

  @override
  Widget build(BuildContext context) {
    return MantineStack(
      spacing: MantineSize.md,
      children: [
        const MantineAlert(
          title: 'Default Alert',
          child: MantineText('This is a default alert with light variant'),
        ),
        const MantineAlert(
          title: 'Filled Alert',
          variant: MantineButtonVariant.filled,
          color: 'blue',
          icon: Icon(PhosphorIconsRegular.info),
          child: MantineText('This is a filled alert with an icon'),
        ),
        const MantineAlert(
          title: 'Outline Alert',
          variant: MantineButtonVariant.outline,
          color: 'red',
          icon: Icon(PhosphorIconsRegular.warning),
          child: MantineText('This is an outline alert with warning icon'),
        ),
        const MantineAlert(
          title: 'Transparent Alert',
          variant: MantineButtonVariant.transparent,
          color: 'green',
          icon: Icon(PhosphorIconsRegular.checkCircle),
          child: MantineText('This is a transparent alert with success icon'),
        ),
        MantineAlert(
          title: 'With Close Button',
          withCloseButton: true,
          onClose: () {},
          child: const MantineText('You can close this alert'),
        ),
        const MantineAlert(
          title: 'Large Size Alert',
          size: MantineSize.lg,
          icon: Icon(PhosphorIconsRegular.bell),
          child: MantineText('This alert has a larger size'),
        ),
      ],
    );
  }
}
