import 'package:flutter/widgets.dart';
import '../../foundation/colors.dart';
import '../../foundation/size.dart';
import '../../theme/context_extensions.dart';

class MantineKbd extends StatelessWidget {
  const MantineKbd({
    super.key,
    required this.children,
    this.size = MantineSize.sm,
  });

  final List<Widget> children;
  final MantineSize size;

  double _getHeight(MantineSize size) => switch (size) {
        MantineSize.xs => 20.0,
        MantineSize.sm => 24.0,
        MantineSize.md => 30.0,
        MantineSize.lg => 36.0,
        MantineSize.xl => 44.0,
      };

  double _getFontSize(MantineSize size) => switch (size) {
        MantineSize.xs => 10.0,
        MantineSize.sm => 12.0,
        MantineSize.md => 14.0,
        MantineSize.lg => 16.0,
        MantineSize.xl => 20.0,
      };

  double _getPadding(MantineSize size) => switch (size) {
        MantineSize.xs => 4.0,
        MantineSize.sm => 6.0,
        MantineSize.md => 8.0,
        MantineSize.lg => 10.0,
        MantineSize.xl => 12.0,
      };

  @override
  Widget build(BuildContext context) {
    final theme = context.mantineTheme;
    final isDark = context.isDarkMode;

    final bgColor = isDark ? MantineColors.dark[5] : MantineColors.gray[0];
    final borderColor = isDark ? MantineColors.dark[4] : MantineColors.gray[3];
    final shadowColor = isDark ? MantineColors.dark[9] : MantineColors.gray[4];
    final textColor = context.mantineBodyText;

    return Container(
      height: _getHeight(size),
      padding: EdgeInsets.symmetric(horizontal: _getPadding(size)),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(theme.radius.sm),
        border: Border.all(color: borderColor, width: 1),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            offset: const Offset(0, 2),
            blurRadius: 0,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Center(
        child: DefaultTextStyle(
          style: TextStyle(
            fontSize: _getFontSize(size),
            fontWeight: FontWeight.w700,
            color: textColor,
            fontFamily: 'monospace',
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: children,
          ),
        ),
      ),
    );
  }
}
