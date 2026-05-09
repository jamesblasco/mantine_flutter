import 'package:flutter/widgets.dart';
import 'package:mantine/mantine.dart';

class PopoverSection extends StatefulWidget {
  const PopoverSection({super.key});

  @override
  State<PopoverSection> createState() => _PopoverSectionState();
}

class _PopoverSectionState extends State<PopoverSection> {
  bool _opened1 = false;
  bool _opened2 = false;
  bool _opened3 = false;
  bool _opened4 = false;

  @override
  Widget build(BuildContext context) {
    return MantineStack(
      children: [
        const MantineText('Basic popover'),
        MantineGroup(
          children: [
            MantinePopover(
              opened: _opened1,
              onClose: () => setState(() => _opened1 = false),
              position: MantinePopoverPosition.bottom,
              withArrow: true,
              target: MantineButton(
                onPressed: () => setState(() => _opened1 = !_opened1),
                child: const Text('Toggle popover'),
              ),
              content: const MantineText('This is a basic popover'),
            ),
          ],
        ),
        const MantineText('Different positions'),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: MantinePopoverPosition.values.map((pos) {
            return _PositionDemo(position: pos);
          }).toList(),
        ),
        const MantineText('Offset, Arrow, and Radius'),
        MantineGroup(
          children: [
            MantinePopover(
              opened: _opened2,
              onClose: () => setState(() => _opened2 = false),
              position: MantinePopoverPosition.right,
              offset: 20,
              withArrow: true,
              target: MantineButton(
                onPressed: () => setState(() => _opened2 = !_opened2),
                child: const Text('Large offset'),
              ),
              content: const MantineText('Popover with 20px offset'),
            ),
            MantinePopover(
              opened: _opened3,
              onClose: () => setState(() => _opened3 = false),
              position: MantinePopoverPosition.top,
              withArrow: true,
              arrowSize: 15,
              arrowRadius: 3,
              target: MantineButton(
                onPressed: () => setState(() => _opened3 = !_opened3),
                child: const Text('Large rounded arrow'),
              ),
              content: const MantineText('Popover with 15px rounded arrow'),
            ),
          ],
        ),
        const MantineText('Barrier Dismissible'),
        MantineGroup(
          children: [
            MantinePopover(
              opened: _opened4,
              onClose: () => setState(() => _opened4 = false),
              barrierDismissible: false,
              target: MantineButton(
                onPressed: () => setState(() => _opened4 = !_opened4),
                child: const Text('Not dismissible by barrier'),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const MantineText('Must click button to close'),
                  MantineButton(
                    size: MantineSize.xs,
                    onPressed: () => setState(() => _opened4 = false),
                    child: const Text('Close'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _PositionDemo extends StatefulWidget {
  const _PositionDemo({required this.position});

  final MantinePopoverPosition position;

  @override
  State<_PositionDemo> createState() => _PositionDemoState();
}

class _PositionDemoState extends State<_PositionDemo> {
  bool _opened = false;

  @override
  Widget build(BuildContext context) {
    return MantinePopover(
      opened: _opened,
      onClose: () => setState(() => _opened = false),
      position: widget.position,
      withArrow: true,
      target: MantineButton(
        size: MantineSize.xs,
        onPressed: () => setState(() => _opened = !_opened),
        child: Text(widget.position.name),
      ),
      content: MantineText('Position: ${widget.position.name}'),
    );
  }
}
