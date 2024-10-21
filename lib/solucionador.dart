import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/utilerias.dart';
import 'package:flutter_application_1/widgets/cubo_desarrollo.dart';

class Solucionador extends StatelessWidget {
  const Solucionador({super.key}); 

  @override
  Widget build(BuildContext context) {  
    return Scaffold(
      appBar: AppBar(title: const Text('Rubik Robot')),
      body: const Column(
        children: [          
          CuboDesarrollo(),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        //onPressed: () => mover(context, 1), // Usar función anónima aquí        
        onPressed: () => resolver(context), // Usar función anónima aquí        
        child: const Icon(Icons.arrow_circle_right),
      ),
    );
  }
}

void resolver(BuildContext context){
  cruz1(context);
  ordenarCruz1(context);
  esquinas1(context);
  aristas2(context);
  cruzCapa3(context);
  ordenarCruz3(context);
  esquinas3(context);
  orientarEsquinas(context);
}