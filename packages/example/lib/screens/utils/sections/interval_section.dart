import 'package:flutter/widgets.dart';
import 'package:mantine/mantine.dart';

class IntervalSection extends StatefulWidget {
  const IntervalSection({super.key});

  @override
  State<IntervalSection> createState() => _IntervalSectionState();
}

class _IntervalSectionState extends State<IntervalSection> {
  late final MantineInterval _interval;
  int _seconds = 0;

  @override
  void initState() {
    super.initState();
    _interval = MantineInterval(const Duration(seconds: 1), () {
      setState(() => _seconds++);
    });
  }

  @override
  void dispose() {
    _interval.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _interval,
      builder: (context, _) {
        return MantineStack(
          children: [
            MantineText('Seconds passed: $_seconds'),
            MantineText(
              'Interval is currently ${_interval.active ? 'active' : 'inactive'}',
              dimmed: true,
              size: MantineSize.sm,
            ),
            MantineGroup(
              children: [
                MantineButton(
                  onPressed: _interval.active ? null : _interval.start,
                  color: 'teal',
                  child: const Text('Start'),
                ),
                MantineButton(
                  onPressed: !_interval.active ? null : _interval.stop,
                  color: 'red',
                  child: const Text('Stop'),
                ),
                MantineButton(
                  onPressed: _interval.toggle,
                  variant: MantineButtonVariant.outline,
                  child: const Text('Toggle'),
                ),
              ],
            ),
            const MantineText('Sizing variants:'),
            MantineGroup(
              align: CrossAxisAlignment.center,
              children: MantineSize.values.map((s) {
                return MantineButton(
                  onPressed: _interval.toggle,
                  size: s,
                  child: Text(s.name.toUpperCase()),
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }
}
