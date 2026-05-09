import 'package:flutter/widgets.dart';
import 'package:mantine/mantine.dart';

class ThrottledCounterSection extends StatefulWidget {
  const ThrottledCounterSection({super.key});

  @override
  State<ThrottledCounterSection> createState() =>
      _ThrottledCounterSectionState();
}

class _ThrottledCounterSectionState extends State<ThrottledCounterSection> {
  final _counter = MantineThrottled<int>(
    0,
    duration: const Duration(seconds: 1),
  );

  @override
  void dispose() {
    _counter.dispose();
    super.dispose();
  }

  void _decrement() => _counter.value = _counter.value - 1;
  void _increment() => _counter.value = _counter.value + 1;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _counter,
      builder: (context, value, _) {
        return MantineStack(
          align: CrossAxisAlignment.start,
          children: [
            MantineText(
              'Count (throttled 1s): $value (Updates only once per second)',
            ),
            MantineGroup(
              children: [
                MantineButton(onPressed: _decrement, child: const Text('-')),
                MantineButton(onPressed: _increment, child: const Text('+')),
              ],
            ),
            const MantineText('Different sizes:'),
            ...MantineSize.values.map((s) => MantineGroup(
                  children: [
                    MantineButton(
                      onPressed: _decrement,
                      size: s,
                      child: const Text('-'),
                    ),
                    MantineText('$value', size: s),
                    MantineButton(
                      onPressed: _increment,
                      size: s,
                      child: const Text('+'),
                    ),
                  ],
                )),
          ],
        );
      },
    );
  }
}
