import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './tree_theme_data.dart';

class RootCommentWidget extends StatelessWidget {
  final PreferredSizeWidget avatar;
  final Widget content;

  const RootCommentWidget(this.avatar, this.content, {super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: RootPainter(
          avatar.preferredSize,
          context.watch<TreeThemeData>().lineColor,
          context.watch<TreeThemeData>().lineWidth,
          Directionality.of(context)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          avatar,
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: content,
          )
        ],
      ),
    );
  }
}

class RootPainter extends CustomPainter {
  Size? avatar;
  late Paint _paint;
  Color? pathColor;
  double? strokeWidth;
  final TextDirection textDecoration;
  RootPainter(
      this.avatar, this.pathColor, this.strokeWidth, this.textDecoration) {
    _paint = Paint()
      ..color = pathColor!
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth!
      ..strokeCap = StrokeCap.round;
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (textDecoration == TextDirection.rtl) {
      canvas.translate(size.width, 0);
    }
    double dx = avatar!.width / 1.6;
    if (textDecoration == TextDirection.rtl) {
      dx *= -1;
    }
    canvas.drawLine(
      Offset(dx, avatar!.height),
      Offset(dx, size.height),
      _paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
