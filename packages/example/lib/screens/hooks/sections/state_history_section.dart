import 'package:flutter/widgets.dart';
import 'package:mantine/mantine.dart';

class StateHistorySection extends StatefulWidget {
  const StateHistorySection({super.key});

  @override
  State<StateHistorySection> createState() => _StateHistorySectionState();
}

class _StateHistorySectionState extends State<StateHistorySection> {
  final _history = MantineStateHistory<String>('Initial value', capacity: 10);

  @override
  void dispose() {
    _history.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _history,
      builder: (context, _) {
        return MantineStack(
          children: [
            const MantineText(
              'State with undo/redo history tracking.',
              dimmed: true,
              size: MantineSize.sm,
            ),
            MantineTextInput(
              label: 'History input',
              value: _history.value,
              onChanged: _history.set,
            ),
            MantineGroup(
              children: [
                MantineButton(
                  onPressed: _history.canUndo ? _history.undo : null,
                  child: const Text('Undo'),
                ),
                MantineButton(
                  onPressed: _history.canRedo ? _history.redo : null,
                  child: const Text('Redo'),
                ),
              ],
            ),
            MantineText(
              'History: ${_history.history.join(', ')}',
              size: MantineSize.xs,
              dimmed: true,
            ),
            MantineText(
              'Future: ${_history.future.join(', ')}',
              size: MantineSize.xs,
              dimmed: true,
            ),
          ],
        );
      },
    );
  }
}
