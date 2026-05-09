import 'package:flutter/widgets.dart';
import '../../foundation/size.dart';
import '../../theme/context_extensions.dart';

class MantineAppShell extends StatefulWidget {
  const MantineAppShell({
    super.key,
    required this.child,
    this.header,
    this.navbar,
    this.aside,
    this.footer,
    this.padding,
    this.navbarCollapsed = false,
    this.asideCollapsed = false,
  });

  final Widget child;
  final Widget? header;
  final Widget? navbar;
  final Widget? aside;
  final Widget? footer;
  final MantineSize? padding;
  final bool navbarCollapsed;
  final bool asideCollapsed;

  static MantineAppShellState of(BuildContext context) {
    final _MantineAppShellScope? scope =
        context.dependOnInheritedWidgetOfExactType<_MantineAppShellScope>();
    assert(scope != null, 'No MantineAppShell found in widget tree.');
    return scope!.state;
  }

  @override
  State<MantineAppShell> createState() => MantineAppShellState();
}

class MantineAppShellState extends State<MantineAppShell> {
  late bool _navbarCollapsed;
  late bool _asideCollapsed;

  bool get navbarCollapsed => _navbarCollapsed;
  bool get asideCollapsed => _asideCollapsed;

  @override
  void initState() {
    super.initState();
    _navbarCollapsed = widget.navbarCollapsed;
    _asideCollapsed = widget.asideCollapsed;
  }

  @override
  void didUpdateWidget(MantineAppShell oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.navbarCollapsed != oldWidget.navbarCollapsed) {
      _navbarCollapsed = widget.navbarCollapsed;
    }
    if (widget.asideCollapsed != oldWidget.asideCollapsed) {
      _asideCollapsed = widget.asideCollapsed;
    }
  }

  void toggleNavbar() {
    setState(() {
      _navbarCollapsed = !_navbarCollapsed;
    });
  }

  void toggleAside() {
    setState(() {
      _asideCollapsed = !_asideCollapsed;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.mantineTheme;
    final resolvedPadding = widget.padding != null
        ? EdgeInsets.all(theme.spacing.resolve(widget.padding!))
        : EdgeInsets.zero;

    return _MantineAppShellScope(
      state: this,
      navbarCollapsed: _navbarCollapsed,
      asideCollapsed: _asideCollapsed,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.mantineBackground,
        ),
        child: Column(
          children: [
            if (widget.header != null) widget.header!,
            Expanded(
              child: Row(
                children: [
                  if (widget.navbar != null && !_navbarCollapsed) widget.navbar!,
                  Expanded(
                    child: Padding(
                      padding: resolvedPadding,
                      child: widget.child,
                    ),
                  ),
                  if (widget.aside != null && !_asideCollapsed) widget.aside!,
                ],
              ),
            ),
            if (widget.footer != null) widget.footer!,
          ],
        ),
      ),
    );
  }
}

class _MantineAppShellScope extends InheritedWidget {
  const _MantineAppShellScope({
    required this.state,
    required this.navbarCollapsed,
    required this.asideCollapsed,
    required super.child,
  });

  final MantineAppShellState state;
  final bool navbarCollapsed;
  final bool asideCollapsed;

  @override
  bool updateShouldNotify(_MantineAppShellScope oldWidget) =>
      navbarCollapsed != oldWidget.navbarCollapsed ||
      asideCollapsed != oldWidget.asideCollapsed;
}
