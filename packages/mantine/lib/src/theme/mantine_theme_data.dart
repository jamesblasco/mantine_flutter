import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import '../foundation/size.dart';
import '../foundation/colors.dart';
import '../foundation/spacing.dart';
import '../foundation/radius.dart';
import '../foundation/typography.dart';
import '../foundation/breakpoints.dart';
import '../foundation/shadows.dart';

enum MantineFocusRing { auto, always, never }

abstract interface class MantineColorPalette {
  MantineColorScale resolve(String name);
}

class _DefaultMantineColors implements MantineColorPalette {
  const _DefaultMantineColors();

  @override
  MantineColorScale resolve(String name) => MantineColors.resolve(name);
}

@immutable
class MantineThemeData {
  const MantineThemeData({
    this.primaryColor = 'blue',
    this.primaryShade = 6,
    this.defaultRadius = MantineSize.sm,
    this.spacing = const MantineSpacing(),
    this.radius = const MantineRadius(),
    this.typography = const MantineTypography(),
    this.breakpoints = const MantineBreakpoints(),
    this.shadows = const MantineShadows(),
    this.colors = const _DefaultMantineColors(),
    this.white = const Color(0xFFFFFFFF),
    this.black = const Color(0xFF000000),
    this.focusRing = MantineFocusRing.auto,
  });

  final String primaryColor;
  final int primaryShade;
  final MantineSize defaultRadius;
  final MantineSpacing spacing;
  final MantineRadius radius;
  final MantineTypography typography;
  final MantineBreakpoints breakpoints;
  final MantineShadows shadows;
  final MantineColorPalette colors;
  final Color white;
  final Color black;
  final MantineFocusRing focusRing;

  MantineColorScale get primaryColorScale => colors.resolve(primaryColor);
  Color get primaryColorValue => primaryColorScale[primaryShade];

  MantineThemeData copyWith({
    String? primaryColor,
    int? primaryShade,
    MantineSize? defaultRadius,
    MantineSpacing? spacing,
    MantineRadius? radius,
    MantineTypography? typography,
    MantineBreakpoints? breakpoints,
    MantineShadows? shadows,
    MantineColorPalette? colors,
    Color? white,
    Color? black,
    MantineFocusRing? focusRing,
  }) =>
      MantineThemeData(
        primaryColor: primaryColor ?? this.primaryColor,
        primaryShade: primaryShade ?? this.primaryShade,
        defaultRadius: defaultRadius ?? this.defaultRadius,
        spacing: spacing ?? this.spacing,
        radius: radius ?? this.radius,
        typography: typography ?? this.typography,
        breakpoints: breakpoints ?? this.breakpoints,
        shadows: shadows ?? this.shadows,
        colors: colors ?? this.colors,
        white: white ?? this.white,
        black: black ?? this.black,
        focusRing: focusRing ?? this.focusRing,
      );
}
