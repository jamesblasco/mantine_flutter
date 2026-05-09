import 'package:flutter/widgets.dart';
import '../../foundation/size.dart';
import '../../theme/context_extensions.dart';

class MantineInputLabel extends StatelessWidget {
  const MantineInputLabel({
    super.key,
    required this.label,
    required this.required,
    required this.size,
  });

  final String label;
  final bool required;
  final MantineSize size;

  @override
  Widget build(BuildContext context) {
    final theme = context.mantineTheme;
    final fontSize = switch (size) {
      MantineSize.xs => 11.0,
      MantineSize.sm => 13.0,
      MantineSize.md => 14.0,
      MantineSize.lg => 16.0,
      MantineSize.xl => 18.0,
    };

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w500,
            color: context.mantineBodyText,
            fontFamily: theme.typography.fontFamily,
          ),
        ),
        if (required)
          Text(
            ' *',
            style: TextStyle(
              fontSize: fontSize,
              color: theme.colors.resolve('red')[6],
              fontFamily: theme.typography.fontFamily,
            ),
          ),
      ],
    );
  }
}

class MantineInputDescription extends StatelessWidget {
  const MantineInputDescription({
    super.key,
    required this.description,
    required this.size,
  });

  final String description;
  final MantineSize size;

  @override
  Widget build(BuildContext context) {
    final theme = context.mantineTheme;
    final fontSize = switch (size) {
      MantineSize.xs => 10.0,
      MantineSize.sm => 11.0,
      MantineSize.md => 12.0,
      MantineSize.lg => 13.0,
      MantineSize.xl => 14.0,
    };

    return Text(
      description,
      style: TextStyle(
        fontSize: fontSize,
        color: context.mantineDimmedText,
        fontFamily: theme.typography.fontFamily,
      ),
    );
  }
}

class MantineInputError extends StatelessWidget {
  const MantineInputError({
    super.key,
    required this.error,
    required this.size,
  });

  final String error;
  final MantineSize size;

  @override
  Widget build(BuildContext context) {
    final theme = context.mantineTheme;
    final fontSize = switch (size) {
      MantineSize.xs => 10.0,
      MantineSize.sm => 11.0,
      MantineSize.md => 12.0,
      MantineSize.lg => 13.0,
      MantineSize.xl => 14.0,
    };

    return Text(
      error,
      style: TextStyle(
        fontSize: fontSize,
        color: theme.colors.resolve('red')[6],
        fontFamily: theme.typography.fontFamily,
      ),
    );
  }
}
