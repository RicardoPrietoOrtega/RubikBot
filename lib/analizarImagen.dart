import 'dart:io';
import 'dart:typed_data'; // Importar Uint8List
import 'package:image/image.dart' as img;
import 'package:image/image.dart';

void analizarImagen(String imagePath) async {
  // Cargar la imagen desde el archivo
  File imageFile = File(imagePath);

  // Leer los bytes de la imagen y convertirlos a Uint8List
  Uint8List imageBytes = await imageFile.readAsBytes();

  // Decodificar la imagen usando el paquete 'image'
  img.Image? image = img.decodeImage(imageBytes);

  if (image != null) {
    // Obtener las dimensiones de la imagen
    int width = image.width;
    int height = image.height;

    // Recorrer los píxeles y obtener los valores RGB
    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        // Obtener el valor del píxel en la posición (x, y)
        Pixel pixel = image.getPixel(x, y);

        // Extraer los canales RGB del píxel
        num red = pixel.r;
        num green = pixel.g;
        num blue = pixel.b;

        // Aquí puedes realizar un análisis, por ejemplo, calcular el color promedio
        print('Pixel en ($x, $y): R=$red, G=$green, B=$blue');
      }
    }
  } else {
    print("No se pudo decodificar la imagen.");
  }
}
