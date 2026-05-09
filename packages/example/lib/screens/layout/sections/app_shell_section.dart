import 'package:flutter/widgets.dart';
import 'package:mantine/mantine.dart';

class AppShellSection extends StatelessWidget {
  const AppShellSection({super.key});

  @override
  Widget build(BuildContext context) {
    return MantineStack(
      children: [
        const MantineText('MantineAppShell provides a high-level layout structure.'),
        Container(
          height: 400,
          decoration: BoxDecoration(
            border: Border.all(color: context.mantineBorder),
          ),
          child: MantineAppShell(
            padding: MantineSize.md,
            header: _Header(),
            navbar: _Navbar(),
            aside: _Aside(),
            footer: _Footer(),
            child: const _MainContent(),
          ),
        ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MantineBox(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      border: Border(bottom: BorderSide(color: context.mantineBorder)),
      child: Row(
        children: [
          MantineActionIcon(
            onPressed: () => MantineAppShell.of(context).toggleNavbar(),
            child: const _MenuIcon(),
          ),
          const SizedBox(width: 16),
          const MantineText('Header', weight: FontWeight.bold),
        ],
      ),
    );
  }
}

class _Navbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MantineBox(
      width: 200,
      border: Border(right: BorderSide(color: context.mantineBorder)),
      padding: const EdgeInsets.all(16),
      child: const MantineText('Navbar'),
    );
  }
}

class _Aside extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MantineBox(
      width: 200,
      border: Border(left: BorderSide(color: context.mantineBorder)),
      padding: const EdgeInsets.all(16),
      child: const MantineText('Aside'),
    );
  }
}

class _Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MantineBox(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      border: Border(top: BorderSide(color: context.mantineBorder)),
      alignment: Alignment.centerLeft,
      child: const MantineText('Footer', size: MantineSize.sm),
    );
  }
}

class _MainContent extends StatelessWidget {
  const _MainContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const MantineTitle('Main Content', order: MantineTitleOrder.h3),
        const SizedBox(height: 16),
        const MantineText('Resize the window or use the toggle buttons to see the shell in action.'),
        const SizedBox(height: 16),
        MantineButton(
          onPressed: () => MantineAppShell.of(context).toggleAside(),
          child: const MantineText('Toggle Aside'),
        ),
      ],
    );
  }
}

class _MenuIcon extends StatelessWidget {
  const _MenuIcon();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(18, 18),
      painter: _MenuPainter(color: context.mantineBodyText),
    );
  }
}

class _MenuPainter extends CustomPainter {
  final Color color;

  _MenuPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(Offset(0, size.height * 0.25), Offset(size.width, size.height * 0.25), paint);
    canvas.drawLine(Offset(0, size.height * 0.5), Offset(size.width, size.height * 0.5), paint);
    canvas.drawLine(Offset(0, size.height * 0.75), Offset(size.width, size.height * 0.75), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
