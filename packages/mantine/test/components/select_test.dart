import 'package:flutter_test/flutter_test.dart';
import 'package:mantine/mantine.dart';
import 'package:flutter/widgets.dart';

void main() {
  Widget buildSelect({
    List<dynamic> data = const ['React', 'Angular', 'Vue'],
    String? value,
    ValueChanged<String?>? onChanged,
    bool searchable = false,
    bool clearable = false,
    bool creatable = false,
  }) {
    return MantineProvider(
      child: WidgetsApp(
        color: const Color(0xFF000000),
        pageRouteBuilder: <T>(RouteSettings settings, WidgetBuilder builder) {
          return PageRouteBuilder<T>(
            settings: settings,
            pageBuilder: (context, animation, secondaryAnimation) => builder(context),
          );
        },
        home: Center(
          child: SizedBox(
            width: 300,
            child: MantineSelect(
              data: data,
              value: value,
              onChanged: onChanged,
              searchable: searchable,
              clearable: clearable,
              creatable: creatable,
            ),
          ),
        ),
      ),
    );
  }

  testWidgets('renders placeholder', (tester) async {
    await tester.pumpWidget(MantineProvider(
      child: WidgetsApp(
        color: const Color(0xFF000000),
        pageRouteBuilder: <T>(RouteSettings settings, WidgetBuilder builder) {
          return PageRouteBuilder<T>(
            settings: settings,
            pageBuilder: (context, animation, secondaryAnimation) => builder(context),
          );
        },
        home: const Center(
          child: SizedBox(
            width: 300,
            child: MantineSelect(
              data: ['React'],
              placeholder: 'Pick one',
            ),
          ),
        ),
      ),
    ));
    expect(find.text('Pick one'), findsOneWidget);
  });

  testWidgets('opens dropdown on tap', (tester) async {
    await tester.pumpWidget(buildSelect());
    await tester.tap(find.byType(MantineTextInput));
    await tester.pumpAndSettle();
    expect(find.text('React'), findsOneWidget);
    expect(find.text('Angular'), findsOneWidget);
    expect(find.text('Vue'), findsOneWidget);
  });

  testWidgets('selects an item', (tester) async {
    String? selectedValue;
    await tester.pumpWidget(buildSelect(onChanged: (v) => selectedValue = v));

    await tester.tap(find.byType(MantineTextInput));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Vue'));
    await tester.pumpAndSettle();

    expect(selectedValue, 'Vue');
    expect(find.text('Vue'), findsOneWidget); // In the input field
  });

  testWidgets('filters items when searchable', (tester) async {
    await tester.pumpWidget(buildSelect(searchable: true));

    await tester.tap(find.byType(MantineTextInput));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(EditableText), 're');
    await tester.pumpAndSettle();

    expect(find.text('React'), findsOneWidget);
    expect(find.text('Angular'), findsNothing);
    expect(find.text('Vue'), findsNothing);
  });

  testWidgets('shows create option when creatable', (tester) async {
    await tester.pumpWidget(buildSelect(searchable: true, creatable: true));

    await tester.tap(find.byType(MantineTextInput));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(EditableText), 'NextJS');
    await tester.pumpAndSettle();

    expect(find.text('Create "NextJS"'), findsOneWidget);
  });

  testWidgets('clears value when clearable icon is tapped', (tester) async {
    String? selectedValue = 'React';
    await tester.pumpWidget(buildSelect(
      value: selectedValue,
      clearable: true,
      onChanged: (v) => selectedValue = v,
    ));

    await tester.tap(find.byKey(const ValueKey('clear-icon')));
    await tester.pumpAndSettle();

    expect(selectedValue, isNull);
  });
}
