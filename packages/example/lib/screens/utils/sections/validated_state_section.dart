import 'package:flutter/widgets.dart';
import 'package:mantine/mantine.dart';

class ValidatedStateSection extends StatefulWidget {
  const ValidatedStateSection({super.key});

  @override
  State<ValidatedStateSection> createState() => _ValidatedStateSectionState();
}

class _ValidatedStateSectionState extends State<ValidatedStateSection> {
  final emailState = MantineValidatedState<String>(
    '',
    (value) => value.isEmpty
        ? 'Email is required'
        : !value.contains('@')
            ? 'Invalid email'
            : null,
  );

  @override
  void dispose() {
    emailState.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: emailState,
      builder: (context, _) {
        return MantineStack(
          children: [
            const MantineText(
              'Enter a valid email address to clear the error state.',
              size: MantineSize.sm,
              dimmed: true,
            ),
            ...MantineSize.values.map((size) => MantineTextInput(
                  label: 'Email (${size.name})',
                  placeholder: 'hello@mantine.dev',
                  value: emailState.value,
                  error: emailState.error,
                  size: size,
                  onChanged: emailState.set,
                )),
          ],
        );
      },
    );
  }
}
