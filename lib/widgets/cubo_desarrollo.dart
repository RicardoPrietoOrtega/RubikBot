import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/provider.dart';

class CuboDesarrollo extends StatelessWidget {
  const CuboDesarrollo({super.key});

  @override
  Widget build(BuildContext context) {
    final myProvider = Provider.of<MyProvider>(context);
    final screenSize = MediaQuery.of(context).size;

    double rectSize = 20.0; // Tamaño de cada rectángulo
    double spacing = 5.0;    // Espaciado entre rectángulos

    final List<List<double>> coords = [
      [3.15, 0], // Izquierda
      [3.15, 3.15], // Frente
      [3.15, 6.3], // Derecha
      [3.15, 9.45], // Atrás
      [0, 3.15], // Arriba
      [6.3, 3.15], // Abajo
    ];

    return Positioned(
      bottom: 0,
      left: 0,
      child: Container(
        width: screenSize.width,
        height: screenSize.height * 0.27,
        decoration: const BoxDecoration(color: Colors.black87),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 50),
          child: CustomPaint(
            painter: CuboPainter(
              cubo: myProvider.cubo,
              coords: coords,
              l: rectSize,
              s: spacing,
            ),
            size: Size(screenSize.width * 0.8, screenSize.height * 0.2),
          ),
        ),
      ),
    );
  }
}

class CuboPainter extends CustomPainter {
  final List<Color> colores = [
    const Color.fromARGB(255, 255, 127, 0),     // Cara izquierda (Naranja)
    const Color.fromARGB(255, 255, 255, 255),   // Cara frontal (Blanco)
    const Color.fromARGB(255, 255, 0, 0),       // Cara derecha (Rojo)
    const Color.fromARGB(255, 255, 255, 0),     // Cara atrás (Amarillo)
    const Color.fromARGB(255, 0, 0, 255),       // Cara superior (Azul)
    const Color.fromARGB(255, 0, 255, 0),       // Cara inferior (Verde)
  ];
  
  final List<List<double>> coords; // Coordenadas de las caras del cubo
  final double l; // Tamaño de cada rectángulo
  final double s; // Espaciado entre rectángulos
  final List<int> cubo; // Estado del cubo (colores de las celdas)

  CuboPainter({required this.cubo, required this.coords, required this.l, required this.s});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    int k = 0; // Inicializar el índice de la celda
    for (int c = 0; c < coords.length; c++) {
      for (int i = 0; i < 3; i++) { // Filas
        for (int j = 0; j < 3; j++) { // Columnas
          paint.color = colores[cubo[k]];
          Rect rect = Rect.fromLTWH((coords[c][1] + j) * (l + s), (coords[c][0] + i) * (l + s), l, l);
          canvas.drawRect(rect, paint);
          k++;
        }
      }
    }
  }

  @override
  bool shouldRepaint(CuboPainter oldDelegate) {
    return oldDelegate.cubo != cubo; // Redibujar si el cubo ha cambiado
  }
}
