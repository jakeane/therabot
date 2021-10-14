import 'package:flutter/material.dart';

class ChatNip extends CustomPainter {
  Paint painter;
  double nipHeight;
  Color color;
  bool isUser;

  ChatNip({
    required this.nipHeight,
    required this.color,
    required this.isUser
  }) : painter = Paint()
    ..color = color
    ..style = PaintingStyle.fill;
  

  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();

    if (isUser) {
      path.moveTo(size.width, 0);
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height - nipHeight);
      path.close();
    } else {
      path.moveTo(0, 0);
      path.lineTo(0, size.height);
      path.lineTo(size.width, size.height - nipHeight);
      path.close();
    }

    canvas.drawPath(path, painter);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
