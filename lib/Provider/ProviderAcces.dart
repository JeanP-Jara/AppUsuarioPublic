
import 'package:app_all_one/Model/AccessClass.dart';
import 'package:flutter/material.dart';

class AccesProvider with ChangeNotifier {
  AccessClass _accessClass = AccessClass(id_movil: "", b_mapa: false, b_lista: false, c_nombre: "");

  AccessClass get getAccesClass => _accessClass;

  void setAccesClass(AccessClass acces){
    _accessClass = acces;
    notifyListeners();
  }

}