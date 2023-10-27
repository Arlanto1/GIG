import 'package:db_atom/src/common_widgets/signature/signature_controller.dart';
import 'package:flutter/material.dart';

class SignaturePainter extends CustomPainter {
  SignaturePainter(this._controller, {Color? penColor})
      : _penStyle = Paint(),
        super(repaint: _controller) {
    _penStyle
      ..color = penColor ?? _controller.penColor
      ..strokeWidth = _controller.penStrokeWidth
      ..strokeCap = _controller.strokeCap
      ..strokeJoin = _controller.strokeJoin;
  }

  final SignatureController _controller;
  final Paint _penStyle;

  @override
  void paint(Canvas canvas, _) {
    final List<Point> points = _controller.value;
    if (points.isEmpty) {
      return;
    }
    for (int i = 0; i < (points.length - 1); i++) {
      if (points[i + 1].type == PointType.move) {
        _penStyle.strokeWidth *= points[i].pressure;
        canvas.drawLine(
          points[i].offset,
          points[i + 1].offset,
          _penStyle,
        );
      } else {
        canvas.drawCircle(
          points[i].offset,
          (_penStyle.strokeWidth / 2) * points[i].pressure,
          _penStyle,
        );
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter other) => true;
}
