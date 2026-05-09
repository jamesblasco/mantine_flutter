import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:mantine/mantine.dart';

class HotkeysSection extends StatefulWidget {
  const HotkeysSection({super.key});

  @override
  State<HotkeysSection> createState() => _HotkeysSectionState();
}

class _HotkeysSectionState extends State<HotkeysSection> {
  int _count = 0;

  void _increment() => setState(() => _count++);
  void _decrement() => setState(() => _count--);

  @override
  Widget build(BuildContext context) {
    final modLabel = mantineModKey == LogicalKeyboardKey.meta ? '⌘' : 'Ctrl';

    return MantineHotkeys(
      hotkeys: [
        MantineHotkey(
          key: LogicalKeyboardKey.arrowUp,
          handler: _increment,
        ),
        MantineHotkey(
          key: LogicalKeyboardKey.arrowDown,
          handler: _decrement,
        ),
        MantineHotkey(
          key: LogicalKeyboardKey.keyJ,
          control: mantineModKey == LogicalKeyboardKey.control,
          meta: mantineModKey == LogicalKeyboardKey.meta,
          handler: _increment,
        ),
        MantineHotkey(
          key: LogicalKeyboardKey.keyK,
          control: mantineModKey == LogicalKeyboardKey.control,
          meta: mantineModKey == LogicalKeyboardKey.meta,
          handler: _decrement,
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const MantineText(
            'Press Up/Down arrows or Mod+J/Mod+K to change the counter. '
            'Hotkeys are ignored when typing in the input below.',
          ),
          const SizedBox(height: 16),
          MantineTitle('Counter: $_count', order: MantineTitleOrder.h3),
          const SizedBox(height: 16),
          const MantineTextInput(
            label: 'Focus here to disable hotkeys',
            placeholder: 'Type something...',
          ),
          const SizedBox(height: 16),
          _ShortcutHint(
            firstKey: '↑',
            secondKey: 'J',
            modLabel: modLabel,
            action: 'to increment',
          ),
          const SizedBox(height: 8),
          _ShortcutHint(
            firstKey: '↓',
            secondKey: 'K',
            modLabel: modLabel,
            action: 'to decrement',
          ),
        ],
      ),
    );
  }
}

class _ShortcutHint extends StatelessWidget {
  const _ShortcutHint({
    required this.firstKey,
    required this.secondKey,
    required this.modLabel,
    required this.action,
  });

  final String firstKey;
  final String secondKey;
  final String modLabel;
  final String action;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MantineKbd(children: [Text(firstKey)]),
        const SizedBox(width: 8),
        const MantineText('or'),
        const SizedBox(width: 8),
        MantineKbd(children: [Text(modLabel)]),
        const SizedBox(width: 4),
        const MantineText('+'),
        const SizedBox(width: 4),
        MantineKbd(children: [Text(secondKey)]),
        const SizedBox(width: 8),
        MantineText(action),
      ],
    );
  }
}
