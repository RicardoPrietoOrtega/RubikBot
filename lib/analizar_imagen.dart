import 'dart:io';
import 'dart:typed_data'; // Importar Uint8List
import 'package:image/image.dart' as img;
import 'package:image/image.dart';

Future<List> analizarImagen(String imagePath, List cubo, int cara) async {  
  File imageFile = File(imagePath);  
  Uint8List imageBytes = await imageFile.readAsBytes();  
  img.Image? image = img.decodeImage(imageBytes);

  if (image != null) {    
    int width = image.width;
    int l = (width / 9).toInt();
    String color = "vacio";
    int k = cara;
    print("Cara: $cara");
    for (int y = 1; y < 4; y++) {
      for (int x = 1; x < 4; x++) {        
        Pixel pixel = image.getPixel((x*(l+l)), (y*(l+l)));                
        num r = pixel.r;
        num g = pixel.g;
        num b = pixel.b;  
        color = "vacio";      
        if(r>=160 && g>=160 && b>=160) {
          color = "Blanco";
          cubo[k] = 1;  
        } else if (r>=120 && g>=120 && b<120){
          color = "Amarillo";
          cubo[k] = 3;
        } else if (r>=120 && g>=50 && b<60){
          color = "Naranja";
          cubo[k] = 0;
        } else if (r>=120 && g<60 && b<60){
          color = "Rojo";
          cubo[k] = 2;
        } else if (r<60 && g>=80 && b<60){
          color = "Verde";
          cubo[k] = 5;
        } else if (r<100 && g<120 && b>=120){
          color = "Azul";
          cubo[k] = 4;
        }       
        print('Pixel en ($x, $y): $color --> R=$r, G=$g, B=$b');
        k++;
      }
    }    
  } else {
    print("No se pudo decodificar la imagen.");
  }
  return cubo;
}
