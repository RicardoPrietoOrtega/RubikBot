import 'package:flutter/foundation.dart';

class MyProvider with ChangeNotifier {
  int _cara = 0;
  List _cubo = [6,6,6,6,6,6,6,6,6, 6,6,6,6,6,6,6,6,6, 6,6,6,6,6,6,6,6,6, 6,6,6,6,6,6,6,6,6, 6,6,6,6,6,6,6,6,6, 6,6,6,6,6,6,6,6,6];
    
  int get cara => _cara;

  set cara(int cara){
    _cara = cara;
    notifyListeners();
  }

  List get cubo => _cubo;

  set cubo(List cubo){
    _cubo = cubo;
    notifyListeners();
  }     
}