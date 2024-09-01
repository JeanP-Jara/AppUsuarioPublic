import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


//INFO PAGE
const String OMITIR = "Omitir";
const String SIGUIENTE = "Siguiente";
const String BTN_INICIAR = "Iniciar";

const String NOMBRE = "Nombre";
const String CONCEDER_PERMISO = "Conceder permiso";
const String TITULO_HOME = "Conceder Acceso";

//DRAWER
const iconSizeDrawer = 30.0;
const fontSizeDrawer = 18.0;
const selectedColorDrawer = Color.fromRGBO(255, 255, 255, 1);
const selectedTileColorDrawer = Color.fromRGBO(184, 29, 83, 1);

//PanelList
const backGroundPanel = Color.fromRGBO(66, 66, 66, 1);

//Mapa
const initialCameraPosition = CameraPosition(target: LatLng(-9.2435384,-75.0195047), zoom: 5.5);

//QR

const String CONTINUAR = "Continuar";

const BARRIER_COLOR = Color.fromRGBO(14, 106, 142 , 0.7);

//DIALOG
const double ICON_SIZE = 30.0;
const String ACEPTAR = "Aceptar";
const String CANCELAR = "Cancelar";
const String SUCCESO = "Succeso";
const String EXITO = "Exito";
const String ERROR = "Error";
const String ERROR_CONEXION = "Error en la conexión. \nVerifique su conexión a internet o comuniquese con el administrador";
const String SIN_ACCESO = "Sin acceso";
const String COM_ADMINISTRADOR = "Comuniquese con el administrador.";
const String MSN_VERSION_LIMITADA = "Puede continuar con el modo offline con acceso limitado.";