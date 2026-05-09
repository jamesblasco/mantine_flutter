import 'package:flutter/widgets.dart';
import 'package:mantine/mantine.dart';
import '../utils/storage_backend.dart';
import 'shared.dart';

class HooksScreen extends StatefulWidget {
  const HooksScreen({super.key});

  @override
  State<HooksScreen> createState() => _HooksScreenState();
}

class _HooksScreenState extends State<HooksScreen> {
  late final MantineLocalStorage<String> _textStorage;
  late final MantineLocalStorage<int> _counterStorage;
  late final MantineLocalStorage<bool> _boolStorage;
  final MantineStateHistory<String> _history =
      MantineStateHistory<String>('Initial value', capacity: 10);
  late final MantineToggle<String> _toggle;
  late final MantineListState<({String id, String label, bool active})> _listState;
  late final MantineMapState<String, String> _mapState;

  @override
  void initState() {
    super.initState();
    const backend = SharedPreferencesBackend();
    _textStorage = MantineLocalStorage<String>(
      key: 'demo-text',
      defaultValue: '',
      backend: backend,
    );
    _counterStorage = MantineLocalStorage<int>(
      key: 'demo-counter',
      defaultValue: 0,
      backend: backend,
    );
    _boolStorage = MantineLocalStorage<bool>(
      key: 'demo-bool',
      defaultValue: false,
      backend: backend,
    );
    _toggle = MantineToggle('Blue', 'Red');
    _listState = MantineListState([
      (id: '1', label: 'First item', active: true),
      (id: '2', label: 'Second item', active: false),
      (id: '3', label: 'Third item', active: false),
    ]);
    _mapState = MantineMapState<String, String>({
      'Apple': 'Red',
      'Banana': 'Yellow',
    });
  }

  @override
  void dispose() {
    _textStorage.dispose();
    _counterStorage.dispose();
    _boolStorage.dispose();
    _history.dispose();
    _toggle.dispose();
    _listState.dispose();
    _mapState.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GalleryScreen(
      title: 'Hooks & Utils',
      sections: [
        GallerySection(
          title: 'MantineStateHistory',
          child: ListenableBuilder(
            listenable: _history,
            builder: (context, _) {
              return MantineStack(
                children: [
                  const MantineText(
                    'State with undo/redo history tracking.',
                    dimmed: true,
                    size: MantineSize.sm,
                  ),
                  MantineTextInput(
                    label: 'History input',
                    value: _history.value,
                    onChanged: (v) => _history.set(v),
                  ),
                  MantineGroup(
                    children: [
                      MantineButton(
                        onPressed: _history.canUndo ? _history.undo : null,
                        child: const Text('Undo'),
                      ),
                      MantineButton(
                        onPressed: _history.canRedo ? _history.redo : null,
                        child: const Text('Redo'),
                      ),
                    ],
                  ),
                  MantineText('History: ${_history.history.join(', ')}',
                      size: MantineSize.xs, dimmed: true),
                  MantineText('Future: ${_history.future.join(', ')}',
                      size: MantineSize.xs, dimmed: true),
          title: 'MantineMapState',
          child: ValueListenableBuilder(
            valueListenable: _mapState,
            builder: (context, map, _) {
              return MantineStack(
                children: [
                  const MantineText(
                    'Observable map with helper methods for common operations.',
                    dimmed: true,
                    size: MantineSize.sm,
                  ),
                  if (map.isEmpty)
                    const MantineText('Map is empty', dimmed: true)
                  else
                    ...map.entries.map((e) => MantineGroup(
                          justify: MainAxisAlignment.spaceBetween,
                          children: [
                            MantineText('${e.key}: ${e.value}'),
                            MantineButton(
                              size: MantineSize.xs,
                              variant: MantineButtonVariant.subtle,
                              color: 'red',
                              onPressed: () => _mapState.remove(e.key),
                              child: const Text('Remove'),
                            ),
                          ],
                        )),
                  MantineGroup(
                    children: [
                      MantineButton(
                        onPressed: () => _mapState.set(
                          'Orange',
                          'Orange',
                        ),
                        child: const Text('Add Orange'),
                      ),
                      MantineButton(
                        onPressed: () => _mapState.merge({
                          'Grape': 'Purple',
                          'Kiwi': 'Green',
                        }),
                        variant: MantineButtonVariant.outline,
                        child: const Text('Merge multiple'),
                      ),
                      MantineButton(
                        onPressed: _mapState.clear,
                        variant: MantineButtonVariant.subtle,
                        color: 'gray',
                        child: const Text('Clear all'),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
        GallerySection(
          title: 'MantineLocalStorage',
          child: MantineStack(
            children: [
              const MantineText(
                'Values persisted to SharedPreferences. Try changing them and reloading the app.',
                dimmed: true,
                size: MantineSize.sm,
              ),
              const SizedBox(height: 10),

              // Text Storage
              ValueListenableBuilder(
                valueListenable: _textStorage,
                builder: (context, value, _) {
                  return MantineTextInput(
                    label: 'Stored Text',
                    value: value,
                    onChanged: (v) => _textStorage.value = v,
                    placeholder: 'Type something to persist...',
                  );
                },
              ),

              // Counter Storage
              ValueListenableBuilder(
                valueListenable: _counterStorage,
                builder: (context, value, _) {
                  return GallerySection(
                    title: 'Stored Counter',
                    child: MantineGroup(
                      children: [
                        MantineText('Count: $value'),
                        MantineButton(
                          onPressed: () => _counterStorage.value++,
                          child: const Text('Increment'),
                        ),
                        MantineButton(
                          onPressed: () => _counterStorage.value = 0,
                          variant: MantineButtonVariant.outline,
                          child: const Text('Reset'),
                        ),
                      ],
                    ),
                  );
                },
              ),

              // Bool Storage
              ValueListenableBuilder(
                valueListenable: _boolStorage,
                builder: (context, value, _) {
                  return MantineSwitch(
                    label: 'Stored Switch',
                    checked: value,
                    onChanged: (v) => _boolStorage.value = v,
                  );
                },
              ),

              const MantineDivider(),

              GallerySection(
                title: 'MantineUncontrolled',
                child: MantineStack(
                  children: [
                    const MantineText(
                      'Components can be used in controlled (state managed by parent) or uncontrolled (state managed internally) mode.',
                      dimmed: true,
                      size: MantineSize.sm,
                    ),
                    const SizedBox(height: 10),
                    const MantineText('Uncontrolled components:',
                        weight: FontWeight.bold),
                    const MantineTextInput(
                      label: 'Uncontrolled text input',
                      placeholder: 'Type something (internal state)',
                      defaultValue: 'Initial value',
                    ),
                    const MantineCheckbox(
                      label: 'Uncontrolled checkbox',
                      defaultChecked: true,
                    ),
                    const MantineSwitch(
                      label: 'Uncontrolled switch',
                      defaultChecked: true,
                    ),
                    const SizedBox(height: 10),
                    const MantineText('Controlled components:',
                        weight: FontWeight.bold),
                    const _ControlledDemo(),
                  ],
                 )
                ),
              GallerySection(
                title: 'MantineToggle',
                child: ValueListenableBuilder(
                  valueListenable: _toggle,
                  builder: (context, value, _) {
                    final color =
                        value == 'Blue' ? 'blue' : 'red';
                    return MantineStack(
                      children: [
                        MantineText('Current value: $value'),
                        MantineGroup(
                          children: [
                            MantineButton(
                              onPressed: _toggle.toggle,
                              color: color,
                              child: const Text('Toggle'),
                            ),
                            MantineButton(
                              onPressed: () => _toggle.set('Blue'),
                              variant: MantineButtonVariant.outline,
                              child: const Text('Set Blue'),
                            ),
                            MantineButton(
                              onPressed: () => _toggle.set('Red'),
                              variant: MantineButtonVariant.outline,
                              child: const Text('Set Red'),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),

              GallerySection(
                title: 'MantineListState',
                child: ValueListenableBuilder(
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
                                color: isDark ? MantineColors.dark[6] : MantineColors.gray[0],
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
                                        weight: item.active ? FontWeight.bold : FontWeight.normal,
                                      ),
                                    ),
                                    MantineGroup(
                                      spacingValue: 4,
                                      children: [
                                        if (index > 0)
                                          MantineActionIcon(
                                            size: MantineSize.sm,
                                            variant: MantineButtonVariant.subtle,
                                            onPressed: () => _listState.reorder(index, index - 1),
                                            child: const Text('↑'),
                                          ),
                                        if (index < list.length - 1)
                                          MantineActionIcon(
                                            size: MantineSize.sm,
                                            variant: MantineButtonVariant.subtle,
                                            onPressed: () => _listState.reorder(index, index + 1),
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
                ),
              ),

              const MantineDivider(),
              const MantineText('Size variants (visual check):'),
              MantineGroup(
                align: CrossAxisAlignment.center,
                children: MantineSize.values.map((s) {
                  return MantineButton(
                    size: s,
                    child: Text(s.name.toUpperCase()),
                    onPressed: () {},
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ControlledDemo extends StatefulWidget {
  const _ControlledDemo();

  @override
  State<_ControlledDemo> createState() => _ControlledDemoState();
}

class _ControlledDemoState extends State<_ControlledDemo> {
  String _value = '';
  bool _checked = false;

  @override
  Widget build(BuildContext context) {
    return MantineStack(
      children: [
        MantineTextInput(
          label: 'Controlled text input',
          value: _value,
          onChanged: (v) => setState(() => _value = v),
        ),
        MantineText('Value: $_value', size: MantineSize.xs, dimmed: true),
        MantineCheckbox(
          label: 'Controlled checkbox',
          checked: _checked,
          onChanged: (v) => setState(() => _checked = v),
        ),
        MantineSwitch(
          label: 'Controlled switch',
          checked: _checked,
          onChanged: (v) => setState(() => _checked = v),
        ),
        MantineText('Checked: $_checked', size: MantineSize.xs, dimmed: true),
      ],
    );
  }
}
