import 'package:flutter/widgets.dart';

/// Manages pagination state for the MantinePagination widget.
///
/// This utility tracks the current page, total items, and page size,
/// and computes the range of page numbers to be displayed, including
/// 'dots' placeholders for large ranges.
class MantinePaginationState extends ChangeNotifier {
  MantinePaginationState({
    required int total,
    int page = 1,
    int pageSize = 1,
    int siblings = 1,
    int boundaries = 1,
  })  : _total = total,
        _pageSize = pageSize.clamp(1, 1 << 31),
        _siblings = siblings.clamp(0, 1 << 31),
        _boundaries = boundaries.clamp(0, 1 << 31),
        _page = page {
    _clampPage();
  }

  int _total;
  int _page;
  int _pageSize;
  int _siblings;
  int _boundaries;

  /// Total number of items.
  int get total => _total;
  set total(int value) {
    if (_total != value) {
      _total = value;
      _clampPage();
      notifyListeners();
    }
  }

  /// Current active page number.
  int get page => _page;
  set page(int value) => setPage(value);

  /// Number of items per page.
  int get pageSize => _pageSize;
  set pageSize(int value) {
    final clamped = value.clamp(1, 1 << 31);
    if (_pageSize != clamped) {
      _pageSize = clamped;
      _clampPage();
      notifyListeners();
    }
  }

  /// Number of siblings to show on each side of the active page.
  int get siblings => _siblings;
  set siblings(int value) {
    final clamped = value.clamp(0, 1 << 31);
    if (_siblings != clamped) {
      _siblings = clamped;
      notifyListeners();
    }
  }

  /// Number of boundary pages to show at the start and end.
  int get boundaries => _boundaries;
  set boundaries(int value) {
    final clamped = value.clamp(0, 1 << 31);
    if (_boundaries != clamped) {
      _boundaries = clamped;
      notifyListeners();
    }
  }

  /// Total number of pages based on [total] and [pageSize].
  int get totalPages => (_total / _pageSize).ceil();

  /// Moves to the next page if available.
  void next() => setPage(_page + 1);

  /// Moves to the previous page if available.
  void previous() => setPage(_page - 1);

  /// Moves to the first page.
  void first() => setPage(1);

  /// Moves to the last page.
  void last() => setPage(totalPages);

  /// Sets the current page, clamping it within valid bounds.
  void setPage(int value) {
    final clamped = _clampValue(value);
    if (_page != clamped) {
      _page = clamped;
      notifyListeners();
    }
  }

  int _clampValue(int value) {
    final maxPage = totalPages;
    if (maxPage <= 0) return 0;
    return value.clamp(1, maxPage);
  }

  void _clampPage() {
    final clamped = _clampValue(_page);
    if (_page != clamped) {
      _page = clamped;
    }
  }

  /// Computed range of page numbers and 'dots' for UI rendering.
  List<Object> get range {
    final total = totalPages;
    if (total <= 0) return [];

    // totalPageNumbers: boundaries*2 + siblings*2 + 1 (active) + 2 (dots)
    // Mantine uses siblings * 2 + 3 + boundaries * 2
    final totalPageNumbers = _siblings * 2 + 3 + _boundaries * 2;

    if (totalPageNumbers >= total) {
      return List<int>.generate(total, (i) => i + 1);
    }

    final leftSiblingIndex = (_page - _siblings).clamp(_boundaries + 1, total);
    final rightSiblingIndex = (_page + _siblings).clamp(1, total - _boundaries);

    final shouldShowLeftDots = leftSiblingIndex > _boundaries + 2;
    final shouldShowRightDots = rightSiblingIndex < total - (_boundaries + 1);

    if (!shouldShowLeftDots && shouldShowRightDots) {
      final leftItemCount = _siblings * 2 + _boundaries + 2;
      return [
        ...List<int>.generate(leftItemCount, (i) => i + 1),
        'dots',
        ...List<int>.generate(_boundaries, (i) => total - _boundaries + i + 1),
      ];
    }

    if (shouldShowLeftDots && !shouldShowRightDots) {
      final rightItemCount = _boundaries + 2 + 2 * _siblings;
      return [
        ...List<int>.generate(_boundaries, (i) => i + 1),
        'dots',
        ...List<int>.generate(rightItemCount, (i) => total - rightItemCount + i + 1),
      ];
    }

    return [
      ...List<int>.generate(_boundaries, (i) => i + 1),
      'dots',
      ...List<int>.generate(rightSiblingIndex - leftSiblingIndex + 1, (i) => leftSiblingIndex + i),
      'dots',
      ...List<int>.generate(_boundaries, (i) => total - _boundaries + i + 1),
    ];
  }
}
