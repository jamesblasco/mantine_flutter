import 'package:flutter/widgets.dart';
import '../../foundation/colors.dart';
import '../../foundation/size.dart';
import '../../theme/context_extensions.dart';
import '../data_display/divider.dart';
import '../layout/paper.dart';
import 'popover.dart';

class MantineMenu extends StatefulWidget {
  const MantineMenu({
    super.key,
    required this.target,
    required this.dropdown,
    this.opened,
    this.onChange,
    this.onOpen,
    this.onClose,
    this.closeOnItemClick = true,
    this.closeOnClickOutside = true,
    this.position = MantinePopoverPosition.bottomStart,
    this.offset = 5.0,
    this.withArrow = false,
    this.shadow = MantineSize.md,
    this.radius,
    this.width,
    this.size = MantineSize.md,
  });

  final Widget target;
  final Widget dropdown;
  final bool? opened;
  final ValueChanged<bool>? onChange;
  final VoidCallback? onOpen;
  final VoidCallback? onClose;
  final bool closeOnItemClick;
  final bool closeOnClickOutside;
  final MantinePopoverPosition position;
  final double offset;
  final bool withArrow;
  final MantineSize shadow;
  final MantineSize? radius;
  final double? width;
  final MantineSize size;

  static MantineMenuState? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_MantineMenuProvider>()?.state;
  }

  @override
  State<MantineMenu> createState() => MantineMenuState();
}

class MantineMenuState extends State<MantineMenu> {
  bool _opened = false;

  bool get opened => widget.opened ?? _opened;

  void _setOpened(bool value) {
    if (opened == value) return;
    if (widget.opened == null) {
      setState(() => _opened = value);
    }
    widget.onChange?.call(value);
    if (value) {
      widget.onOpen?.call();
    } else {
      widget.onClose?.call();
    }
  }

  void toggle() => _setOpened(!opened);
  void open() => _setOpened(true);
  void close() => _setOpened(false);

  @override
  Widget build(BuildContext context) {
    final menuProvider = _MantineMenuProvider(
      state: this,
      opened: opened,
      size: widget.size,
      closeOnItemClick: widget.closeOnItemClick,
      width: widget.width,
      child: widget.dropdown,
    );

    return _MantineMenuProvider(
      state: this,
      opened: opened,
      size: widget.size,
      closeOnItemClick: widget.closeOnItemClick,
      width: widget.width,
      child: MantinePopover(
        opened: opened,
        onClose: widget.closeOnClickOutside ? close : null,
        position: widget.position,
        offset: widget.offset,
        withArrow: widget.withArrow,
        shadow: widget.shadow,
        radius: widget.radius,
        dropdownPadding: EdgeInsets.zero,
        target: widget.target,
        content: menuProvider,
      ),
    );
  }
}

class _MantineMenuProvider extends InheritedWidget {
  const _MantineMenuProvider({
    required super.child,
    required this.state,
    required this.opened,
    required this.size,
    required this.closeOnItemClick,
    this.width,
  });

  final MantineMenuState state;
  final bool opened;
  final MantineSize size;
  final bool closeOnItemClick;
  final double? width;

  @override
  bool updateShouldNotify(_MantineMenuProvider oldWidget) {
    return opened != oldWidget.opened ||
        size != oldWidget.size ||
        closeOnItemClick != oldWidget.closeOnItemClick ||
        width != oldWidget.width;
  }
}

class MantineMenuTarget extends StatelessWidget {
  const MantineMenuTarget({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final state = MantineMenu.of(context);
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: (_) => state?.toggle(),
      child: child,
    );
  }
}

class MantineMenuDropdown extends StatelessWidget {
  const MantineMenuDropdown({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final state = MantineMenu.of(context);

    return SizedBox(
      width: state?.widget.width,
      child: MantinePaper(
        shadow: null, // Shadow is handled by Popover
        withBorder: true,
        radius: null, // Radius is handled by Popover
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: children,
          ),
        ),
      ),
    );
  }
}

class MantineMenuItem extends StatefulWidget {
  const MantineMenuItem({
    super.key,
    required this.child,
    this.onPressed,
    this.leftSection,
    this.rightSection,
    this.color,
    this.disabled = false,
  });

  final Widget child;
  final VoidCallback? onPressed;
  final Widget? leftSection;
  final Widget? rightSection;
  final String? color;
  final bool disabled;

  @override
  State<MantineMenuItem> createState() => _MantineMenuItemState();
}

class _MantineMenuItemState extends State<MantineMenuItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = context.mantineTheme;
    final state = MantineMenu.of(context);
    final size = state?.widget.size ?? MantineSize.md;

    final colorScale =
        widget.color != null ? theme.colors.resolve(widget.color!) : null;

    Color? bg;
    Color textColor =
        colorScale != null ? colorScale[6] : context.mantineBodyText;

    if (widget.disabled) {
      textColor = context.mantineDimmedText;
    } else if (_hovered) {
      bg = context.isDarkMode ? MantineColors.dark[4] : MantineColors.gray[0];
      if (colorScale != null) {
        bg = colorScale[context.isDarkMode ? 9 : 0].withValues(alpha: 0.1);
      }
    }

    final fontSize = switch (size) {
      MantineSize.xs => 12.0,
      MantineSize.sm => 13.0,
      MantineSize.md => 14.0,
      MantineSize.lg => 16.0,
      MantineSize.xl => 18.0,
    };

    final padding = switch (size) {
      MantineSize.xs => const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      MantineSize.sm => const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      MantineSize.md => const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      MantineSize.lg =>
        const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      MantineSize.xl =>
        const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    };

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: widget.disabled
          ? SystemMouseCursors.forbidden
          : SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          if (widget.disabled) return;
          widget.onPressed?.call();
          if (state?.widget.closeOnItemClick ?? true) {
            state?.close();
          }
        },
        child: Container(
          padding: padding,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(theme.radius.sm),
          ),
          child: Row(
            children: [
              if (widget.leftSection != null) ...[
                IconTheme.merge(
                  data: IconThemeData(
                      size: fontSize + 2, color: textColor),
                  child: widget.leftSection!,
                ),
                const SizedBox(width: 10),
              ],
              Expanded(
                child: DefaultTextStyle.merge(
                  style: TextStyle(
                    fontSize: fontSize,
                    color: textColor,
                    fontWeight: FontWeight.w400,
                    fontFamily: theme.typography.fontFamily,
                  ),
                  child: widget.child,
                ),
              ),
              if (widget.rightSection != null) ...[
                const SizedBox(width: 10),
                DefaultTextStyle.merge(
                  style: TextStyle(
                    fontSize: fontSize - 2,
                    color: context.mantineDimmedText,
                    fontFamily: theme.typography.fontFamily,
                  ),
                  child: widget.rightSection!,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class MantineMenuLabel extends StatelessWidget {
  const MantineMenuLabel({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = context.mantineTheme;
    final state = MantineMenu.of(context);
    final size = state?.widget.size ?? MantineSize.md;

    final fontSize = switch (size) {
      MantineSize.xs => 10.0,
      MantineSize.sm => 11.0,
      MantineSize.md => 12.0,
      MantineSize.lg => 14.0,
      MantineSize.xl => 16.0,
    };

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: DefaultTextStyle.merge(
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w700,
          color: context.mantineDimmedText,
          fontFamily: theme.typography.fontFamily,
          textBaseline: TextBaseline.alphabetic,
        ),
        child: child,
      ),
    );
  }
}

class MantineMenuDivider extends StatelessWidget {
  const MantineMenuDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: MantineDivider(),
    );
  }
}
