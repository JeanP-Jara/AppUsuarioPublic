import 'dart:io';
import 'package:app_all_one/Const/Alert.dart';
import 'package:app_all_one/Const/Spinner.dart';
import 'package:app_all_one/Model/AccessClass.dart';
import 'package:app_all_one/Provider/ProviderAcces.dart';
import 'package:app_all_one/Routes/Routes.dart';
import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:app_all_one/Const/Constants.dart' as constants;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PageQR extends StatefulWidget {
  const PageQR({Key? key}) : super(key: key);

  @override
  State<PageQR> createState() => _PageQRState();
}

class _PageQRState extends State<PageQR> {
  String _idMovil = "";
  String _modeloMovil = "";
  String _androidVersion = "";

  @override
  void initState() {
    _getId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Código QR"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
                padding: EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    _setTextInfo("Código",_idMovil),
                    _setTextInfo("Modelo",_modeloMovil),
                    _setTextInfo("Android",_androidVersion),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.white,
              child: QrImageView(
                data: _idMovil,
                version: QrVersions.auto,
                gapless: false,
                errorStateBuilder: (cxt, err) {
                  return const Center(
                    child: Text(
                      "Error! no se puedo genera código QR...",
                      textAlign: TextAlign.center,
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*5/100, vertical: 24),
              child: ElevatedButton(
                  onPressed: (){
                    //Navigator.pushNamed(context, Routes.QR);

                    showDialog(
                        barrierDismissible: false,
                        barrierColor: constants.BARRIER_COLOR,
                        context: context,
                        builder: (BuildContext context){
                          return Spinner.spinnerCarga;
                        }
                    );
                    getListUser( context );

                  },
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 8
                      )
                  ),
                  child: const Text(constants.CONTINUAR, style: TextStyle( fontSize: 16.0,),)
              ),
            )

          ],
        ),
      ),
    );
  }

  Future _getId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      setState(() {
        _idMovil = iosDeviceInfo.identifierForVendor!;
      });
    } else if(Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      String versionAndroid = _getAndroid(androidDeviceInfo.version.sdkInt);
      setState(() {
        _idMovil = androidDeviceInfo.id;
        _androidVersion = versionAndroid;
        _modeloMovil = androidDeviceInfo.model;
      });
    }
  }

  String _getAndroid(int sdk){
    String versionAndroid = "";
    switch(sdk){
      case 26:
        versionAndroid = "8.0";
        break;
      case 27:
        versionAndroid = "8.1";
        break;
      case 28:
        versionAndroid = "9";
        break;
      case 29:
        versionAndroid = "10";
        break;
      case 30:
        versionAndroid = "11";
        break;
      case 31:
        versionAndroid = "12";
        break;
      case 32:
        versionAndroid = "12";
        break;
      case 33:
        versionAndroid = "13";
        break;

    }
    return versionAndroid;
  }

  Widget _setTextInfo(String titulo, String info){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("$titulo: "),
          Text(info)
        ],
      ),
    );
  }

  void getListUser(BuildContext context) async {
    final list = await FirebaseFirestore.instance.collection("access").where('id_movil', isEqualTo: _idMovil).get()
        .catchError((value){
          showAlertError(context, constants.ERROR, constants.ERROR_CONEXION);
        });
    Navigator.pop(context);
    if(list.docs.isNotEmpty ){
      context.read<AccesProvider>().setAccesClass(AccessClass.fromJson(list.docs[0]));
      Navigator.pushNamed(context, Routes.LIST_PERSONA);
    }else{
      AccessClass accessClass = AccessClass(id_movil: "", b_mapa: false, b_lista: false, c_nombre: "");
      context.read<AccesProvider>().setAccesClass(accessClass);
      showAlertWarningAcceso(context, constants.SIN_ACCESO, constants.COM_ADMINISTRADOR);
    }
  }
}
