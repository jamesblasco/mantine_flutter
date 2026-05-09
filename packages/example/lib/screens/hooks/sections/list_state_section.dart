import 'package:flutter/widgets.dart';
import 'package:mantine/mantine.dart';

typedef _ListItem = ({String id, String label, bool active});

class ListStateSection extends StatefulWidget {
  const ListStateSection({super.key});

  @override
  State<ListStateSection> createState() => _ListStateSectionState();
}

class _ListStateSectionState extends State<ListStateSection> {
  late final MantineListState<_ListItem> _listState;

  @override
  void initState() {
    super.initState();
    _listState = MantineListState([
      (id: '1', label: 'First item', active: true),
      (id: '2', label: 'Second item', active: false),
      (id: '3', label: 'Third item', active: false),
    ]);
  }

  @override
  void dispose() {
    _listState.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _listState,
      builder: (context, list, _) {
        final theme = context.mantineTheme;
        final isDark = context.isDarkMode;

        return MantineStack(
          children: [
            const MantineText(
              'Manage list state with named mutation methods.',
              dimmed: true,
              size: MantineSize.sm,
            ),
            MantineGroup(
              children: [
                MantineButton(
                  size: MantineSize.xs,
                  onPressed: () => _listState.prepend((
                    id: DateTime.now().toString(),
                    label: 'Prepended Item',
                    active: false,
                  )),
                  child: const Text('Prepend'),
                ),
                MantineButton(
                  size: MantineSize.sm,
                  onPressed: () => _listState.append((
                    id: DateTime.now().toString(),
                    label: 'Appended Item',
                    active: false,
                  )),
                  child: const Text('Append'),
                ),
                MantineButton(
                  size: MantineSize.md,
                  variant: MantineButtonVariant.outline,
                  onPressed: () => _listState.filter((item) => item.active),
                  child: const Text('Filter Active'),
                ),
                MantineButton(
                  size: MantineSize.lg,
                  variant: MantineButtonVariant.outline,
                  onPressed: () => _listState.setAll([
                    (id: '1', label: 'Reset Item 1', active: true),
                    (id: '2', label: 'Reset Item 2', active: false),
                  ]),
                  child: const Text('Reset List'),
                ),
              ],
            ),
            MantineStack(
              spacingValue: 4,
              children: list.asMap().entries.map((entry) {
                final index = entry.key;
                final item = entry.value;

                return DecoratedBox(
                  decoration: BoxDecoration(
                    color:
                        isDark ? MantineColors.dark[6] : MantineColors.gray[0],
                    border: Border.all(
                      color: item.active
                          ? theme.primaryColorScale[isDark ? 8 : 4]
                          : context.mantineBorder,
                    ),
                    borderRadius: BorderRadius.circular(theme.radius.sm),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        MantineCheckbox(
                          checked: item.active,
                          onChanged: (v) => _listState.applyWhere(
                            (i) => i.id == item.id,
                            (i) => (id: i.id, label: i.label, active: v),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: MantineText(
                            item.label,
                            weight: item.active
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                        MantineGroup(
                          spacingValue: 4,
                          children: [
                            if (index > 0)
                              MantineActionIcon(
                                size: MantineSize.sm,
                                variant: MantineButtonVariant.subtle,
                                onPressed: () => _listState.reorder(
                                  index,
                                  index - 1,
                                ),
                                child: const Text('↑'),
                              ),
                            if (index < list.length - 1)
                              MantineActionIcon(
                                size: MantineSize.sm,
                                variant: MantineButtonVariant.subtle,
                                onPressed: () => _listState.reorder(
                                  index,
                                  index + 1,
                                ),
                                child: const Text('↓'),
                              ),
                            MantineActionIcon(
                              size: MantineSize.sm,
                              variant: MantineButtonVariant.subtle,
                              color: 'red',
                              onPressed: () => _listState.remove(index),
                              child: const Text('×'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }
}
