import 'dart:io';

import 'package:app_all_one/Const/Spinner.dart';
import 'package:app_all_one/Model/UserClass.dart';
import 'package:app_all_one/Pages/Drawer/Drawer.dart';
import 'package:app_all_one/data/bd.dart';
import 'package:flutter/material.dart';
import 'package:app_all_one/Const/Constants.dart' as constants;

class SincronizarPage extends StatefulWidget {
  const SincronizarPage({Key? key}) : super(key: key);

  @override
  State<SincronizarPage> createState() => _SincronizarPageState();
}

class _SincronizarPageState extends State<SincronizarPage> {

  int _index = 0;
  List<User> listUserGuardados = [];
  List<User> listUserGuardadosAux = [];

  List<User> listUserSincronizados = [];
  List<User> listUserSincronizadosAux = [];

  @override
  void initState() {
    getInfo();
    super.initState();
  }

  getInfo() async {
    listUserGuardadosAux = await BD.getUserGuardados();
    listUserSincronizadosAux = await BD.getUserSincronizados();
    setState(() {
      listUserGuardados = listUserGuardadosAux;
      listUserSincronizados = listUserSincronizadosAux;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Sincronizar"),
            centerTitle: true,
            bottom: TabBar(
              tabs: [
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Guardados", style: TextStyle(color: Colors.white),),
                      const SizedBox(width: 6,),
                      listUserGuardados.isNotEmpty ? Container(
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(9)
                        ),
                        child: Center(child: Text(listUserGuardados.length.toString(), style: const TextStyle(fontSize: 12, color: Colors.black)),),
                      ): Container()
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Enviados", style: TextStyle(color: Colors.white),),
                      const SizedBox(width: 6,),
                      listUserSincronizados.isNotEmpty ? Container(
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(9)
                        ),
                        child: Center(child: Text(listUserSincronizados.length.toString(), style: const TextStyle(fontSize: 12, color: Colors.black)),),
                      ): Container()
                    ],
                  ),
                )
              ],
              onTap: (value) {
                setState(() {
                  _index = value;
                });
              },
            ),
            /*flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color.fromRGBO(4, 27, 51, 1) , Color.fromRGBO(4, 59, 100, 1),Color.fromRGBO(4, 140, 175, 1)]
                ),
              ),
            ),*/
          ),
          drawer: const Drawer(
            child: DrawerAll(),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              showDialogCarga(context);
              await BD.actualizarEstado(listUserGuardados)
                  .then((value) async {
                    await getInfo();
                    Navigator.pop(context);
              });

            },
            child: const Icon(Icons.send),
          ),
          body: TabBarView(
            children: [
              listUsuarioGuardados(),
              listUsuarioSincronizados(),
            ],
          ),
        )
    );
  }

  listUsuarioGuardados(){
    return
        ListView.builder(
          itemCount: listUserGuardados.length,
          itemBuilder: (context, i) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                      children: [
                        Container(
                            width: 60,
                            height: 60,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: listUserGuardados[i].image == "" ? const Icon(Icons.person) : Image.file(File(listUserGuardados[i].image), fit: BoxFit.cover,),
                            )
                        ),
                        const SizedBox(width: 10),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(listUserGuardados[i].name, /*style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500)*/),
                              const SizedBox(height: 5,),
                              Text(listUserGuardados[i].username,
                                  style: TextStyle(color: Colors.grey[500])),
                            ]
                        )
                      ]
                  ),
                ],
              ),
            );
          },
        );
  }
  listUsuarioSincronizados(){
    return
      ListView.builder(
        itemCount: listUserSincronizados.length,
        itemBuilder: (context, i) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                    children: [
                      SizedBox(
                          width: 60,
                          height: 60,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: listUserSincronizados[i].image == "" ? const Icon(Icons.person) : Image.file(File(listUserSincronizados[i].image), fit: BoxFit.cover,),
                          )
                      ),
                      const SizedBox(width: 10),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(listUserSincronizados[i].name, /*style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500)*/),
                            const SizedBox(height: 5,),
                            Text(listUserSincronizados[i].username,
                                style: TextStyle(color: Colors.grey[500])),
                          ]
                      )
                    ]
                ),
              ],
            ),
          );
        },
      );
  }

  showDialogCarga(BuildContext context){
    return showDialog(
        barrierDismissible: false,
        barrierColor: constants.BARRIER_COLOR,
        context: context,
        builder: (BuildContext context){
          return Spinner.spinnerCarga;
        }
    );
  }
}
