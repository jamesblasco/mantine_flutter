import 'package:flutter/widgets.dart';
import 'package:mantine/mantine.dart';

class SetStateSection extends StatefulWidget {
  const SetStateSection({super.key});

  @override
  State<SetStateSection> createState() => _SetStateSectionState();
}

class _SetStateSectionState extends State<SetStateSection> {
  final _setState = MantineSetState<String>(['React', 'Angular']);
  final _inputController = TextEditingController();

  @override
  void dispose() {
    _setState.dispose();
    _inputController.dispose();
    super.dispose();
  }

  void _addItem() {
    final value = _inputController.text.trim();
    if (value.isEmpty) return;

    _setState.add(value);
    _inputController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _setState,
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
                MantineButton(onPressed: _addItem, child: const Text('Add')),
              ],
            ),
            if (values.isNotEmpty) ...[
              const MantineText(
                'Active items (click to remove):',
                size: MantineSize.xs,
                weight: FontWeight.bold,
              ),
              MantineGroup(
                children: values.map((item) {
                  return GestureDetector(
                    onTap: () => _setState.remove(item),
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
                onPressed: _setState.clear,
                child: const Text('Clear all'),
              ),
            ] else
              const MantineText(
                'Set is empty. Add some items above.',
                dimmed: true,
                size: MantineSize.sm,
              ),
            const MantineDivider(),
            const MantineText(
              'Quick toggle:',
              size: MantineSize.xs,
              weight: FontWeight.bold,
            ),
            MantineGroup(
              children: ['Flutter', 'Vue', 'Svelte'].map((item) {
                final isActive = values.contains(item);
                return MantineButton(
                  variant: isActive
                      ? MantineButtonVariant.filled
                      : MantineButtonVariant.outline,
                  size: MantineSize.xs,
                  onPressed: () => _setState.toggle(item),
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
