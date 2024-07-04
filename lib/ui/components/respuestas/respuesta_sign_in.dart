import 'package:flutter/material.dart';
import 'package:telodigo/data/service/peticionesInicioSesion.dart';
import 'package:telodigo/ui/components/customcomponents/customalert.dart';
import 'package:telodigo/ui/pages/home/home.dart';

Future<bool> login(
    {required String user,
    required String password,
    required BuildContext context}) async {
  user = user.trim();
  password = password.trim();

  FocusScope.of(context).unfocus();

  if (user == "") {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return  CustomAlert(
          title: "Valida tu Informacion",
          text: "Por favor ingresa un usuario",
        );
      },
    );
  } else if (password == "") {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return  CustomAlert(
          title: "Valida tu Informacion",
          text: "Por favor ingresa la contraseña de tu cuenta",
        );
      },
    );
  } else {
    

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 10),
              Text("Iniciando Sesion..."),
            ],
          ),
        );
      },
    );

    var resp = await PeticionesInicioSesion.Login(user, password, context);

    if (resp == "Password-Correct") {
      Navigator.pop(context);
      // print("Hola, haz ingresado correctamente");
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomeUser()),
        (Route<dynamic> route) => false,
      );
    } else if (resp == "Password-Incorrect") {
      Navigator.pop(context);
      showDialog(
      context: context,
      builder: (BuildContext context) {
        return  CustomAlert(
          title: "Valida tu Informacion",
          text: "La contraseña indicada es incorrecta",
        );
      },
    );
    } else if (resp == "no-exist") {
      Navigator.pop(context);
      showDialog(
      context: context,
      builder: (BuildContext context) {
        return  CustomAlert(
          title: "Valida tu Informacion",
          text: "El usuario no se encuentra registrado en el sistema",
        );
      },
    );
    } else if (resp == "timeout") {
    } else {
      Navigator.pop(context);
      showDialog(
      context: context,
      builder: (BuildContext context) {
        return  CustomAlert(
          title: "Error Desconocido",
          text: "Estamos teniendo errores por favor intenta mas tarde",
        );
      },
    );
    }

    return true;
  }

  return false;
}
