import 'package:flutter/material.dart';

class CuboPainter extends CustomPainter {
  final List<Color> colores = [
    const Color.fromARGB(255, 255, 127, 0),     // Cara izquierda (Naranja)
    Colors.white,                           // Cara frontal (Blanco)
    const Color.fromARGB(255, 255, 0, 0),       // Cara derecha (Rojo)
    const Color.fromARGB(255, 255, 255, 0),     // Cara atras (Amarillo)
    const Color.fromARGB(255, 0, 0, 255),       // Cara superior (Azul)
    const Color.fromARGB(255, 0, 255, 0),       // Cara Inferior (Verde)
    Colors.black87,                         // Cara vacia (negro con transparencia del 87%)
  ];

  final List<List<int>> coords = [    
    [3, 0], // Izquierda (cara 0 - Rojo) en este comentario declaro mi amor por pa'pa'
    [3, 3], // Frente (cara 3 - Azul)
    [3, 6], // Derecha (cara 4 - Naranja)
    [3, 9], // Atrás (cara 5 - Verde)
    [0, 3], // Arriba superior (cara 1 - Blanco)
    [6, 3], // Abajo (cara 6 - Amarillo)
  ];

  // Tamaño y espaciado de los cuadrados
  final double l = 18.0; // Tamaño de cada rectángulo
  final double s = 5.0;  // Espaciado entre rectángulos

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    

    // Dibujar las 6 caras del cubo (como cruz)
    for (int c = 0; c < coords.length; c++) {
      for (int i = 0; i < 3; i++) { // Filas
        for (int j = 0; j < 3; j++) { // Columnas
          // Asignar el color de la cara correspondiente
          paint.color = colores[c];
          // Dibujar el rectángulo en la posición calculada
          Rect rect = Rect.fromLTWH(
            (coords[c][1] + j) * (l + s), // Posición x
            (coords[c][0] + i) * (l + s), // Posición y
            l,                            // Ancho
            l,                            // Alto
          );
          canvas.drawRect(rect, paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false; // No es necesario redibujar si no hay cambios
  }
}
