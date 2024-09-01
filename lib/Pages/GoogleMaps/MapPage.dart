import 'package:app_all_one/Pages/Drawer/Drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:app_all_one/Const/Constants.dart' as constants;
import 'package:geolocator/geolocator.dart';

class MapaPage extends StatefulWidget {
  const MapaPage({Key? key}) : super(key: key);

  @override
  State<MapaPage> createState() => _MapState();
}

class _MapState extends State<MapaPage> {
  late GoogleMapController controllerMap;

  final List<Marker> _markers = [];

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission().then((value){
    }).onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print("ERROR"+error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controllerMap.dispose();
    super.dispose();
  }

  getLocation() async {

    await Geolocator.requestPermission().then((value){
    }).onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print("ERROR"+error.toString());
    });

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    double lat = position.latitude;
    double long = position.longitude;

    LatLng location = LatLng(lat, long);
    CameraPosition cameraPosition = CameraPosition(
      target: location,
      zoom: 14,
    );

    setState(() {
      controllerMap.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mapa"),
      ),
      drawer: const Drawer(
        child: DrawerAll(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          getLocation();
        },
        child: Icon(Icons.my_location),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: constants.initialCameraPosition,
            onMapCreated: (GoogleMapController controller){
              controllerMap = controller;
              //_controller.complete(controller);
            },
            onTap: (position) {
              setState(() {
                _markers.add(
                  Marker(
                      markerId: MarkerId(_markers.length.toString()),
                      position: LatLng(position.latitude, position.longitude),
                      infoWindow: const InfoWindow(
                        title: 'Nuevo Marker',
                      )
                  ),
                );
                controllerMap.animateCamera(
                    CameraUpdate.newCameraPosition(
                        CameraPosition(target: position, zoom: 14)
                    )
                );
              });
            },
            markers: Set<Marker>.of(_markers),
            zoomControlsEnabled:false,
            rotateGesturesEnabled: false,
            indoorViewEnabled: false,
          ),
        ],
      ),
    );
  }
}

