import 'package:flutter/foundation.dart';

class MyProvider extends ChangeNotifier {
  List<int> _cubo = List.filled(54, 6); // Inicializa el cubo con 54 posiciones
  int _cara = 0;

  List<int> get cubo => _cubo;
  int get cara => _cara;

  set cubo(List<int> newCubo) {
    _cubo = newCubo;
    notifyListeners(); // Notifica a los listeners cuando el cubo cambia
  }

  set cara(int newCara) {
    _cara = newCara;
    notifyListeners(); // Notifica a los listeners cuando la cara cambia
  }
}
