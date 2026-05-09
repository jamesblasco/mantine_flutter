import 'package:flutter/painting.dart';

Color darken(Color color, double amount) {
  assert(amount >= 0 && amount <= 1);
  final hsl = HSLColor.fromColor(color);
  return hsl
      .withLightness((hsl.lightness - amount).clamp(0.0, 1.0))
      .toColor();
}

Color lighten(Color color, double amount) {
  assert(amount >= 0 && amount <= 1);
  final hsl = HSLColor.fromColor(color);
  return hsl
      .withLightness((hsl.lightness + amount).clamp(0.0, 1.0))
      .toColor();
}

Color mix(Color a, Color b, double t) {
  assert(t >= 0 && t <= 1);
  return Color.fromARGB(
    ((1 - t) * a.a * 255 + t * b.a * 255).round(),
    ((1 - t) * a.r * 255 + t * b.r * 255).round(),
    ((1 - t) * a.g * 255 + t * b.g * 255).round(),
    ((1 - t) * a.b * 255 + t * b.b * 255).round(),
  );
}

abstract class MantineColorUtils {
  MantineColorUtils._();

  static Color getContrastColor(Color color) {
    // Standard relative luminance formula
    final double luminance =
        (0.299 * color.r + 0.587 * color.g + 0.114 * color.b);
    return luminance > 0.5 ? const Color(0xFF000000) : const Color(0xFFFFFFFF);
  }
}
