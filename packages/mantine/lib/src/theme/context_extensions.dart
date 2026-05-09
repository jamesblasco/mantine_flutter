import 'package:flutter/widgets.dart';
import '../foundation/colors.dart';
import 'mantine_provider.dart';
import 'mantine_theme_data.dart';

extension MantineContext on BuildContext {
  MantineThemeScope get _scope => MantineThemeScope.of(this);

  MantineThemeData get mantineTheme => _scope.themeData;
  Brightness get mantineBrightness => _scope.brightness;
  bool get isDarkMode => mantineBrightness == Brightness.dark;

  Color get mantinePrimaryColor => mantineTheme.primaryColorValue;

  Color get mantineBackground => isDarkMode
      ? MantineColors.dark[7]
      : mantineTheme.white;

  Color get mantineSurface => isDarkMode
      ? MantineColors.dark[6]
      : mantineTheme.white;

  Color get mantineBodyText => isDarkMode
      ? MantineColors.dark[0]
      : MantineColors.dark[9];

  Color get mantineDimmedText => isDarkMode
      ? MantineColors.dark[2]
      : MantineColors.gray[6];

  Color get mantineBorder => isDarkMode
      ? MantineColors.dark[4]
      : MantineColors.gray[3];

  MantineColorScale mantineColor(String name) =>
      mantineTheme.colors.resolve(name);
}
