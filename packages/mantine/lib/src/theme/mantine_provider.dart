import 'package:flutter/widgets.dart';
import 'mantine_theme_data.dart';

class MantineThemeScope extends InheritedWidget {
  const MantineThemeScope({
    super.key,
    required this.themeData,
    required this.brightness,
    required super.child,
  });

  final MantineThemeData themeData;
  final Brightness brightness;

  @override
  bool updateShouldNotify(MantineThemeScope old) =>
      themeData != old.themeData || brightness != old.brightness;

  static MantineThemeScope of(BuildContext context) {
    final scope =
        context.dependOnInheritedWidgetOfExactType<MantineThemeScope>();
    assert(scope != null, 'No MantineProvider found in widget tree.');
    return scope!;
  }
}

class MantineProvider extends StatefulWidget {
  const MantineProvider({
    super.key,
    required this.child,
    this.theme = const MantineThemeData(),
    this.brightness = Brightness.light,
  });

  final Widget child;
  final MantineThemeData theme;
  final Brightness brightness;

  @override
  State<MantineProvider> createState() => _MantineProviderState();
}

class _MantineProviderState extends State<MantineProvider> {
  @override
  Widget build(BuildContext context) => MantineThemeScope(
        themeData: widget.theme,
        brightness: widget.brightness,
        child: widget.child,
      );
}
