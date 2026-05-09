import 'package:flutter/widgets.dart';
import 'package:mantine/mantine.dart';

class PaginationSection extends StatefulWidget {
  const PaginationSection({super.key});

  @override
  State<PaginationSection> createState() => _PaginationSectionState();
}

class _PaginationSectionState extends State<PaginationSection> {
  late final MantinePaginationState _pagination;

  @override
  void initState() {
    super.initState();
    _pagination = MantinePaginationState(
      total: 100,
      pageSize: 10,
      siblings: 1,
      boundaries: 1,
    );
  }

  @override
  void dispose() {
    _pagination.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _pagination,
      builder: (context, _) {
        return MantineStack(
          children: [
            MantineText('Total items: ${_pagination.total}'),
            MantineText('Page size: ${_pagination.pageSize}'),
            MantineText('Total pages: ${_pagination.totalPages}'),
            MantineText('Active page: ${_pagination.page}'),
            const MantineDivider(),
            MantineGroup(
              children: [
                MantineButton(
                  onPressed: _pagination.page > 1 ? _pagination.first : null,
                  size: MantineSize.xs,
                  variant: MantineButtonVariant.outline,
                  child: const MantineText('First'),
                ),
                MantineButton(
                  onPressed: _pagination.page > 1 ? _pagination.previous : null,
                  size: MantineSize.xs,
                  variant: MantineButtonVariant.outline,
                  child: const MantineText('Prev'),
                ),
                ..._pagination.range.map((item) {
                  if (item == 'dots') {
                    return const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: MantineText('...'),
                    );
                  }
                  final page = item as int;
                  return MantineButton(
                    onPressed: () => _pagination.setPage(page),
                    size: MantineSize.xs,
                    variant: page == _pagination.page
                        ? MantineButtonVariant.filled
                        : MantineButtonVariant.outline,
                    child: MantineText(page.toString()),
                  );
                }),
                MantineButton(
                  onPressed: _pagination.page < _pagination.totalPages
                      ? _pagination.next
                      : null,
                  size: MantineSize.xs,
                  variant: MantineButtonVariant.outline,
                  child: const MantineText('Next'),
                ),
                MantineButton(
                  onPressed: _pagination.page < _pagination.totalPages
                      ? _pagination.last
                      : null,
                  size: MantineSize.xs,
                  variant: MantineButtonVariant.outline,
                  child: const MantineText('Last'),
                ),
              ],
            ),
            const MantineDivider(),
            _NumberOptions(
              label: 'Siblings:',
              value: _pagination.siblings,
              onChanged: (value) => _pagination.siblings = value,
            ),
            _NumberOptions(
              label: 'Boundaries:',
              value: _pagination.boundaries,
              onChanged: (value) => _pagination.boundaries = value,
            ),
          ],
        );
      },
    );
  }
}

class _NumberOptions extends StatelessWidget {
  const _NumberOptions({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final int value;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return MantineGroup(
      children: [
        MantineText(label),
        ...[0, 1, 2].map(
          (option) => MantineButton(
            onPressed: () => onChanged(option),
            size: MantineSize.xs,
            variant: value == option
                ? MantineButtonVariant.filled
                : MantineButtonVariant.outline,
            child: MantineText(option.toString()),
          ),
        ),
      ],
    );
  }
}
