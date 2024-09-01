
import 'package:app_all_one/Pages/List/ListPerson.dart';
import 'package:app_all_one/Pages/GoogleMaps/MapPage.dart';
import 'package:app_all_one/Pages/Offline/ListOffline.dart';
import 'package:app_all_one/Pages/Offline/Sincronizar.dart';
import 'package:app_all_one/Pages/QR/PageQR.dart';
import 'package:app_all_one/Pages/Welcome/Info.dart';
import 'package:app_all_one/Routes/Routes.dart';
import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext)> appRoutes(){
  return{
    Routes.LIST_PERSONA:(_) => const ListPersonView(),
    Routes.INFO:(_) => const Info(),
    Routes.MAPA:(_) => const MapaPage(),
    Routes.QR:(_) => const PageQR(),
    Routes.LIST_OFFLINE:(_) => const ListPersonOffline(),
    Routes.SINCRONIZAR:(_) => const SincronizarPage()
  };
}