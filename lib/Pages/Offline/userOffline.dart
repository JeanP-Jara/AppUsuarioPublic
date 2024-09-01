import 'dart:io';

import 'package:app_all_one/Model/UserClass.dart';
import 'package:app_all_one/data/bd.dart';
import 'package:flutter/material.dart';
import 'package:app_all_one/Const/Constants.dart' as constants;
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:md5_file_checksum/md5_file_checksum.dart';
import 'package:path_provider/path_provider.dart';

class UserOfflineEdit extends StatefulWidget {
  const UserOfflineEdit({Key? key, this.user}) : super(key: key);
  final User? user;

  @override
  State<UserOfflineEdit> createState() => _UserOfflineEditState();
}

class _UserOfflineEditState extends State<UserOfflineEdit> {
  User user = User(name: "", username: "", image: "", isFollowedByMe: false);

  final formkey = GlobalKey<FormState>();

  final picker = ImagePicker();

  bool edit = false;

  @override
  void initState() {
    getUsuario();
    super.initState();
  }

  getUsuario(){
    if(widget.user != null){
      setState(() {
        user = widget.user!;
        edit = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Editar Usuario"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width*0.5,
                          height: MediaQuery.of(context).size.width*0.5,
                          decoration: BoxDecoration(
                            image: user.image == "" ? null :
                              DecorationImage(
                                image: FileImage(File(user.image)),
                                fit: BoxFit.fitWidth,
                              ),
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width*0.5)
                          ),
                          child: user.image == "" ? Icon(Icons.person, size: MediaQuery.of(context).size.width*0.3,) : null,
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width*0.5,
                            height: MediaQuery.of(context).size.width*0.5,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child:  FloatingActionButton(
                                  onPressed: () {
                                    DialogFotoAdd(context);
                                  },
                                  child: const Icon(Icons.camera_alt,),
                                ),
                              ),
                            )
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 12,),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Nombre',
                  ),
                  initialValue: user.name == "" ? null : user.name,
                  onSaved: (value){
                    user.name = value!;
                  },
                ),
                const SizedBox(height: 12,),
                TextFormField(
                  decoration: const InputDecoration(
                      hintText: 'Usuario',
                  ),
                  initialValue: user.username == "" ?  null : user.username,
                  onSaved: (value){
                    user.username = value!;
                  },
                ),
                const SizedBox(height: 12,),
                Row(
                  children: [
                    const Text("Seguir"),
                    Checkbox(
                        value: user.isFollowedByMe,
                        onChanged: (value){
                          setState(() {
                            user.isFollowedByMe = value!;
                          });
                        }
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*5/100, vertical: 24),
                  child: ElevatedButton(
                      onPressed: () async {
                        formkey.currentState?.save();
                        int i = 0;
                        print("${user.username} - ${user.name}");
                        user.sincronizar = "0";
                        if(edit){
                          i = await BD.updateUser(user);
                          if(i > 0){
                            print("Update CORRECT :)");
                            Navigator.pop(context);
                          }
                        }else{
                          i = await BD.insertUser(user);
                          if(i > 0){
                            print("Insert CORRECT :)");
                            Navigator.pop(context);
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          shape: const StadiumBorder(),
                          padding: const EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 8
                          )
                      ),
                      child: const Text("GUARDAR", style: TextStyle( fontSize: 16.0,),)
                  ),
                )

              ],
            )
        ),
      )
    );
  }

  DialogFotoAdd(BuildContext context){
    return showDialog(
        barrierDismissible: true,
        barrierColor: constants.BARRIER_COLOR,
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Text("Foto de perfil"),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FloatingActionButton(
                      onPressed: () {
                        setArchivo(true).then((value) {
                          Navigator.pop(context);
                        });
                      },
                      child: Icon(Icons.camera_alt),
                    ),
                    SizedBox(height: 8,),
                    Text("Cámara")
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FloatingActionButton(
                      onPressed: () {
                        setArchivo(false);
                      },
                      child: Icon(Icons.insert_photo),
                    ),
                    SizedBox(height: 8,),
                    Text("Galería")
                  ],
                )
              ],
            ),
          );
        }
    );
  }

  getCompress(File file) async {
    final filePath = file.absolute.path;
    final lastIndex = filePath.lastIndexOf(new RegExp(r'.jp'));
    final splitted = filePath.substring(0, (lastIndex));
    final outPath = "${splitted}_out${filePath.substring(lastIndex)}";
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path, outPath,
      quality: 75,
    );
    return result;
  }

  Future setArchivo(bool opc) async {
    File? img;
    XFile? pickedFile;
    bool val = false;
    String msn = "";
    final LostDataResponse response = await picker.retrieveLostData();
    if(opc){
      pickedFile = await picker.pickImage(source: ImageSource.camera);

    }else{
      pickedFile = await picker.pickImage(source: ImageSource.gallery);
    }

    img = File(pickedFile!.path);

    if (pickedFile != null) {
      print("RETORNA IMG");
      var result = await getCompress(img);

      print( "result!.lengthSync ${result!.lengthSync()}");
      print(img.readAsBytesSync().lengthInBytes);

      final fileChecksum = await Md5FileChecksum.getFileChecksum(filePath: result.absolute.path);
      print("fileChecksum: $fileChecksum");

      final Directory extDir = await getApplicationDocumentsDirectory();
      String dirPath = extDir.path;

      final String filePath = '$dirPath/$fileChecksum.jpg';

      try {
        final File newImage = await img.copy(filePath);
        msn = "Foto Cargado.";
        val = true;
      } catch (e) {
        print("Error: $e");
        msn = "Error al cargar foto. Intente de nuevo.";
      }

      if (val) {
        final File newImage = await img.copy(filePath);
        Navigator.pop(context);
        try{
          setState(() {
            user.image = filePath;
          });

        }catch(e){
          print(e.toString());
          msn = "Error al guardar foto. Intente de nuevo.";
        }
      }
      showSnackBar(msn);

      //Navigator.of(context).pop();
    }else{
      Navigator.pop(context);
      msn = "Error al obtener foto. Intente de nuevo.";
      showSnackBar(msn);
    }
  }

  showSnackBar(String msn){
    final snackBar = SnackBar(
      content: Text(msn),
      action: SnackBarAction(
        label: 'OK',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
