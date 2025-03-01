import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:provider/provider.dart';
import 'providers/provider.dart';

Future<List> analizarImagen(String imagePath, BuildContext context, int cara) async {
  final myProvider = Provider.of<MyProvider>(context, listen: false); // Obtén el Provider

  try {
    File imageFile = File(imagePath);
    Uint8List imageBytes = await imageFile.readAsBytes();
    img.Image? image = img.decodeImage(imageBytes);

    if (image != null) {
      int width = image.width;
      int l = width ~/ 9; // Calcular el tamaño de cada "celda"
      int k = cara;

      List<int> nuevoCubo = List.from(myProvider.cubo); // Crea una copia del cubo original

      for (int y = 1; y < 4; y++) {
        for (int x = 1; x < 4; x++) {
          num sumR = 0, sumG = 0, sumB = 0;
          int pixelCount = 0;

          for (int i = 10; i <= 20; i++) {
            for (int j = 10; j <= 20; j++) {
              int pixelX = (x * (l + l)) + i;
              int pixelY = (y * (l + l)) + j;

              if (pixelX >= 0 && pixelX < image.width && pixelY >= 0 && pixelY < image.height) {
                var pixel = image.getPixel(pixelX, pixelY);
                sumR += pixel.r;
                sumG += pixel.g;
                sumB += pixel.b;
                pixelCount++;
              }
            }
          }

          num avgR = sumR ~/ pixelCount;
          num avgG = sumG ~/ pixelCount;
          num avgB = sumB ~/ pixelCount;

          num ref = max(avgR, max(avgG, avgB));

          String color = "vacio";
          if (avgR >= ref * 0.85 && avgG >= ref * 0.85 && avgB >= ref * 0.85) {
            color = "Blanco";
            nuevoCubo[k] = 1;
          } else if (avgR >= ref * 0.85 && avgG >= ref * 0.75 && avgB < ref * 0.75) {
            color = "Amarillo";
            nuevoCubo[k] = 3;
          } else if (avgR >= ref * 0.85 && avgG >= ref * 0.35 && avgB < ref * 0.35) {
            color = "Naranja";
            nuevoCubo[k] = 0;
          } else if (avgR >= ref * 0.95 && avgG < ref * 0.6 && avgB < ref * 0.8) {
            color = "Rojo";
            nuevoCubo[k] = 2;
          } else if (avgR < ref * 0.8 && avgG >= ref * 0.95 && avgB < ref * 0.8) {
            color = "Verde";
            nuevoCubo[k] = 5;
          } else if (avgR < ref * 0.8 && avgG < ref * 0.8 && avgB >= ref * 0.95) {
            color = "Azul";
            nuevoCubo[k] = 4;
          }

          print('Celda en ($x, $y): $color --> Promedio Max: $ref R=$avgR, G=$avgG, B=$avgB');
          k++;
        }
      }
      myProvider.cubo = nuevoCubo; // Actualiza el cubo en el Provider
    } else {
      //print("No se pudo decodificar la imagen.");
    }
  } catch (e) {
    //print("Error al analizar la imagen: $e");
  }

  return myProvider.cubo; // Retorna el cubo actualizado
}
