import 'package:flutter/foundation.dart';
import 'size.dart';

@immutable
class MantineBreakpoints {
  const MantineBreakpoints({
    this.xs = 576.0,
    this.sm = 768.0,
    this.md = 992.0,
    this.lg = 1200.0,
    this.xl = 1400.0,
  });

  final double xs;
  final double sm;
  final double md;
  final double lg;
  final double xl;

  double resolve(MantineSize size) => switch (size) {
    MantineSize.xs => xs,
    MantineSize.sm => sm,
    MantineSize.md => md,
    MantineSize.lg => lg,
    MantineSize.xl => xl,
  };

  MantineBreakpoints copyWith({
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
  }) =>
      MantineBreakpoints(
        xs: xs ?? this.xs,
        sm: sm ?? this.sm,
        md: md ?? this.md,
        lg: lg ?? this.lg,
        xl: xl ?? this.xl,
      );
}
