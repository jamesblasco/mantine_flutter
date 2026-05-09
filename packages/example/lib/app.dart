import 'package:flutter/widgets.dart';
import 'package:mantine/mantine.dart';
import 'screens/home_screen.dart';

class MantineGalleryApp extends StatefulWidget {
  const MantineGalleryApp({super.key});

  @override
  State<MantineGalleryApp> createState() => _MantineGalleryAppState();
}

class _MantineGalleryAppState extends State<MantineGalleryApp> {
  Brightness _brightness = Brightness.light;
  String _primaryColor = 'blue';

  void _toggleTheme() => setState(() {
        _brightness = _brightness == Brightness.light ? Brightness.dark : Brightness.light;
      });

  void _setPrimaryColor(String color) => setState(() => _primaryColor = color);

  @override
  Widget build(BuildContext context) {
    return MantineProvider(
      theme: MantineThemeData(primaryColor: _primaryColor),
      brightness: _brightness,
      child: WidgetsApp(
        title: 'Mantine Flutter Gallery',
        color: MantineColors.blue[6],
        pageRouteBuilder: <T>(settings, builder) {
          return PageRouteBuilder<T>(
            settings: settings,
            pageBuilder: (context, animation, secondaryAnimation) => builder(context),
          );
        },
        home: HomeScreen(
          onToggleTheme: _toggleTheme,
          onPrimaryColorChange: _setPrimaryColor,
          currentPrimaryColor: _primaryColor,
          isDark: _brightness == Brightness.dark,
        ),
      ),
    );
  }
}
