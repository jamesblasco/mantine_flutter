import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mantine/mantine.dart';

void main() {
  Widget buildAppShell({
    Widget? header,
    Widget? navbar,
    Widget? aside,
    Widget? footer,
    bool navbarCollapsed = false,
    bool asideCollapsed = false,
  }) {
    return MantineProvider(
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: MantineAppShell(
          header: header,
          navbar: navbar,
          aside: aside,
          footer: footer,
          navbarCollapsed: navbarCollapsed,
          asideCollapsed: asideCollapsed,
          child: const Text('Main Content'),
        ),
      ),
    );
  }

  testWidgets('renders all sections', (tester) async {
    await tester.pumpWidget(buildAppShell(
      header: const Text('Header'),
      navbar: const Text('Navbar'),
      aside: const Text('Aside'),
      footer: const Text('Footer'),
    ));

    expect(find.text('Header'), findsOneWidget);
    expect(find.text('Navbar'), findsOneWidget);
    expect(find.text('Aside'), findsOneWidget);
    expect(find.text('Footer'), findsOneWidget);
    expect(find.text('Main Content'), findsOneWidget);
  });

  testWidgets('handles navbar collapse', (tester) async {
    await tester.pumpWidget(buildAppShell(
      navbar: const Text('Navbar'),
      navbarCollapsed: true,
    ));

    expect(find.text('Navbar'), findsNothing);

    // Toggle navbar
    final state = tester.state<MantineAppShellState>(find.byType(MantineAppShell));
    state.toggleNavbar();
    await tester.pump();

    expect(find.text('Navbar'), findsOneWidget);
  });

  testWidgets('handles aside collapse', (tester) async {
    await tester.pumpWidget(buildAppShell(
      aside: const Text('Aside'),
      asideCollapsed: true,
    ));

    expect(find.text('Aside'), findsNothing);

    // Toggle aside
    final state = tester.state<MantineAppShellState>(find.byType(MantineAppShell));
    state.toggleAside();
    await tester.pump();

    expect(find.text('Aside'), findsOneWidget);
  });

  testWidgets('MantineAppShell.of provides access to state', (tester) async {
    late MantineAppShellState capturedState;
    await tester.pumpWidget(
      MantineProvider(
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: MantineAppShell(
            child: Builder(builder: (context) {
              capturedState = MantineAppShell.of(context);
              return const SizedBox();
            }),
          ),
        ),
      ),
    );

    expect(capturedState, isNotNull);
    expect(capturedState.navbarCollapsed, isFalse);

    capturedState.toggleNavbar();
    await tester.pump();
    expect(capturedState.navbarCollapsed, isTrue);
  });
}
