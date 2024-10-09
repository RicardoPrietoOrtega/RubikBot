import 'package:flutter/material.dart';

class GridPainter extends CustomPainter {
  final double l = 40.0; // Tamaño de cada rectángulo
  final double s = 40.0; // Espaciado entre rectángulos
  

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 2.0; // Establece el grosor del contorno

    for (int i = 0; i < 3; i++) {
      // Filas
      for (int j = 0; j < 3; j++) {
        // Columnas
        paint.color = Colors.white;
        Rect rect = Rect.fromLTWH(
          92 + (j) * (l + s), // Posición x
          100 + (i) * (l + s), // Posición y
          l, // Ancho
          l, // Alto
        );
        canvas.drawRect(rect, paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false; // No es necesario redibujar si no hay cambios
  }
}
