import 'package:app_all_one/Provider/ProviderAcces.dart';
import 'package:app_all_one/Routes/Routes.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:app_all_one/Const/Constants.dart' as constants;
import 'package:provider/provider.dart';

class DrawerAll extends StatefulWidget {
  const DrawerAll({Key? key}) : super(key: key);

  @override
  State<DrawerAll> createState() => _DrawerAllState();
}


int _selectedDrawerItem = 1;

class _DrawerAllState extends State<DrawerAll> {
  final padding = const EdgeInsets.symmetric(horizontal: 20);


  _onSelectedItem(int pos) {
    setState(() {
      _selectedDrawerItem = pos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      //color: Color.fromRGBO(66, 66, 66, 1),
      child: ListView(
        padding: padding,
        children: [
          FadeInLeft(
            child: const DrawerHeader(
              /*decoration: BoxDecoration(
                      color: Color.fromRGBO(44, 240, 233, 1),
                    ),*/
              child: Text(
                'Menu',
                style: TextStyle(
                  //color: Colors.white,
                  fontSize: 26,
                ),
              ),
            ),
          ),
          context.watch<AccesProvider>().getAccesClass.b_lista ? ListTile(
            leading: FadeInLeft(
              child: const Icon(
                Icons.format_list_bulleted_outlined,
                size: constants.iconSizeDrawer,
              ),
            ),
            title: FadeInLeft(
              child: const Text('Listado de usuarios',
                  style: TextStyle(
                    fontSize: constants.fontSizeDrawer,
                  )),
            ),
            selected: (1 == _selectedDrawerItem),
            selectedColor: constants.selectedColorDrawer,
            selectedTileColor: constants.selectedTileColorDrawer,
            onTap: () {
              _onSelectedItem(1);
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, Routes.LIST_PERSONA);
            },
          ) : Container(),
          context.watch<AccesProvider>().getAccesClass.b_mapa ? ListTile(
            leading: FadeInLeft(
              child: Icon(
                _selectedDrawerItem == 2 ? Icons.map_rounded: Icons.map_outlined,
                size: constants.iconSizeDrawer,
              ),
            ),
            title: FadeInLeft(
              child: const Text(
                'Mapa',
                style: TextStyle(fontSize: constants.fontSizeDrawer),
              ),
            ),
            selected: (2 == _selectedDrawerItem),
            selectedColor: constants.selectedColorDrawer,
            selectedTileColor: constants.selectedTileColorDrawer,
            onTap: () {
              _onSelectedItem(2);
              Navigator.of(context);
              Navigator.pushReplacementNamed(context, Routes.MAPA);
            },
          ): Container(),
          ListTile(
            leading: FadeInLeft(
              child: const Icon(
                Icons.format_list_bulleted_outlined,
                size: constants.iconSizeDrawer,
              ),
            ),
            title: FadeInLeft(
              child: const Text(
                'Lista Offline',
                style: TextStyle(fontSize: constants.fontSizeDrawer),
              ),
            ),
            selected: (3 == _selectedDrawerItem),
            selectedColor: constants.selectedColorDrawer,
            selectedTileColor: constants.selectedTileColorDrawer,
            onTap: () {
              _onSelectedItem(3);
              Navigator.of(context);
              Navigator.pushReplacementNamed(context, Routes.LIST_OFFLINE);
            },
          ),
          ListTile(
            leading: FadeInLeft(
              child: const Icon(
                Icons.format_list_bulleted_outlined,
                size: constants.iconSizeDrawer,
              ),
            ),
            title: FadeInLeft(
              child: const Text(
                'Sincronizar',
                style: TextStyle(fontSize: constants.fontSizeDrawer),
              ),
            ),
            selected: (4 == _selectedDrawerItem),
            selectedColor: constants.selectedColorDrawer,
            selectedTileColor: constants.selectedTileColorDrawer,
            onTap: () {
              _onSelectedItem(4);
              Navigator.of(context);
              Navigator.pushReplacementNamed(context, Routes.SINCRONIZAR);
            },
          ),
          const Divider(/*color: Colors.white,*/),
          FadeInLeft(
            child: ListTile(
              leading: const Icon(
                Icons.close_outlined,
                size: constants.iconSizeDrawer,
              ),
              title: const Text(
                'Salir',
                style: TextStyle(fontSize: constants.fontSizeDrawer),
              ),
              onTap: () {
                Navigator.of(context);
                Navigator.pushReplacementNamed(context, Routes.QR);
              },
            ),
          ),
        ],
      ),
    );
  }
}
