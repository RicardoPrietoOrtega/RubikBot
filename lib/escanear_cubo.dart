import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/analizar_imagen.dart';
import 'package:provider/provider.dart';
import 'providers/provider.dart';

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
          await _initializeControllerFuture;
          final image = await _controller.takePicture();
          int cara = Provider.of<MyProvider>(context, listen: false).cara; // Obtener la cara actual
          await analizarImagen(image.path, context, cara * 9); // Llama a analizarImagen pasando el contexto y cara
          Provider.of<MyProvider>(context, listen: false).cara = cara + 1; // Cambiar la cara de forma correcta
        } catch (e) {
          print("Error: $e");
        }
      },
      child: const Icon(Icons.camera),
    );
  }
}
