import 'package:flutter/painting.dart';
import 'package:flutter/foundation.dart';
import 'size.dart';

@immutable
class MantineTypography {
  const MantineTypography({
    this.fontFamily =
        '-apple-system, BlinkMacSystemFont, Segoe UI, Roboto, Helvetica, Arial, sans-serif',
    this.xs = const TextStyle(fontSize: 10, height: 1.4),
    this.sm = const TextStyle(fontSize: 12, height: 1.45),
    this.md = const TextStyle(fontSize: 14, height: 1.55),
    this.lg = const TextStyle(fontSize: 16, height: 1.5),
    this.xl = const TextStyle(fontSize: 20, height: 1.5),
    this.h1 = const TextStyle(
        fontSize: 34, fontWeight: FontWeight.w700, height: 1.3),
    this.h2 = const TextStyle(
        fontSize: 26, fontWeight: FontWeight.w700, height: 1.35),
    this.h3 = const TextStyle(
        fontSize: 22, fontWeight: FontWeight.w700, height: 1.4),
    this.h4 = const TextStyle(
        fontSize: 18, fontWeight: FontWeight.w700, height: 1.45),
    this.h5 = const TextStyle(
        fontSize: 16, fontWeight: FontWeight.w700, height: 1.5),
    this.h6 = const TextStyle(
        fontSize: 14, fontWeight: FontWeight.w700, height: 1.5),
  });

  final String fontFamily;
  final TextStyle xs;
  final TextStyle sm;
  final TextStyle md;
  final TextStyle lg;
  final TextStyle xl;
  final TextStyle h1;
  final TextStyle h2;
  final TextStyle h3;
  final TextStyle h4;
  final TextStyle h5;
  final TextStyle h6;

  TextStyle resolveSize(MantineSize size) => switch (size) {
    MantineSize.xs => xs,
    MantineSize.sm => sm,
    MantineSize.md => md,
    MantineSize.lg => lg,
    MantineSize.xl => xl,
  };

  MantineTypography copyWith({
    String? fontFamily,
    TextStyle? xs,
    TextStyle? sm,
    TextStyle? md,
    TextStyle? lg,
    TextStyle? xl,
    TextStyle? h1,
    TextStyle? h2,
    TextStyle? h3,
    TextStyle? h4,
    TextStyle? h5,
    TextStyle? h6,
  }) =>
      MantineTypography(
        fontFamily: fontFamily ?? this.fontFamily,
        xs: xs ?? this.xs,
        sm: sm ?? this.sm,
        md: md ?? this.md,
        lg: lg ?? this.lg,
        xl: xl ?? this.xl,
        h1: h1 ?? this.h1,
        h2: h2 ?? this.h2,
        h3: h3 ?? this.h3,
        h4: h4 ?? this.h4,
        h5: h5 ?? this.h5,
        h6: h6 ?? this.h6,
      );
}
