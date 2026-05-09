import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import '../../foundation/size.dart';
import '../../theme/context_extensions.dart';
import '../../utils/uncontrolled.dart';
import '../overlay/popover.dart';
import 'text_input.dart';

class MantineSelectItem {
  const MantineSelectItem({
    required this.value,
    required this.label,
    this.disabled = false,
    this.group,
  });

  final String value;
  final String label;
  final bool disabled;
  final String? group;
}

class MantineSelect extends StatefulWidget {
  const MantineSelect({
    super.key,
    required this.data,
    this.value,
    this.defaultValue,
    this.onChanged,
    this.searchable = false,
    this.clearable = false,
    this.creatable = false,
    this.placeholder,
    this.label,
    this.description,
    this.error,
    this.size = MantineSize.sm,
    this.radius,
    this.disabled = false,
    this.required = false,
    this.variant = MantineInputVariant.default_,
  });

  final List<dynamic> data; // List<String> or List<MantineSelectItem>
  final String? value;
  final String? defaultValue;
  final ValueChanged<String?>? onChanged;
  final bool searchable;
  final bool clearable;
  final bool creatable;
  final String? placeholder;
  final String? label;
  final String? description;
  final String? error;
  final MantineSize size;
  final MantineSize? radius;
  final bool disabled;
  final bool required;
  final MantineInputVariant variant;

  @override
  State<MantineSelect> createState() => _MantineSelectState();
}

class _MantineSelectState extends State<MantineSelect> {
  late final MantineUncontrolled<String?> _state;
  late final TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();
  final FocusNode _keyboardFocusNode = FocusNode(canRequestFocus: false);
  bool _opened = false;
  String _searchQuery = '';
  int _highlightedIndex = -1;

  @override
  void initState() {
    super.initState();
    _state = MantineUncontrolled<String?>(
      value: widget.value,
      defaultValue: widget.defaultValue,
      finalValue: null,
      onChanged: widget.onChanged,
    );
    _controller = TextEditingController(text: _getLabelForValue(_state.currentValue));
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void didUpdateWidget(MantineSelect old) {
    super.didUpdateWidget(old);
    _state.update(
      value: widget.value,
      onChanged: widget.onChanged,
    );

    if (_state.value != null) {
      final label = _getLabelForValue(_state.value);
      if (_controller.text != label && !_focusNode.hasFocus) {
        _controller.text = label;
      }
    }
  }

  void _onFocusChange() {
    if (_focusNode.hasFocus) {
      setState(() {
        _opened = true;
        _highlightedIndex = -1;
        if (widget.searchable) {
          _searchQuery = '';
          _controller.clear();
        }
      });
    } else {
       // Delay closing to allow clicks on popover
       Future.delayed(const Duration(milliseconds: 200), () {
         if (mounted && !_focusNode.hasFocus) {
           setState(() {
             _opened = false;
             _controller.text = _getLabelForValue(_state.currentValue);
           });
         }
       });
    }
  }

  String _getLabelForValue(String? value) {
    if (value == null) return '';
    for (final item in _resolvedData) {
      if (item.value == value) return item.label;
    }
    return value;
  }

  List<MantineSelectItem> get _resolvedData {
    return widget.data.map((item) {
      if (item is String) {
        return MantineSelectItem(value: item, label: item);
      }
      return item as MantineSelectItem;
    }).toList();
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    _keyboardFocusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final trigger = KeyboardListener(
      focusNode: _keyboardFocusNode,
      onKeyEvent: (event) {
        if (event is KeyDownEvent) {
          final maxIndex = _filteredData.length + (widget.creatable && _searchQuery.isNotEmpty ? 0 : -1);
          if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
            setState(() {
              _opened = true;
              _highlightedIndex = (_highlightedIndex + 1).clamp(-1, maxIndex);
            });
          } else if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
            setState(() {
              _opened = true;
              _highlightedIndex = (_highlightedIndex - 1).clamp(-1, maxIndex);
            });
          } else if (event.logicalKey == LogicalKeyboardKey.enter) {
             if (_opened) {
               if (_highlightedIndex >= 0 && _highlightedIndex < _filteredData.length) {
                 _onSelect(_filteredData[_highlightedIndex].value);
               } else if (widget.creatable && _highlightedIndex == _filteredData.length && _searchQuery.isNotEmpty) {
                 _onSelect(_searchQuery);
               }
             } else {
               setState(() => _opened = true);
             }
          } else if (event.logicalKey == LogicalKeyboardKey.escape) {
            setState(() => _opened = false);
          }
        }
      },
      child: MantineTextInput(
      label: widget.label,
      description: widget.description,
      error: widget.error,
      placeholder: widget.placeholder,
      controller: _controller,
      focusNode: _focusNode,
      size: widget.size,
      radius: widget.radius,
      disabled: widget.disabled,
      required: widget.required,
      variant: widget.variant,
      readOnly: !widget.searchable,
      onChanged: (v) {
        setState(() {
          _searchQuery = v;
          _opened = true;
          _highlightedIndex = 0;
        });
      },
      onTap: () {
        if (!_focusNode.hasFocus) {
          _focusNode.requestFocus();
        } else {
          setState(() => _opened = !_opened);
        }
      },
      rightSection: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.clearable && _state.currentValue != null)
            GestureDetector(
              onTap: () => _onSelect(null),
              behavior: HitTestBehavior.opaque,
              child: _SelectIcon(
                key: const ValueKey('clear-icon'),
                type: _SelectIconType.close,
                size: widget.size,
              ),
            ),
          _SelectIcon(
            type: _SelectIconType.chevron,
            size: widget.size,
            onTap: () {
              if (_opened) {
                _focusNode.unfocus();
              } else {
                _focusNode.requestFocus();
              }
            },
          ),
        ],
      ),
    ),);

    return LayoutBuilder(
      builder: (context, constraints) {
        return MantinePopover(
          opened: _opened && !widget.disabled,
          onClose: () {
            setState(() => _opened = false);
          },
          position: MantinePopoverPosition.bottom,
          offset: 4,
          radius: widget.radius,
          size: widget.size,
          dropdownPadding: EdgeInsets.zero,
          target: trigger,
          content: Container(
            constraints: const BoxConstraints(maxHeight: 250),
            width: constraints.maxWidth,
            child: _SelectDropdown(
          data: _filteredData,
          selectedValue: _state.currentValue,
          highlightedIndex: _highlightedIndex,
          onSelect: _onSelect,
          size: widget.size,
          searchQuery: _searchQuery,
          creatable: widget.creatable,
            ),
          ),
        );
      },
    );
  }

  void _onSelect(String? value) {
    _state.handleChange(value);
    _controller.text = _getLabelForValue(value);
    setState(() {
      _opened = false;
      _searchQuery = '';
    });
    if (value != null) {
      _focusNode.unfocus();
    }
  }

  List<MantineSelectItem> get _filteredData {
    final data = _resolvedData;
    if (!widget.searchable || _searchQuery.isEmpty) return data;
    return data
        .where((item) =>
            item.label.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }
}

class _SelectDropdown extends StatelessWidget {
  const _SelectDropdown({
    required this.data,
    required this.selectedValue,
    required this.highlightedIndex,
    required this.onSelect,
    required this.size,
    required this.searchQuery,
    required this.creatable,
  });

  final List<MantineSelectItem> data;
  final String? selectedValue;
  final int highlightedIndex;
  final ValueChanged<String> onSelect;
  final MantineSize size;
  final String searchQuery;
  final bool creatable;

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty && (!creatable || searchQuery.isEmpty)) {
      return Padding(
        padding: const EdgeInsets.all(12),
        child: Text(
          'Nothing found',
          style: TextStyle(
            color: context.mantineDimmedText,
            fontSize: 14,
          ),
        ),
      );
    }

    final List<Widget> children = [];
    String? currentGroup;

    for (int i = 0; i < data.length; i++) {
      final item = data[i];
      if (item.group != currentGroup) {
        currentGroup = item.group;
        if (currentGroup != null) {
          children.add(_SelectGroupHeader(label: currentGroup, size: size));
        }
      }

      children.add(
        _SelectItem(
          item: item,
          selected: item.value == selectedValue,
          highlighted: i == highlightedIndex,
          onSelect: () => onSelect(item.value),
          size: size,
        ),
      );
    }

    if (creatable &&
        searchQuery.isNotEmpty &&
        !data.any((item) => item.label.toLowerCase() == searchQuery.toLowerCase())) {
      children.add(
        _SelectItem(
          item: MantineSelectItem(
            value: searchQuery,
            label: 'Create "$searchQuery"',
          ),
          selected: false,
          highlighted: data.length == highlightedIndex,
          onSelect: () => onSelect(searchQuery),
          size: size,
        ),
      );
    }

    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(vertical: 4),
      children: children,
    );
  }
}

class _SelectGroupHeader extends StatelessWidget {
  const _SelectGroupHeader({required this.label, required this.size});
  final String label;
  final MantineSize size;

  @override
  Widget build(BuildContext context) {
    final fontSize = switch (size) {
      MantineSize.xs => 10.0,
      MantineSize.sm => 11.0,
      MantineSize.md => 12.0,
      MantineSize.lg => 13.0,
      MantineSize.xl => 14.0,
    };

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Text(
        label,
        style: TextStyle(
          color: context.mantineDimmedText,
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _SelectItem extends StatelessWidget {
  const _SelectItem({
    required this.item,
    required this.selected,
    required this.highlighted,
    required this.onSelect,
    required this.size,
  });

  final MantineSelectItem item;
  final bool selected;
  final bool highlighted;
  final VoidCallback onSelect;
  final MantineSize size;

  @override
  Widget build(BuildContext context) {
    final theme = context.mantineTheme;
    final isDark = context.isDarkMode;

    Color? bgColor;
    if (selected) {
      bgColor = theme.primaryColorValue.withValues(alpha: 0.1);
    } else if (highlighted) {
      bgColor = isDark
          ? theme.colors.resolve('dark')[5]
          : theme.colors.resolve('gray')[0];
    }

    final fontSize = switch (size) {
      MantineSize.xs => 12.0,
      MantineSize.sm => 14.0,
      MantineSize.md => 16.0,
      MantineSize.lg => 18.0,
      MantineSize.xl => 20.0,
    };

    return GestureDetector(
      onTap: item.disabled ? null : onSelect,
      behavior: HitTestBehavior.opaque,
      child: Container(
        color: bgColor,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            Expanded(
              child: Text(
                item.label,
                style: TextStyle(
                  color: item.disabled
                      ? context.mantineDimmedText
                      : context.mantineBodyText,
                  fontSize: fontSize,
                ),
              ),
            ),
            if (selected)
              _SelectIcon(
                type: _SelectIconType.check,
                size: size,
              ),
          ],
        ),
      ),
    );
  }
}

enum _SelectIconType { chevron, check, close }

class _SelectIcon extends StatelessWidget {
  const _SelectIcon({
    super.key,
    required this.type,
    required this.size,
    this.onTap,
  });

  final _SelectIconType type;
  final MantineSize size;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final iconSize = switch (size) {
      MantineSize.xs => 12.0,
      MantineSize.sm => 14.0,
      MantineSize.md => 16.0,
      MantineSize.lg => 18.0,
      MantineSize.xl => 20.0,
    };

    return GestureDetector(
      onTap: onTap,
      child: MouseRegion(
        cursor: onTap != null ? SystemMouseCursors.click : SystemMouseCursors.basic,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: CustomPaint(
            size: Size(iconSize, iconSize),
            painter: _SelectIconPainter(
              type: type,
              color: type == _SelectIconType.check
                  ? context.mantineTheme.primaryColorValue
                  : context.mantineDimmedText,
            ),
          ),
        ),
      ),
    );
  }
}

class _SelectIconPainter extends CustomPainter {
  _SelectIconPainter({required this.type, required this.color});
  final _SelectIconType type;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final path = Path();
    switch (type) {
      case _SelectIconType.chevron:
        path.moveTo(size.width * 0.2, size.height * 0.4);
        path.lineTo(size.width * 0.5, size.height * 0.7);
        path.lineTo(size.width * 0.8, size.height * 0.4);
      case _SelectIconType.check:
        path.moveTo(size.width * 0.2, size.height * 0.5);
        path.lineTo(size.width * 0.45, size.height * 0.75);
        path.lineTo(size.width * 0.8, size.height * 0.25);
      case _SelectIconType.close:
        path.moveTo(size.width * 0.25, size.height * 0.25);
        path.lineTo(size.width * 0.75, size.height * 0.75);
        path.moveTo(size.width * 0.75, size.height * 0.25);
        path.lineTo(size.width * 0.25, size.height * 0.75);
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
