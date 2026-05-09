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
          title: 'MantineValidatedState',
          child: _ValidatedStateDemo(),
        ),
      ],
    );
  }
}

class _ValidatedStateDemo extends StatefulWidget {
  const _ValidatedStateDemo();

  @override
  State<_ValidatedStateDemo> createState() => _ValidatedStateDemoState();
}

class _ValidatedStateDemoState extends State<_ValidatedStateDemo> {
  final emailState = MantineValidatedState<String>(
    '',
    (value) => value.isEmpty
        ? 'Email is required'
        : !value.contains('@')
            ? 'Invalid email'
            : null,
  );

  @override
  void dispose() {
    emailState.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: emailState,
      builder: (context, _) {
        return MantineStack(
          children: [
            const MantineText(
              'Enter a valid email address to clear the error state.',
              size: MantineSize.sm,
              dimmed: true,
            ),
            ...MantineSize.values.map((size) => MantineTextInput(
                  label: 'Email (${size.name})',
                  placeholder: 'hello@mantine.dev',
                  value: emailState.value,
                  error: emailState.error,
                  size: size,
                  onChanged: emailState.set,
                )),
          ],
        );
      },
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
