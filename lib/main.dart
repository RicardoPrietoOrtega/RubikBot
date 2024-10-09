import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/EscanearCubo.dart';
import 'renderGuia.dart';
import 'renderCubo.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final firstCamera = cameras.first;

  runApp(
    MaterialApp(
      theme: ThemeData.dark(),
      home: TakePictureScreen(
        camera: firstCamera,
      ),
    ),
  );
}

class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({
    super.key,
    required this.camera,
  });

  final CameraDescription camera;

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    // Para mostrar la salida actual de la cámara, crea un CameraController
    _controller = CameraController(
      widget.camera, // Obtén la cámara que se pasa como argumento
      ResolutionPreset.high, // Define la resolución que se va a utilizar
    );

    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Libera el controlador cuando el widget se destruye
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: const Text('Escaner de Rubic')),
      // Debes esperar hasta que el controlador esté inicializado antes de mostrar la previsualización de la cámara
      body: Stack(children: [
        FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // Si el Future está completo, muestra la previsualización
              return CameraPreview(_controller);
            } else {
              // Mientras, muestra un indicador de carga
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
        Positioned(
          // --------------------------------------------------------------------------------cross air del cubo
          top: 0, // El contenedor estará en la parte inferior de la pantalla
          left: 0,
          right: 0,
          child: Container(
            width: screenSize.width, // Extender al ancho completo
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 50),
              child: CustomPaint(
                painter:
                    GridPainter(), // Llamada a la clase CuboPainter desde el archivo importado
                size: Size(
                    screenSize.width * 0.8,
                    screenSize.height *
                        0.15), // Ajustar el tamaño del CustomPaint
              ),
            ),
          ),
        ),
        Positioned(
          //------------------------------------------------------------------------------Vista previa del cubo
          bottom: 0, // El contenedor estará en la parte inferior de la pantalla
          left: 0,
          right: 0,
          child: Container(
            width: screenSize.width, // Extender al ancho completo
            height: screenSize.height * 0.27, // 25% de la altura total
            decoration: const BoxDecoration(
              color: Colors.black54, // Fondo negro semi-transparente
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 50),
              child: CustomPaint(
                painter:
                    CuboPainter(), // Llamada a la clase CuboPainter desde el archivo importado
                size: Size(
                    screenSize.width * 0.8,
                    screenSize.height *
                        0.15), // Ajustar el tamaño del CustomPaint
              ),
            ),
          ),
        ),
      ]),

      floatingActionButton: EscanearCubo(
          initializeControllerFuture: _initializeControllerFuture,
          controller: _controller),
    );
  }
}


