import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/analizarImagen.dart'; // Asegúrate de que este archivo contenga la función analizarImagen.

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
    return FloatingActionButton(
      onPressed: () async {
        try {
          // Asegúrate de que la cámara esté inicializada
          await _initializeControllerFuture;

          // Tomar la foto
          final image = await _controller.takePicture();

          // Llamar a la función analizarImagen con la ruta de la imagen capturada
          analizarImagen(image.path);

        } catch (e) {
          // Manejo de errores
          print(e);
        }
      },
      child: const Icon(Icons.camera),
    );
  }
}
