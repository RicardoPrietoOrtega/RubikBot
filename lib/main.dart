import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'widgets/cubo_desarrollo.dart';
import 'package:provider/provider.dart';

import 'escanear_cubo.dart';
import 'providers/provider.dart';
import 'widgets/rejilla.dart';

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
    _controller = CameraController(
      widget.camera,                  
      ResolutionPreset.high,          
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {    
    _controller.dispose();
    super.dispose();                  
  }

  @override
  Widget build(BuildContext context) {    
    return ChangeNotifierProvider(
      create: (context)=>MyProvider(),
        child: Scaffold(
        appBar: AppBar(title: const Text('Escaner de Rubic')),
        body: Stack(
          children: [
          /**************************** IMAGEN DE LA CAMARA ***********************************************/
            FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {              
                  return CameraPreview(_controller);
                } else {              
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
            const Rejilla(),
            const CuboDesarrollo(),
          ] 
        ),

        floatingActionButton: EscanearCubo(
          initializeControllerFuture: _initializeControllerFuture,
          controller: _controller
        ),
      )
    );
  }
}