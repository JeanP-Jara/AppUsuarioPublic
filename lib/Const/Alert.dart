import 'package:app_all_one/Routes/Routes.dart';
import 'package:flutter/material.dart';
import 'package:app_all_one/Const/Constants.dart' as constants;

showAlertSuccess(BuildContext context, String titulo,String mensaje){
  return showDialog(
      barrierDismissible: false,
      barrierColor: constants.BARRIER_COLOR,
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          icon: const Icon(Icons.check_circle, size: constants.ICON_SIZE,),
          iconColor: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(titulo),
          content: Text(mensaje),
          actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          actions: [
            TextButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                child: const Text(constants.ACEPTAR)
            ),
          ],
        );
      }
  );
}

showAlertError(BuildContext context, String titulo,String mensaje){
  return showDialog(
      barrierDismissible: false,
      barrierColor: constants.BARRIER_COLOR,
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          icon: const Icon(Icons.error, size: constants.ICON_SIZE,),
          iconColor: Colors.redAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(titulo),
          content: Text(mensaje),
          actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          actions: [
            TextButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                child: const Text(constants.ACEPTAR)
            ),
          ],
        );
      }
  );
}

showAlertWarning(BuildContext context, String titulo,String mensaje){
  return showDialog(
      barrierDismissible: false,
      barrierColor: constants.BARRIER_COLOR,
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          icon: const Icon(Icons.warning, size: constants.ICON_SIZE,),
          iconColor: Colors.orange,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(titulo),
          content: Text(mensaje),
          actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          actions: [
            TextButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                child: const Text(constants.ACEPTAR)
            ),
          ],
        );
      }
  );
}

showAlertWarningAcceso(BuildContext context, String titulo,String mensaje){
  return showDialog(
      barrierDismissible: false,
      barrierColor: constants.BARRIER_COLOR,
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          icon: const Icon(Icons.warning, size: constants.ICON_SIZE,),
          iconColor: Colors.orange,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(titulo),
          content: Text("$mensaje\n${constants.MSN_VERSION_LIMITADA}"),
          actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          actions: [
            TextButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                child: const Text(constants.CANCELAR)
            ),
            TextButton(
                onPressed: (){
                  Navigator.pop(context);
                  Navigator.pushNamed(context, Routes.LIST_OFFLINE);
                },
                child: const Text(constants.CONTINUAR)
            ),
          ],
        );
      }
  );
}





