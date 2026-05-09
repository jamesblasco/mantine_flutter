import 'package:flutter/widgets.dart';
import 'package:mantine/mantine.dart';

class MapStateSection extends StatefulWidget {
  const MapStateSection({super.key});

  @override
  State<MapStateSection> createState() => _MapStateSectionState();
}

class _MapStateSectionState extends State<MapStateSection> {
  final _mapState = MantineMapState<String, String>({
    'Apple': 'Red',
    'Banana': 'Yellow',
  });

  @override
  void dispose() {
    _mapState.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _mapState,
      builder: (context, map, _) {
        return MantineStack(
          children: [
            const MantineText(
              'Observable map with helper methods for common operations.',
              dimmed: true,
              size: MantineSize.sm,
            ),
            if (map.isEmpty)
              const MantineText('Map is empty', dimmed: true)
            else
              ...map.entries.map(
                (e) => MantineGroup(
                  justify: MainAxisAlignment.spaceBetween,
                  children: [
                    MantineText('${e.key}: ${e.value}'),
                    MantineButton(
                      size: MantineSize.xs,
                      variant: MantineButtonVariant.subtle,
                      color: 'red',
                      onPressed: () => _mapState.remove(e.key),
                      child: const Text('Remove'),
                    ),
                  ],
                ),
              ),
            MantineGroup(
              children: [
                MantineButton(
                  onPressed: () => _mapState.set('Orange', 'Orange'),
                  child: const Text('Add Orange'),
                ),
                MantineButton(
                  onPressed: () => _mapState.merge({
                    'Grape': 'Purple',
                    'Kiwi': 'Green',
                  }),
                  variant: MantineButtonVariant.outline,
                  child: const Text('Merge multiple'),
                ),
                MantineButton(
                  onPressed: _mapState.clear,
                  variant: MantineButtonVariant.subtle,
                  color: 'gray',
                  child: const Text('Clear all'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
