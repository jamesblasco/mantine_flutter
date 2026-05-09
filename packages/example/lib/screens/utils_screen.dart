import 'package:flutter/widgets.dart';
import 'package:mantine/mantine.dart';
import 'shared.dart';

class UtilsScreen extends StatelessWidget {
  const UtilsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GalleryScreen(
      title: 'Utilities',
      sections: [
        GallerySection(
          title: 'MantineIdle',
          child: MantineIdle.wrap(
            timeout: const Duration(seconds: 3),
            child: const _IdleDemo(),
          ),
        ),
        const GallerySection(
          title: 'MantineDisclosure',
          child: _DisclosureDemo(),
        ),
      ],
    );
  }
}

class _DisclosureDemo extends StatefulWidget {
  const _DisclosureDemo();

  @override
  State<_DisclosureDemo> createState() => _DisclosureDemoState();
}

class _DisclosureDemoState extends State<_DisclosureDemo> {
  final _disclosure = MantineDisclosure(false);

  @override
  void dispose() {
    _disclosure.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MantineStack(
      children: [
        MantineGroup(
          children: [
            MantineButton(
              onPressed: _disclosure.open,
              child: const Text('Open'),
            ),
            MantineButton(
              onPressed: _disclosure.close,
              variant: MantineButtonVariant.outline,
              child: const Text('Close'),
            ),
            MantineButton(
              onPressed: _disclosure.toggle,
              variant: MantineButtonVariant.light,
              child: const Text('Toggle'),
            ),
          ],
        ),
        ValueListenableBuilder(
          valueListenable: _disclosure,
          builder: (context, opened, _) {
            if (!opened) {
              return const MantineText(
                'Disclosure is closed. Click "Open" or "Toggle" to reveal content.',
                dimmed: true,
                size: MantineSize.sm,
              );
            }

            return MantineCard(
              withBorder: true,
              shadow: MantineSize.sm,
              padding: MantineSize.md,
              child: MantineStack(
                children: [
                  const MantineText(
                    'Disclosure Content',
                    weight: FontWeight.bold,
                  ),
                  const MantineText(
                    'This content is only visible when the disclosure is open.',
                    size: MantineSize.sm,
                  ),
                  MantineButton(
                    onPressed: _disclosure.close,
                    color: 'red',
                    size: MantineSize.xs,
                    child: const Text('Close from inside'),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

class _IdleDemo extends StatelessWidget {
  const _IdleDemo();

  @override
  Widget build(BuildContext context) {
    final idle = MantineIdleScope.of(context);
    final isIdle = idle.isIdle;
    final theme = context.mantineTheme;
    final isDark = context.isDarkMode;

    final color = isIdle
        ? (isDark ? MantineColors.red[8] : MantineColors.red[1])
        : (isDark ? MantineColors.teal[8] : MantineColors.teal[1]);

    final textColor = isIdle
        ? (isDark ? MantineColors.red[2] : MantineColors.red[9])
        : (isDark ? MantineColors.teal[2] : MantineColors.teal[9]);

    return MantineStack(
      children: [
        MantineText(
          'Stop moving your mouse or typing for 3 seconds to see the idle state.',
          size: MantineSize.sm,
          dimmed: true,
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(theme.radius.md),
            border: Border.all(
              color: isIdle ? MantineColors.red[4] : MantineColors.teal[4],
              width: 1,
            ),
          ),
          child: Center(
            child: MantineGroup(
              justify: MainAxisAlignment.center,
              children: [
                MantineText(
                  isIdle ? 'Status: IDLE' : 'Status: ACTIVE',
                  weight: FontWeight.bold,
                  color: textColor,
                ),
                if (!isIdle)
                  MantineLoader(
                    size: MantineSize.xs,
                    color: textColor,
                  ),
              ],
            ),
          ),
        ),
        const MantineText(
          'Any pointer event or key press will reset the timer.',
          size: MantineSize.xs,
          dimmed: true,
        ),
      ],
    );
  }
}
