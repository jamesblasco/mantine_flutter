import 'package:flutter/widgets.dart';
import '../../foundation/size.dart';
import '../../theme/context_extensions.dart';

enum MantineDividerOrientation { horizontal, vertical }

enum MantineDividerLabelPosition { left, center, right }

enum MantineDividerVariant { solid, dashed, dotted }

class MantineDivider extends StatelessWidget {
  const MantineDivider({
    super.key,
    this.orientation = MantineDividerOrientation.horizontal,
    this.label,
    this.labelPosition = MantineDividerLabelPosition.center,
    this.size = MantineSize.xs,
    this.color,
    this.labelColor,
    this.variant = MantineDividerVariant.solid,
    this.my,
    this.mx,
  });

  final MantineDividerOrientation orientation;
  final Widget? label;
  final MantineDividerLabelPosition labelPosition;
  final MantineSize size;
  final Color? color;
  final Color? labelColor;
  final MantineDividerVariant variant;
  final double? my;
  final double? mx;

  @override
  Widget build(BuildContext context) {
    final lineColor = color ?? context.mantineBorder;
    final thickness = switch (size) {
      MantineSize.xs => 1.0,
      MantineSize.sm => 2.0,
      MantineSize.md => 3.0,
      MantineSize.lg => 4.0,
      MantineSize.xl => 6.0,
    };

    EdgeInsetsGeometry? outerPadding;
    if (my != null || mx != null) {
      outerPadding = EdgeInsets.symmetric(
        vertical: my ?? 0,
        horizontal: mx ?? 0,
      );
    }

    Widget line;

    if (orientation == MantineDividerOrientation.vertical) {
      line = SizedBox(
        width: thickness,
        child: variant == MantineDividerVariant.solid
            ? DecoratedBox(
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(color: lineColor, width: thickness),
                  ),
                ),
              )
            : CustomPaint(
                painter: _DashedLinePainter(
                  color: lineColor,
                  thickness: thickness,
                  dashed: variant == MantineDividerVariant.dashed,
                  vertical: true,
                ),
              ),
      );
    } else if (label != null) {
      final leftFlex = switch (labelPosition) {
        MantineDividerLabelPosition.left => 1,
        MantineDividerLabelPosition.center => 10,
        MantineDividerLabelPosition.right => 20,
      };
      final rightFlex = switch (labelPosition) {
        MantineDividerLabelPosition.left => 20,
        MantineDividerLabelPosition.center => 10,
        MantineDividerLabelPosition.right => 1,
      };

      line = Row(
        children: [
          Expanded(
            flex: leftFlex,
            child: _buildHorizontalLine(lineColor, thickness, variant),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: DefaultTextStyle.merge(
              style: TextStyle(color: labelColor ?? context.mantineDimmedText),
              child: label!,
            ),
          ),
          Expanded(
            flex: rightFlex,
            child: _buildHorizontalLine(lineColor, thickness, variant),
          ),
        ],
      );
    } else {
      line = _buildHorizontalLine(lineColor, thickness, variant);
    }

    if (outerPadding != null) {
      line = Padding(padding: outerPadding, child: line);
    }

    return line;
  }

  Widget _buildHorizontalLine(
      Color color, double thickness, MantineDividerVariant variant) {
    if (variant == MantineDividerVariant.solid) {
      return SizedBox(
        height: thickness,
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: color, width: thickness),
            ),
          ),
        ),
      );
    }
    return SizedBox(
      height: thickness,
      child: CustomPaint(
        painter: _DashedLinePainter(
          color: color,
          thickness: thickness,
          dashed: variant == MantineDividerVariant.dashed,
          vertical: false,
        ),
      ),
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  const _DashedLinePainter({
    required this.color,
    required this.thickness,
    required this.dashed,
    required this.vertical,
  });

  final Color color;
  final double thickness;
  final bool dashed;
  final bool vertical;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = thickness
      ..style = PaintingStyle.stroke;

    final dashLength = dashed ? 6.0 : 2.0;
    final gapLength = dashed ? 4.0 : 3.0;
    final total = vertical ? size.height : size.width;
    var pos = 0.0;

    while (pos < total) {
      final end = (pos + dashLength).clamp(0.0, total);
      if (vertical) {
        canvas.drawLine(
            Offset(size.width / 2, pos), Offset(size.width / 2, end), paint);
      } else {
        canvas.drawLine(
            Offset(pos, size.height / 2), Offset(end, size.height / 2), paint);
      }
      pos += dashLength + gapLength;
    }
  }

  @override
  bool shouldRepaint(_DashedLinePainter old) =>
      old.color != color ||
      old.thickness != thickness ||
      old.dashed != dashed ||
      old.vertical != vertical;
}
