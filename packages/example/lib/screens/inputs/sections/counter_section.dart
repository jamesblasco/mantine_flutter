import 'package:flutter/widgets.dart';
import 'package:mantine/mantine.dart';

class CounterSection extends StatefulWidget {
  const CounterSection({super.key});

  @override
  State<CounterSection> createState() => _CounterSectionState();
}

class _CounterSectionState extends State<CounterSection> {
  final _counter = MantineCounter(0, min: 0, max: 10);

  @override
  void dispose() {
    _counter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _counter,
      builder: (context, value, _) {
        return MantineStack(
          align: CrossAxisAlignment.start,
          children: [
            MantineText('Count: $value (min: 0, max: 10)'),
            MantineGroup(
              children: [
                MantineButton(
                  onPressed: _counter.decrement,
                  child: const Text('-'),
                ),
                MantineButton(
                  onPressed: _counter.increment,
                  child: const Text('+'),
                ),
                MantineButton(
                  onPressed: _counter.reset,
                  variant: MantineButtonVariant.outline,
                  child: const Text('Reset'),
                ),
                MantineButton(
                  onPressed: () => _counter.set(5),
                  variant: MantineButtonVariant.outline,
                  child: const Text('Set to 5'),
                ),
              ],
            ),
            const MantineText('Different sizes:'),
            ...MantineSize.values.map((s) => MantineGroup(
                  children: [
                    MantineButton(
                      onPressed: _counter.decrement,
                      size: s,
                      child: const Text('-'),
                    ),
                    MantineText('$value', size: s),
                    MantineButton(
                      onPressed: _counter.increment,
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
