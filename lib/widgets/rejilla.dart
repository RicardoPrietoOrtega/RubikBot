import 'package:flutter/material.dart';

class Rejilla extends StatelessWidget {
  const Rejilla({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Positioned(          
      top: 0, 
      left: 0,              
      child: Container(
        width: screenSize.width,                                      
        decoration: const BoxDecoration(color: Colors.transparent),
        //child: Padding(
          //padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: CustomPaint(
            painter: GridPainter(),
            size: Size(screenSize.width, screenSize.height),
          ),
        //),
      ),
    );
  }
}

class GridPainter extends CustomPainter {
  double l = 0, s = 0; 
  
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 2.0;
    //print("tamaño: "+size.width.toString()+" x "+size.height.toString());
    l = size.width / 9;
    s = l;
    for (int i = 1; i < 4; i++) {
      for (int j = 1; j < 4; j++) {
        paint.color = Colors.white;
        Rect rect = Rect.fromLTWH( j*(l+s), i*(l+s), l, l);
        canvas.drawRect(rect, paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;         // No es necesario redibujar si no hay cambios
  }
}