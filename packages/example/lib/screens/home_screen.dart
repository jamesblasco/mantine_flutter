import 'package:flutter/widgets.dart';
import 'package:mantine/mantine.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'buttons_screen.dart';
import 'typography_screen.dart';
import 'layout_screen.dart';
import 'inputs_screen.dart';
import 'feedback_screen.dart';
import 'overlay_screen.dart';
import 'utils_screen.dart';
import 'hooks_screen.dart';
import 'hotkeys_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.onToggleTheme,
    required this.onPrimaryColorChange,
    required this.currentPrimaryColor,
    required this.isDark,
  });

  final VoidCallback onToggleTheme;
  final ValueChanged<String> onPrimaryColorChange;
  final String currentPrimaryColor;
  final bool isDark;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static final _navItems = [
    (label: 'Buttons', icon: PhosphorIcons.cursor()),
    (label: 'Typography', icon: PhosphorIcons.textT()),
    (label: 'Layout', icon: PhosphorIcons.squaresFour()),
    (label: 'Inputs', icon: PhosphorIcons.pencilSimple()),
    (label: 'Feedback', icon: PhosphorIcons.circleNotch()),
    (label: 'Overlays', icon: PhosphorIcons.appWindow()),
    (label: 'Utils', icon: PhosphorIcons.wrench()),
    (label: 'Hooks', icon: PhosphorIcons.floppyDisk()),
    (label: 'Hotkeys', icon: PhosphorIcons.keyboard()),
  ];

  static const _colorOptions = [
    'blue', 'violet', 'teal', 'green', 'red', 'orange', 'pink', 'cyan',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = context.mantineTheme;
    final isDark = context.isDarkMode;

    final bgColor = isDark ? MantineColors.dark[7] : MantineColors.gray[0];
    final sidebarBg = isDark ? MantineColors.dark[6] : theme.white;
    final borderColor = context.mantineBorder;

    final screens = [
      const ButtonsScreen(),
      const TypographyScreen(),
      const LayoutScreen(),
      const InputsScreen(),
      const FeedbackScreen(),
      const OverlayScreen(),
      const UtilsScreen(),
      const HooksScreen(),
      const HotkeysScreen(),
    ];

    return DecoratedBox(
      decoration: BoxDecoration(color: bgColor),
      child: Row(
        children: [
          // Sidebar
          SizedBox(
            width: 220,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: sidebarBg,
                border: Border(
                  right: BorderSide(color: borderColor, width: 1),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Logo / title
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MantineTitle(
                          'Mantine',
                          order: MantineTitleOrder.h3,
                          color: context.mantinePrimaryColor,
                        ),
                        MantineText(
                          'Flutter Gallery',
                          size: MantineSize.xs,
                          dimmed: true,
                        ),
                      ],
                    ),
                  ),
                  MantineDivider(),
                  // Nav items
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 8),
                      child: MantineStack(
                        spacingValue: 2,
                        children: List.generate(_navItems.length, (i) {
                          final item = _navItems[i];
                          final selected = _selectedIndex == i;
                          return _NavItem(
                            label: item.label,
                            icon: item.icon,
                            selected: selected,
                            onTap: () => setState(() => _selectedIndex = i),
                          );
                        }),
                      ),
                    ),
                  ),
                  MantineDivider(),
                  // Theme controls
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: MantineStack(
                      spacingValue: 8,
                      children: [
                        // Dark mode toggle
                        MantineButton(
                          onPressed: widget.onToggleTheme,
                          variant: MantineButtonVariant.light,
                          size: MantineSize.xs,
                          fullWidth: true,
                          child: Text(isDark ? '☀ Light mode' : '☾ Dark mode'),
                        ),
                        // Color picker
                        Wrap(
                          spacing: 4,
                          runSpacing: 4,
                          children: _colorOptions.map((c) {
                            final scale = theme.colors.resolve(c);
                            final active = c == theme.primaryColor;
                            return GestureDetector(
                              onTap: () => widget.onPrimaryColorChange(c),
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: scale[theme.primaryShade],
                                  shape: BoxShape.circle,
                                  border: active
                                      ? Border.all(
                                          color: theme.white, width: 2)
                                      : null,
                                ),
                                child: const SizedBox(width: 20, height: 20),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Main content
          Expanded(
            child: IndexedStack(
              index: _selectedIndex,
              children: screens,
            ),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatefulWidget {
  const _NavItem({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final PhosphorIconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = context.mantineTheme;
    final isDark = context.isDarkMode;

    Color bg;
    Color textColor;
    if (widget.selected) {
      bg = isDark
          ? theme.primaryColorScale[9].withValues(alpha: 0.35)
          : theme.primaryColorScale[0];
      textColor = theme.primaryColorScale[isDark ? 3 : theme.primaryShade];
    } else if (_hovered) {
      bg = isDark ? MantineColors.dark[5] : MantineColors.gray[0];
      textColor = context.mantineBodyText;
    } else {
      bg = const Color(0x00000000);
      textColor = context.mantineBodyText;
    }

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(theme.radius.sm),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                PhosphorIcon(widget.icon, size: 16, color: textColor),
                const SizedBox(width: 10),
                Text(
                  widget.label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: widget.selected
                        ? FontWeight.w600
                        : FontWeight.w400,
                    color: textColor,
                    fontFamily: theme.typography.fontFamily,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
