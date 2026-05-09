import 'package:flutter/foundation.dart';
import 'size.dart';

@immutable
class MantineRadius {
  const MantineRadius({
    this.xs = 2.0,
    this.sm = 4.0,
    this.md = 8.0,
    this.lg = 16.0,
    this.xl = 32.0,
  });

  final double xs;
  final double sm;
  final double md;
  final double lg;
  final double xl;

  static const double circle = 9999.0;

  double resolve(MantineSize size) => switch (size) {
    MantineSize.xs => xs,
    MantineSize.sm => sm,
    MantineSize.md => md,
    MantineSize.lg => lg,
    MantineSize.xl => xl,
  };

  MantineRadius copyWith({
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
  }) =>
      MantineRadius(
        xs: xs ?? this.xs,
        sm: sm ?? this.sm,
        md: md ?? this.md,
        lg: lg ?? this.lg,
        xl: xl ?? this.xl,
      );
}
