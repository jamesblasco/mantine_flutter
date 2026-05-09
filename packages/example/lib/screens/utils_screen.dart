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
  late final MantineInterval _interval;
  int _seconds = 0;

  @override
  void initState() {
    super.initState();
    _interval = MantineInterval(const Duration(seconds: 1), () {
      setState(() => _seconds++);
    });
  }

  @override
  void dispose() {
    _setState.dispose();
    _interval.dispose();
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
          title: 'MantineInterval',
          child: ListenableBuilder(
            listenable: _interval,
            builder: (context, _) {
              return MantineStack(
                children: [
                  MantineText('Seconds passed: $_seconds'),
                  MantineText(
                    'Interval is currently ${_interval.active ? 'active' : 'inactive'}',
                    dimmed: true,
                    size: MantineSize.sm,
                  ),
                  MantineGroup(
                    children: [
                      MantineButton(
                        onPressed: _interval.active ? null : _interval.start,
                        color: 'teal',
                        child: const Text('Start'),
                      ),
                      MantineButton(
                        onPressed: !_interval.active ? null : _interval.stop,
                        color: 'red',
                        child: const Text('Stop'),
                      ),
                      MantineButton(
                        onPressed: _interval.toggle,
                        variant: MantineButtonVariant.outline,
                        child: const Text('Toggle'),
                      ),
                    ],
                  ),
                  const MantineText('Sizing variants:'),
                  MantineGroup(
                    align: CrossAxisAlignment.center,
                    children: MantineSize.values.map((s) {
                      return MantineButton(
                        onPressed: _interval.toggle,
                        size: s,
                        child: Text(s.name.toUpperCase()),
                      );
                    }).toList(),
                  ),
                ],
              );
            },
          ),
        ),
        GallerySection(
          title: 'MantineIdle',
          child: MantineIdle.wrap(
            timeout: const Duration(seconds: 3),
            child: const _IdleDemo(),
          ),
        ),
        const GallerySection(
          title: 'MantineQueue',
          child: _QueueDemo(),
        ),
        const GallerySection(
          title: 'MantineValidatedState',
          child: _ValidatedStateDemo(),
        )
        const GallerySection(
          title: 'MantineValidatedState',
          child: _ValidatedStateDemo(),
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

class _QueueDemo extends StatefulWidget {
  const _QueueDemo();

  @override
  State<_QueueDemo> createState() => _QueueDemoState();
}

class _QueueDemoState extends State<_QueueDemo> {
  late final MantineQueue<String> _queue;
  int _counter = 1;

  @override
  void initState() {
    super.initState();
    _queue = MantineQueue<String>(limit: 3);
  }

  @override
  void dispose() {
    _queue.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _queue,
      builder: (context, _) {
        return MantineStack(
          children: [
            MantineText(
              'A FIFO queue with a limit. Items exceeding the limit are stored in an internal queue.',
              size: MantineSize.sm,
              dimmed: true,
            ),
            MantineGroup(
              children: [
                MantineButton(
                  onPressed: () {
                    _queue.add('Item $_counter');
                    _counter++;
                  },
                  child: const Text('Add Item'),
                ),
                MantineButton(
                  onPressed: _queue.state.isEmpty ? null : _queue.shift,
                  variant: MantineButtonVariant.outline,
                  child: const Text('Shift (Remove First)'),
                ),
                MantineButton(
                  onPressed: _queue.queue.isEmpty ? null : _queue.cleanQueue,
                  variant: MantineButtonVariant.subtle,
                  color: 'red',
                  child: const Text('Clean Queue'),
                ),
              ],
            ),
            MantineGroup(
              align: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: MantineCard(
                    withBorder: true,
                    padding: MantineSize.md,
                    child: MantineStack(
                      spacingValue: 8,
                      children: [
                        MantineText('State (Limit: ${_queue.limit})', weight: FontWeight.bold),
                        if (_queue.state.isEmpty)
                          MantineText('Empty', dimmed: true, size: MantineSize.sm)
                        else
                          ..._queue.state.map((item) => _QueueItem(label: item)),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: MantineCard(
                    withBorder: true,
                    padding: MantineSize.md,
                    child: MantineStack(
                      spacingValue: 8,
                      children: [
                        MantineText('Queue (Overflow)', weight: FontWeight.bold),
                        if (_queue.queue.isEmpty)
                          MantineText('Empty', dimmed: true, size: MantineSize.sm)
                        else
                          ..._queue.queue.map((item) => _QueueItem(label: item, isQueue: true)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const MantineText('Size variants:', weight: FontWeight.bold),
            MantineGroup(
              children: MantineSize.values.map((s) {
                return MantineBadge(
                  size: s,
                  child: Text(s.name.toUpperCase()),
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }
}

class _QueueItem extends StatelessWidget {
  const _QueueItem({required this.label, this.isQueue = false});
  final String label;
  final bool isQueue;

  @override
  Widget build(BuildContext context) {
    final theme = context.mantineTheme;
    final isDark = context.isDarkMode;

    final color = isQueue
      ? (isDark ? MantineColors.orange[9] : MantineColors.orange[0])
      : (isDark ? MantineColors.blue[9] : MantineColors.blue[0]);

    final textColor = isQueue
      ? (isDark ? MantineColors.orange[2] : MantineColors.orange[9])
      : (isDark ? MantineColors.blue[2] : MantineColors.blue[9]);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(theme.radius.sm),
      ),
      child: MantineText(
        label,
        color: textColor,
        weight: FontWeight.w500,
        size: MantineSize.sm,
      ),
    );
  }
}
