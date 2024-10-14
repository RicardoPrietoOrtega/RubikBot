import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/analizar_imagen.dart';
import 'package:provider/provider.dart'; 
import 'providers/provider.dart';

var myProvider;

class EscanearCubo extends StatelessWidget {
  const EscanearCubo({
    super.key,
    required Future<void> initializeControllerFuture,
    required CameraController controller,
  })  : _initializeControllerFuture = initializeControllerFuture,
        _controller = controller;

  final Future<void> _initializeControllerFuture;
  final CameraController _controller;

  @override
  Widget build(BuildContext context) {
    myProvider = Provider.of<MyProvider>(context);    
    return ChangeNotifierProvider(
      create: (context)=>MyProvider(),
        child: FloatingActionButton(
        onPressed: () async {
          try {          
            await _initializeControllerFuture;        
            final image = await _controller.takePicture();          
            List cubAux = myProvider.cubo;
            int cara = myProvider.cara;
            cubAux = analizarImagen(image.path, cubAux, cara*6) as List;
            myProvider.cara = cara++;
            myProvider.cubo = cubAux;
          } catch (e) {          
            //print(e);
          }
        },
        child: const Icon(Icons.camera),
      )
    );
  }
}
