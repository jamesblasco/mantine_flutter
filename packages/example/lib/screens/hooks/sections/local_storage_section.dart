import 'package:flutter/widgets.dart';
import 'package:mantine/mantine.dart';

import '../../../utils/storage_backend.dart';
import '../../shared.dart';

class LocalStorageSection extends StatefulWidget {
  const LocalStorageSection({super.key});

  @override
  State<LocalStorageSection> createState() => _LocalStorageSectionState();
}

class _LocalStorageSectionState extends State<LocalStorageSection> {
  late final MantineLocalStorage<String> _textStorage;
  late final MantineLocalStorage<int> _counterStorage;
  late final MantineLocalStorage<bool> _boolStorage;

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
  }

  @override
  void dispose() {
    _textStorage.dispose();
    _counterStorage.dispose();
    _boolStorage.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MantineStack(
      children: [
        const MantineText(
          'Values persisted to SharedPreferences. Try changing them and reloading the app.',
          dimmed: true,
          size: MantineSize.sm,
        ),
        const SizedBox(height: 10),
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
      ],
    );
  }
}
