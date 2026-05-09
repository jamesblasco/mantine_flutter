import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:mantine/mantine.dart';
import 'shared.dart';

class HotkeysScreen extends StatefulWidget {
  const HotkeysScreen({super.key});

  @override
  State<HotkeysScreen> createState() => _HotkeysScreenState();
}

class _HotkeysScreenState extends State<HotkeysScreen> {
  int _count = 0;

  void _increment() => setState(() => _count++);
  void _decrement() => setState(() => _count--);

  @override
  Widget build(BuildContext context) {
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
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MantineTitle('Hotkeys & Kbd', order: MantineTitleOrder.h2),
            MantineText(
              'Keyboard shortcut registry and key display component.',
              dimmed: true,
            ),
            const SizedBox(height: 32),
            GallerySection(
              title: 'MantineHotkeys',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MantineText(
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
                  Row(
                    children: [
                      const MantineKbd(children: [Text('↑')]),
                      const SizedBox(width: 8),
                      const MantineText('or'),
                      const SizedBox(width: 8),
                      MantineKbd(
                          children: [
                        Text(mantineModKey == LogicalKeyboardKey.meta
                            ? '⌘'
                            : 'Ctrl')
                      ]),
                      const SizedBox(width: 4),
                      const MantineText('+'),
                      const SizedBox(width: 4),
                      const MantineKbd(children: [Text('J')]),
                      const SizedBox(width: 8),
                      const MantineText('to increment'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const MantineKbd(children: [Text('↓')]),
                      const SizedBox(width: 8),
                      const MantineText('or'),
                      const SizedBox(width: 8),
                      MantineKbd(
                          children: [
                        Text(mantineModKey == LogicalKeyboardKey.meta
                            ? '⌘'
                            : 'Ctrl')
                      ]),
                      const SizedBox(width: 4),
                      const MantineText('+'),
                      const SizedBox(width: 4),
                      const MantineKbd(children: [Text('K')]),
                      const SizedBox(width: 8),
                      const MantineText('to decrement'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            const GallerySection(
              title: 'MantineKbd Sizes',
              child: Wrap(
                spacing: 16,
                runSpacing: 16,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  MantineKbd(size: MantineSize.xs, children: [Text('xs')]),
                  MantineKbd(size: MantineSize.sm, children: [Text('sm')]),
                  MantineKbd(size: MantineSize.md, children: [Text('md')]),
                  MantineKbd(size: MantineSize.lg, children: [Text('lg')]),
                  MantineKbd(size: MantineSize.xl, children: [Text('xl')]),
                ],
              ),
            ),
            const SizedBox(height: 32),
            const GallerySection(
              title: 'Combinations',
              child: Row(
                children: [
                  MantineKbd(children: [Text('Shift')]),
                  SizedBox(width: 4),
                  MantineText('+'),
                  SizedBox(width: 4),
                  MantineKbd(children: [Text('Alt')]),
                  SizedBox(width: 4),
                  MantineText('+'),
                  SizedBox(width: 4),
                  MantineKbd(children: [Text('Enter')]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
