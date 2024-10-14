import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/provider.dart';

var myProvider;

class CuboDesarrollo extends StatelessWidget {
  const CuboDesarrollo({super.key});

  @override
  Widget build(BuildContext context) {
    myProvider = Provider.of<MyProvider>(context);    
    final screenSize = MediaQuery.of(context).size;
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
              painter: CuboPainter(),
              size: Size(screenSize.width * 0.8, screenSize.height *0.2), 
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
    const Color.fromARGB(255, 255, 255, 0),     // Cara atras (Amarillo)
    const Color.fromARGB(255, 0, 0, 255),       // Cara superior (Azul)
    const Color.fromARGB(255, 0, 255, 0),       // Cara inferior (Verde)
    const Color.fromARGB(64, 96, 96, 96),       // Cara inferior (Verde)
  ];
  final List<List<double>> coords = [    
    [3.15, 0], // Izquierda (cara 0 - Rojo) 
    [3.15, 3.15], // Frente (cara 3 - Azul)
    [3.15, 6.3], // Derecha (cara 4 - Naranja)
    [3.15, 9.45], // Atrás (cara 5 - Verde)
    [0, 3.15], // Arriba superior (cara 1 - Blanco)
    [6.3, 3.15], // Abajo (cara 6 - Amarillo)
  ];
  final double l = 17.0; // Tamaño de cada rectángulo
  final double s = 5.0;  // Espaciado entre rectángulos
  int k = 0;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    List cubo = myProvider.cubo;
    k = 0;    
    for (int c = 0; c < coords.length; c++) {
      for (int i = 0; i < 3; i++) {             // Filas
        for (int j = 0; j < 3; j++) {           // Columnas
          paint.color = colores[cubo[k]];          
          Rect rect = Rect.fromLTWH( (coords[c][1]+j)*(l+s), (coords[c][0]+i)*(l+s), l, l);
          canvas.drawRect(rect, paint);
          k++;
        }
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false; // No es necesario redibujar si no hay cambios
  }
}
