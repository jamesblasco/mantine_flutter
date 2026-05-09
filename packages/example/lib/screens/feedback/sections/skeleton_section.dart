import 'package:flutter/widgets.dart';
import 'package:mantine/mantine.dart';

class SkeletonSection extends StatefulWidget {
  const SkeletonSection({super.key});

  @override
  State<SkeletonSection> createState() => _SkeletonSectionState();
}

class _SkeletonSectionState extends State<SkeletonSection> {
  bool _visible = true;

  @override
  Widget build(BuildContext context) {
    return MantineStack(
      spacing: MantineSize.md,
      children: [
        const MantineSkeleton(height: 50),
        const MantineSkeleton(height: 8, radius: MantineSize.xl),
        const MantineSkeleton(height: 8, radius: MantineSize.xl, width: 0.7 * 300),
        const MantineSkeleton(height: 8, radius: MantineSize.xl, width: 0.5 * 300),

        const MantineText('Circle'),
        const MantineSkeleton(height: 50, circle: true),

        const MantineText('Animate: false'),
        const MantineSkeleton(height: 50, animate: false),

        const MantineText('Visible prop'),
        MantineSkeleton(
          visible: _visible,
          child: const MantineText(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
            'Suspendisse elementum feugiat dui, ac elementum risus pretium at.',
          ),
        ),
        MantineButton(
          onPressed: () => setState(() => _visible = !_visible),
          child: MantineText(_visible ? 'Show content' : 'Hide content'),
        ),
      ],
    );
  }
}
