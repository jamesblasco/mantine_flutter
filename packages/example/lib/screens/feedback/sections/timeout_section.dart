import 'package:flutter/widgets.dart';
import 'package:mantine/mantine.dart';

class TimeoutSection extends StatefulWidget {
  const TimeoutSection({super.key});

  @override
  State<TimeoutSection> createState() => _TimeoutSectionState();
}

class _TimeoutSectionState extends State<TimeoutSection> {
  final _timeout = MantineTimeout();
  String _timeoutStatus = 'Idle';

  @override
  void dispose() {
    _timeout.dispose();
    super.dispose();
  }

  void _startTimeout() {
    setState(() => _timeoutStatus = 'Pending...');
    _timeout.start(const Duration(seconds: 2), () {
      setState(() => _timeoutStatus = 'Completed');
    });
  }

  void _clearTimeout() {
    _timeout.clear();
    setState(() => _timeoutStatus = 'Cleared');
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _timeout,
      builder: (context, _) {
        return MantineStack(
          align: CrossAxisAlignment.start,
          children: [
            MantineText('Status: $_timeoutStatus'),
            MantineText('Pending: ${_timeout.pending}', dimmed: true),
            MantineGroup(
              children: [
                MantineButton(
                  onPressed: _timeout.pending ? null : _startTimeout,
                  child: const Text('Start (2s)'),
                ),
                MantineButton(
                  onPressed: _timeout.pending ? _clearTimeout : null,
                  variant: MantineButtonVariant.outline,
                  color: 'red',
                  child: const Text('Clear'),
                ),
              ],
            ),
            const MantineText('Demonstrating sizes:'),
            MantineGroup(
              align: CrossAxisAlignment.center,
              children: MantineSize.values.map((s) {
                return MantineButton(
                  onPressed: _timeout.pending ? null : _startTimeout,
                  size: s,
                  child: Text('Start ${s.name}'),
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }
}
