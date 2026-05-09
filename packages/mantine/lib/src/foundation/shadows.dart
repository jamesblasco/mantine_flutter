import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'size.dart';

@immutable
class MantineShadows {
  const MantineShadows({
    this.xs = const [
      BoxShadow(
          color: Color(0x11000000), blurRadius: 2, offset: Offset(0, 1)),
    ],
    this.sm = const [
      BoxShadow(
          color: Color(0x14000000), blurRadius: 4, offset: Offset(0, 1)),
      BoxShadow(
          color: Color(0x0D000000), blurRadius: 2, offset: Offset(0, 2)),
    ],
    this.md = const [
      BoxShadow(
          color: Color(0x14000000), blurRadius: 8, offset: Offset(0, 2)),
      BoxShadow(
          color: Color(0x0D000000), blurRadius: 4, offset: Offset(0, 4)),
    ],
    this.lg = const [
      BoxShadow(
          color: Color(0x14000000), blurRadius: 16, offset: Offset(0, 4)),
      BoxShadow(
          color: Color(0x0D000000), blurRadius: 8, offset: Offset(0, 8)),
    ],
    this.xl = const [
      BoxShadow(
          color: Color(0x14000000), blurRadius: 24, offset: Offset(0, 8)),
      BoxShadow(
          color: Color(0x0D000000), blurRadius: 12, offset: Offset(0, 16)),
    ],
  });

  final List<BoxShadow> xs;
  final List<BoxShadow> sm;
  final List<BoxShadow> md;
  final List<BoxShadow> lg;
  final List<BoxShadow> xl;

  List<BoxShadow> resolve(MantineSize size) => switch (size) {
    MantineSize.xs => xs,
    MantineSize.sm => sm,
    MantineSize.md => md,
    MantineSize.lg => lg,
    MantineSize.xl => xl,
  };
}
