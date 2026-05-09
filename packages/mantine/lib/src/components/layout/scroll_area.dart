import 'dart:async';
import 'package:flutter/widgets.dart';
import '../../foundation/size.dart';
import '../../foundation/colors.dart';
import '../../theme/context_extensions.dart';

enum MantineScrollAreaType {
  always,
  scroll,
  hover,
  never,
}

class MantineScrollArea extends StatefulWidget {
  const MantineScrollArea({
    super.key,
    required this.child,
    this.type = MantineScrollAreaType.hover,
    this.scrollbarSize = MantineSize.sm,
    this.scrollHideDelay = const Duration(milliseconds: 1000),
    this.offsetScrollbars = false,
    this.onScrollPositionChange,
    this.viewportRef,
    this.verticalScrollController,
    this.horizontalScrollController,
  });

  final Widget child;
  final MantineScrollAreaType type;

  /// Size of the scrollbar. Can be a [MantineSize] or a [double].
  final dynamic scrollbarSize;
  final Duration scrollHideDelay;
  final bool offsetScrollbars;
  final void Function(Offset position)? onScrollPositionChange;
  final void Function(ScrollController controller)? viewportRef;
  final ScrollController? verticalScrollController;
  final ScrollController? horizontalScrollController;

  @override
  State<MantineScrollArea> createState() => _MantineScrollAreaState();
}

class _MantineScrollAreaState extends State<MantineScrollArea>
    with TickerProviderStateMixin {
  ScrollController? _internalVerticalController;
  ScrollController? _internalHorizontalController;

  ScrollController get _verticalController =>
      widget.verticalScrollController ?? _internalVerticalController!;
  ScrollController get _horizontalController =>
      widget.horizontalScrollController ?? _internalHorizontalController!;

  late AnimationController _verticalVisibility;
  late AnimationController _horizontalVisibility;

  Timer? _hideTimer;
  bool _isHovering = false;

  double _vScrollOffset = 0;
  double _vMaxExtent = 0;
  double _vViewport = 0;

  double _hScrollOffset = 0;
  double _hMaxExtent = 0;
  double _hViewport = 0;

  @override
  void initState() {
    super.initState();
    if (widget.verticalScrollController == null) {
      _internalVerticalController = ScrollController();
    }
    if (widget.horizontalScrollController == null) {
      _internalHorizontalController = ScrollController();
    }

    _verticalVisibility = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _horizontalVisibility = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    if (widget.type == MantineScrollAreaType.always) {
      _verticalVisibility.value = 1.0;
      _horizontalVisibility.value = 1.0;
    }

    widget.viewportRef?.call(_verticalController);

    // Initial metrics check after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _updateMetrics();
      }
    });
  }

  void _updateMetrics() {
    if (!_verticalController.hasClients || !_horizontalController.hasClients) {
      return;
    }

    setState(() {
      _vScrollOffset = _verticalController.offset;
      _vMaxExtent = _verticalController.position.maxScrollExtent;
      _vViewport = _verticalController.position.viewportDimension;

      _hScrollOffset = _horizontalController.offset;
      _hMaxExtent = _horizontalController.position.maxScrollExtent;
      _hViewport = _horizontalController.position.viewportDimension;
    });

    if (widget.type == MantineScrollAreaType.always) {
      _verticalVisibility.value = 1.0;
      _horizontalVisibility.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(MantineScrollArea oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.type == MantineScrollAreaType.always) {
      _verticalVisibility.value = 1.0;
      _horizontalVisibility.value = 1.0;
    } else if (widget.type == MantineScrollAreaType.never) {
      _verticalVisibility.value = 0.0;
      _horizontalVisibility.value = 0.0;
    }

    if (widget.verticalScrollController != oldWidget.verticalScrollController) {
      if (oldWidget.verticalScrollController == null) {
        _internalVerticalController?.dispose();
        _internalVerticalController = null;
      }
      if (widget.verticalScrollController == null) {
        _internalVerticalController = ScrollController();
      }
    }

    if (widget.horizontalScrollController !=
        oldWidget.horizontalScrollController) {
      if (oldWidget.horizontalScrollController == null) {
        _internalHorizontalController?.dispose();
        _internalHorizontalController = null;
      }
      if (widget.horizontalScrollController == null) {
        _internalHorizontalController = ScrollController();
      }
    }
  }

  @override
  void dispose() {
    _internalVerticalController?.dispose();
    _internalHorizontalController?.dispose();
    _verticalVisibility.dispose();
    _horizontalVisibility.dispose();
    _hideTimer?.cancel();
    super.dispose();
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification.depth > 1) return false;

    if (notification is ScrollUpdateNotification ||
        notification is ScrollMetricsNotification) {
      if (notification.metrics.axis == Axis.vertical) {
        setState(() {
          _vScrollOffset = notification.metrics.pixels;
          _vMaxExtent = notification.metrics.maxScrollExtent;
          _vViewport = notification.metrics.viewportDimension;
        });
      } else {
        setState(() {
          _hScrollOffset = notification.metrics.pixels;
          _hMaxExtent = notification.metrics.maxScrollExtent;
          _hViewport = notification.metrics.viewportDimension;
        });
      }

      if (notification is ScrollUpdateNotification) {
        if (widget.type == MantineScrollAreaType.scroll ||
            (widget.type == MantineScrollAreaType.hover && _isHovering)) {
          _showScrollbars();
        }
      }

      widget.onScrollPositionChange
          ?.call(Offset(_hScrollOffset, _vScrollOffset));
    }
    return false;
  }

  void _showScrollbars() {
    if (widget.type == MantineScrollAreaType.never) return;

    _verticalVisibility.forward();
    _horizontalVisibility.forward();

    _hideTimer?.cancel();
    if (widget.type != MantineScrollAreaType.always) {
      _hideTimer = Timer(widget.scrollHideDelay, () {
        if (mounted &&
            (!_isHovering || widget.type == MantineScrollAreaType.scroll)) {
          _verticalVisibility.reverse();
          _horizontalVisibility.reverse();
        }
      });
    }
  }

  void _handleHover(bool hovering) {
    setState(() {
      _isHovering = hovering;
    });

    if (widget.type == MantineScrollAreaType.hover) {
      if (hovering) {
        _showScrollbars();
      } else {
        _hideTimer?.cancel();
        _hideTimer = Timer(widget.scrollHideDelay, () {
          if (mounted && !_isHovering) {
            _verticalVisibility.reverse();
            _horizontalVisibility.reverse();
          }
        });
      }
    }
  }

  double _getScrollbarSize() {
    if (widget.scrollbarSize is MantineSize) {
      return switch (widget.scrollbarSize as MantineSize) {
        MantineSize.xs => 4.0,
        MantineSize.sm => 6.0,
        MantineSize.md => 8.0,
        MantineSize.lg => 12.0,
        MantineSize.xl => 16.0,
      };
    }
    return (widget.scrollbarSize as num).toDouble();
  }

  @override
  Widget build(BuildContext context) {
    final scrollbarSize = _getScrollbarSize();
    final thumbColor = context.isDarkMode
        ? MantineColors.dark[2].withValues(alpha: 0.4)
        : MantineColors.gray[5].withValues(alpha: 0.4);

    return MouseRegion(
      onEnter: (_) => _handleHover(true),
      onExit: (_) => _handleHover(false),
      child: Stack(
        children: [
          NotificationListener<ScrollNotification>(
            onNotification: _handleScrollNotification,
            child: SingleChildScrollView(
              controller: _verticalController,
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                controller: _horizontalController,
                scrollDirection: Axis.horizontal,
                child: widget.child,
              ),
            ),
          ),
          // Vertical Scrollbar
          if (_vMaxExtent > 0)
            Positioned(
              top: widget.offsetScrollbars ? scrollbarSize : 0,
              bottom: widget.offsetScrollbars ? scrollbarSize : 0,
              right: widget.offsetScrollbars ? 2 : 0,
              width: scrollbarSize,
              child: FadeTransition(
                opacity: _verticalVisibility,
                child: CustomPaint(
                  painter: _ScrollbarPainter(
                    offset: _vScrollOffset,
                    maxExtent: _vMaxExtent,
                    viewport: _vViewport,
                    color: thumbColor,
                    axis: Axis.vertical,
                    scrollbarSize: scrollbarSize,
                  ),
                ),
              ),
            ),
          // Horizontal Scrollbar
          if (_hMaxExtent > 0)
            Positioned(
              left: widget.offsetScrollbars ? scrollbarSize : 0,
              right: widget.offsetScrollbars ? scrollbarSize : 0,
              bottom: widget.offsetScrollbars ? 2 : 0,
              height: scrollbarSize,
              child: FadeTransition(
                opacity: _horizontalVisibility,
                child: CustomPaint(
                  painter: _ScrollbarPainter(
                    offset: _hScrollOffset,
                    maxExtent: _hMaxExtent,
                    viewport: _hViewport,
                    color: thumbColor,
                    axis: Axis.horizontal,
                    scrollbarSize: scrollbarSize,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _ScrollbarPainter extends CustomPainter {
  _ScrollbarPainter({
    required this.offset,
    required this.maxExtent,
    required this.viewport,
    required this.color,
    required this.axis,
    required this.scrollbarSize,
  });

  final double offset;
  final double maxExtent;
  final double viewport;
  final Color color;
  final Axis axis;
  final double scrollbarSize;

  @override
  void paint(Canvas canvas, Size size) {
    if (viewport <= 0) return;

    final contentSize = maxExtent + viewport;
    final thumbSize = (viewport / contentSize) *
        (axis == Axis.vertical ? size.height : size.width);
    final thumbPosition = (offset / maxExtent) *
        ((axis == Axis.vertical ? size.height : size.width) - thumbSize);

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final RRect rrect;
    if (axis == Axis.vertical) {
      rrect = RRect.fromRectAndRadius(
        Rect.fromLTWH(
          (size.width - scrollbarSize) / 2,
          thumbPosition,
          scrollbarSize,
          thumbSize,
        ),
        const Radius.circular(100),
      );
    } else {
      rrect = RRect.fromRectAndRadius(
        Rect.fromLTWH(
          thumbPosition,
          (size.height - scrollbarSize) / 2,
          thumbSize,
          scrollbarSize,
        ),
        const Radius.circular(100),
      );
    }

    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(_ScrollbarPainter oldDelegate) {
    return oldDelegate.offset != offset ||
        oldDelegate.maxExtent != maxExtent ||
        oldDelegate.viewport != viewport ||
        oldDelegate.color != color ||
        oldDelegate.axis != axis ||
        oldDelegate.scrollbarSize != scrollbarSize;
  }
}
