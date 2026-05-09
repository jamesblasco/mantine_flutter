import 'package:flutter/widgets.dart';
import 'package:mantine/mantine.dart';

class QueueSection extends StatefulWidget {
  const QueueSection({super.key});

  @override
  State<QueueSection> createState() => _QueueSectionState();
}

class _QueueSectionState extends State<QueueSection> {
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
            const MantineText(
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
                        MantineText(
                          'State (Limit: ${_queue.limit})',
                          weight: FontWeight.bold,
                        ),
                        if (_queue.state.isEmpty)
                          const MantineText(
                            'Empty',
                            dimmed: true,
                            size: MantineSize.sm,
                          )
                        else
                          ..._queue.state
                              .map((item) => _QueueItem(label: item)),
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
                        const MantineText(
                          'Queue (Overflow)',
                          weight: FontWeight.bold,
                        ),
                        if (_queue.queue.isEmpty)
                          const MantineText(
                            'Empty',
                            dimmed: true,
                            size: MantineSize.sm,
                          )
                        else
                          ..._queue.queue.map(
                            (item) => _QueueItem(label: item, isQueue: true),
                          ),
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
