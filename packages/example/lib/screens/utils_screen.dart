import 'package:flutter/widgets.dart';
import 'package:mantine/mantine.dart';
import 'shared.dart';

class UtilsScreen extends StatelessWidget {
  const UtilsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GalleryScreen(
      title: 'Utilities',
      sections: [
        GallerySection(
          title: 'MantinePaginationState',
          child: const _PaginationDemo(),
        ),
        GallerySection(
          title: 'MantineIdle',
          child: MantineIdle.wrap(
            timeout: const Duration(seconds: 3),
            child: const _IdleDemo(),
          ),
        ),
      ],
    );
  }
}

class _PaginationDemo extends StatefulWidget {
  const _PaginationDemo();

  @override
  State<_PaginationDemo> createState() => _PaginationDemoState();
}

class _PaginationDemoState extends State<_PaginationDemo> {
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
            MantineGroup(
              children: [
                const MantineText('Siblings:'),
                MantineButton(
                  onPressed: () => _pagination.siblings = 0,
                  size: MantineSize.xs,
                  variant: _pagination.siblings == 0
                      ? MantineButtonVariant.filled
                      : MantineButtonVariant.outline,
                  child: const MantineText('0'),
                ),
                MantineButton(
                  onPressed: () => _pagination.siblings = 1,
                  size: MantineSize.xs,
                  variant: _pagination.siblings == 1
                      ? MantineButtonVariant.filled
                      : MantineButtonVariant.outline,
                  child: const MantineText('1'),
                ),
                MantineButton(
                  onPressed: () => _pagination.siblings = 2,
                  size: MantineSize.xs,
                  variant: _pagination.siblings == 2
                      ? MantineButtonVariant.filled
                      : MantineButtonVariant.outline,
                  child: const MantineText('2'),
                ),
              ],
            ),
            MantineGroup(
              children: [
                const MantineText('Boundaries:'),
                MantineButton(
                  onPressed: () => _pagination.boundaries = 0,
                  size: MantineSize.xs,
                  variant: _pagination.boundaries == 0
                      ? MantineButtonVariant.filled
                      : MantineButtonVariant.outline,
                  child: const MantineText('0'),
                ),
                MantineButton(
                  onPressed: () => _pagination.boundaries = 1,
                  size: MantineSize.xs,
                  variant: _pagination.boundaries == 1
                      ? MantineButtonVariant.filled
                      : MantineButtonVariant.outline,
                  child: const MantineText('1'),
                ),
                MantineButton(
                  onPressed: () => _pagination.boundaries = 2,
                  size: MantineSize.xs,
                  variant: _pagination.boundaries == 2
                      ? MantineButtonVariant.filled
                      : MantineButtonVariant.outline,
                  child: const MantineText('2'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class _IdleDemo extends StatelessWidget {
  const _IdleDemo();

  @override
  Widget build(BuildContext context) {
    final idle = MantineIdleScope.of(context);
    final isIdle = idle.isIdle;
    final theme = context.mantineTheme;
    final isDark = context.isDarkMode;

    final color = isIdle
        ? (isDark ? MantineColors.red[8] : MantineColors.red[1])
        : (isDark ? MantineColors.teal[8] : MantineColors.teal[1]);

    final textColor = isIdle
        ? (isDark ? MantineColors.red[2] : MantineColors.red[9])
        : (isDark ? MantineColors.teal[2] : MantineColors.teal[9]);

    return MantineStack(
      children: [
        MantineText(
          'Stop moving your mouse or typing for 3 seconds to see the idle state.',
          size: MantineSize.sm,
          dimmed: true,
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(theme.radius.md),
            border: Border.all(
              color: isIdle ? MantineColors.red[4] : MantineColors.teal[4],
              width: 1,
            ),
          ),
          child: Center(
            child: MantineGroup(
              justify: MainAxisAlignment.center,
              children: [
                MantineText(
                  isIdle ? 'Status: IDLE' : 'Status: ACTIVE',
                  weight: FontWeight.bold,
                  color: textColor,
                ),
                if (!isIdle)
                  MantineLoader(
                    size: MantineSize.xs,
                    color: textColor,
                  ),
              ],
            ),
          ),
        ),
        const MantineText(
          'Any pointer event or key press will reset the timer.',
          size: MantineSize.xs,
          dimmed: true,
        ),
      ],
    );
  }
}
