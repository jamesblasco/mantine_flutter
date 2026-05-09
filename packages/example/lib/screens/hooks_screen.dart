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
    _mapState.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GalleryScreen(
      title: 'Hooks & Utils',
      sections: [
        GallerySection(
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
