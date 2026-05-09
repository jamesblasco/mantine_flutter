import 'package:flutter/widgets.dart';
import '../../foundation/breakpoints.dart';
import '../../foundation/size.dart';
import '../../theme/context_extensions.dart';

typedef MantineGridColSpan = Map<MantineSize?, int>;
typedef MantineGridColOffset = Map<MantineSize?, int>;
typedef MantineGridColOrder = Map<MantineSize?, int>;

class MantineGrid extends StatelessWidget {
  static const col = _MantineGridColStatic();

  const MantineGrid({
    super.key,
    required this.children,
    this.columns = 12,
    this.gutter = MantineSize.md,
    this.gutterValue,
    this.grow = false,
    this.justify = MainAxisAlignment.start,
    this.align = CrossAxisAlignment.start,
  });

  final List<MantineGridCol> children;
  final int columns;
  final MantineSize gutter;
  final double? gutterValue;
  final bool grow;
  final MainAxisAlignment justify;
  final CrossAxisAlignment align;

  @override
  Widget build(BuildContext context) {
    final theme = context.mantineTheme;
    final gap = gutterValue ?? theme.spacing.resolve(gutter);

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final breakpoints = theme.breakpoints;

        return _MantineGridContent(
          columns: columns,
          gap: gap,
          grow: grow,
          justify: justify,
          align: align,
          width: width,
          breakpoints: breakpoints,
          children: children,
        );
      },
    );
  }
}

class _MantineGridContent extends StatelessWidget {
  const _MantineGridContent({
    required this.columns,
    required this.gap,
    required this.grow,
    required this.justify,
    required this.align,
    required this.width,
    required this.breakpoints,
    required this.children,
  });

  final int columns;
  final double gap;
  final bool grow;
  final MainAxisAlignment justify;
  final CrossAxisAlignment align;
  final double width;
  final MantineBreakpoints breakpoints;
  final List<MantineGridCol> children;

  T _resolve<T>(double width, MantineBreakpoints breakpoints, T defaultValue,
      Map<MantineSize?, T>? values) {
    if (values == null) return defaultValue;

    T current = values[null] ?? defaultValue;

    if (width >= breakpoints.xs && values.containsKey(MantineSize.xs)) {
      current = values[MantineSize.xs]!;
    }
    if (width >= breakpoints.sm && values.containsKey(MantineSize.sm)) {
      current = values[MantineSize.sm]!;
    }
    if (width >= breakpoints.md && values.containsKey(MantineSize.md)) {
      current = values[MantineSize.md]!;
    }
    if (width >= breakpoints.lg && values.containsKey(MantineSize.lg)) {
      current = values[MantineSize.lg]!;
    }
    if (width >= breakpoints.xl && values.containsKey(MantineSize.xl)) {
      current = values[MantineSize.xl]!;
    }

    return current;
  }

  @override
  Widget build(BuildContext context) {
    final List<({MantineGridCol col, int resolvedSpan, int resolvedOffset, int resolvedOrder})> resolvedChildren = children.map((col) {
      final resolvedSpan = _resolve(width, breakpoints, col.span, col.spanValue);
      final resolvedOffset = _resolve(width, breakpoints, col.offset, col.offsetValue);
      final resolvedOrder = _resolve(width, breakpoints, col.order, col.orderValue);
      return (col: col, resolvedSpan: resolvedSpan, resolvedOffset: resolvedOffset, resolvedOrder: resolvedOrder);
    }).toList();

    resolvedChildren.sort((a, b) => a.resolvedOrder.compareTo(b.resolvedOrder));

    final List<Widget> rows = [];
    List<Widget> currentRow = [];
    int currentSpanSum = 0;

    final double colWidth = (width - (columns - 1) * gap) / columns;

    for (final resolved in resolvedChildren) {
      final col = resolved.col;
      final span = resolved.resolvedSpan;
      final offset = resolved.resolvedOffset;

      if (currentSpanSum + span + offset > columns && currentRow.isNotEmpty) {
        rows.add(_buildRow(currentRow, currentSpanSum));
        currentRow = [];
        currentSpanSum = 0;
      }

      if (offset > 0) {
        final double offsetWidth = offset * colWidth + offset * gap;
        currentRow.add(SizedBox(width: offsetWidth));
      }

      final double widthValue = span * colWidth + (span - 1) * gap;
      Widget child = SizedBox(
        width: widthValue,
        child: col.align != null
            ? Align(
                alignment: _getAlignment(col.align!),
                child: col.child,
              )
            : col.child,
      );

      if (grow) {
        child = Expanded(
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: widthValue),
            child: col.align != null
                ? Align(
                    alignment: _getAlignment(col.align!),
                    child: col.child,
                  )
                : col.child,
          ),
        );
      }

      currentRow.add(child);
      currentSpanSum += span + offset;

      if (currentSpanSum >= columns) {
        rows.add(_buildRow(currentRow, currentSpanSum));
        currentRow = [];
        currentSpanSum = 0;
      }
    }

    if (currentRow.isNotEmpty) {
      rows.add(_buildRow(currentRow, currentSpanSum));
    }

    return Column(
      crossAxisAlignment: align,
      children: rows.asMap().entries.map((entry) {
        final idx = entry.key;
        final row = entry.value;
        if (idx < rows.length - 1) {
          return Padding(
            padding: EdgeInsets.only(bottom: gap),
            child: row,
          );
        }
        return row;
      }).toList(),
    );
  }

  Widget _buildRow(List<Widget> rowChildren, int spanSum) {
    final List<Widget> items = [];
    for (var i = 0; i < rowChildren.length; i++) {
      items.add(rowChildren[i]);
      if (i < rowChildren.length - 1) {
        items.add(SizedBox(width: gap));
      }
    }

    Widget row = Row(
      mainAxisAlignment: justify,
      crossAxisAlignment: align,
      children: items,
    );

    return row;
  }

  Alignment _getAlignment(CrossAxisAlignment align) {
    return switch (align) {
      CrossAxisAlignment.start => Alignment.topCenter,
      CrossAxisAlignment.end => Alignment.bottomCenter,
      CrossAxisAlignment.center => Alignment.center,
      _ => Alignment.center,
    };
  }
}

class _MantineGridColStatic {
  const _MantineGridColStatic();

  MantineGridCol call({
    Key? key,
    required Widget child,
    int span = 12,
    MantineGridColSpan? spanValue,
    int offset = 0,
    MantineGridColOffset? offsetValue,
    int order = 0,
    MantineGridColOrder? orderValue,
    CrossAxisAlignment? align,
  }) {
    return MantineGridCol(
      key: key,
      span: span,
      spanValue: spanValue,
      offset: offset,
      offsetValue: offsetValue,
      order: order,
      orderValue: orderValue,
      align: align,
      child: child,
    );
  }
}

class MantineGridCol extends StatelessWidget {
  const MantineGridCol({
    super.key,
    required this.child,
    this.span = 12,
    this.spanValue,
    this.offset = 0,
    this.offsetValue,
    this.order = 0,
    this.orderValue,
    this.align,
  });

  final Widget child;
  final int span;
  final MantineGridColSpan? spanValue;
  final int offset;
  final MantineGridColOffset? offsetValue;
  final int order;
  final MantineGridColOrder? orderValue;
  final CrossAxisAlignment? align;

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
