import 'package:flutter/widgets.dart';
import 'package:mantine/mantine.dart';
import 'shared.dart';

class UtilsScreen extends StatefulWidget {
  const UtilsScreen({super.key});

  @override
  State<UtilsScreen> createState() => _UtilsScreenState();
}

class _UtilsScreenState extends State<UtilsScreen> {
  final _setState = MantineSetState<String>(['React', 'Angular']);

  @override
  void dispose() {
    _setState.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GalleryScreen(
      title: 'Utilities',
      sections: [
        GallerySection(
          title: 'MantineSetState',
          child: _SetStateDemo(setState: _setState),
        ),
        GallerySection(
          title: 'MantineIdle',
          child: MantineIdle.wrap(
            timeout: const Duration(seconds: 3),
            child: const _IdleDemo(),
          ),
        ),
      ],
    );
  }
}

class _SetStateDemo extends StatefulWidget {
  final MantineSetState<String> setState;
  const _SetStateDemo({required this.setState});

  @override
  State<_SetStateDemo> createState() => _SetStateDemoState();
}

class _SetStateDemoState extends State<_SetStateDemo> {
  final _inputController = TextEditingController();

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  void _addItem() {
    final val = _inputController.text.trim();
    if (val.isNotEmpty) {
      widget.setState.add(val);
      _inputController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.setState,
      builder: (context, values, _) {
        return MantineStack(
          children: [
            const MantineText(
              'Manage a unique set of items with helper methods.',
              size: MantineSize.sm,
              dimmed: true,
            ),
            MantineGroup(
              align: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: MantineTextInput(
                    label: 'New item',
                    placeholder: 'Type and click Add',
                    controller: _inputController,
                  ),
                ),
                MantineButton(
                  onPressed: _addItem,
                  child: const Text('Add'),
                ),
              ],
            ),
            if (values.isNotEmpty) ...[
              const MantineText('Active items (click to remove):',
                  size: MantineSize.xs, weight: FontWeight.bold),
              MantineGroup(
                children: values.map((item) {
                  return GestureDetector(
                    onTap: () => widget.setState.remove(item),
                    child: MantineBadge(
                      size: MantineSize.md,
                      child: Text(item),
                    ),
                  );
                }).toList(),
              ),
              MantineButton(
                variant: MantineButtonVariant.subtle,
                color: 'red',
                size: MantineSize.xs,
                onPressed: () => widget.setState.clear(),
                child: const Text('Clear all'),
              ),
            ] else
              const MantineText(
                'Set is empty. Add some items above.',
                dimmed: true,
                size: MantineSize.sm,
              ),
            const MantineDivider(),
            const MantineText('Quick toggle:',
                size: MantineSize.xs, weight: FontWeight.bold),
            MantineGroup(
              children: ['Flutter', 'Vue', 'Svelte'].map((item) {
                final isActive = values.contains(item);
                return MantineButton(
                  variant: isActive
                      ? MantineButtonVariant.filled
                      : MantineButtonVariant.outline,
                  size: MantineSize.xs,
                  onPressed: () => widget.setState.toggle(item),
                  child: Text(item),
                );
              }).toList(),
            ),
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
