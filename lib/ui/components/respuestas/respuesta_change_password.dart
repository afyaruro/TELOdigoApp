import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telodigo/data/controllers/usercontroller.dart';
import 'package:telodigo/data/service/peticioneschangePassword.dart';
import 'package:telodigo/ui/components/customcomponents/customalert.dart';
import 'package:telodigo/ui/components/respuestas/respuesta_sign_up.dart';

Future<void> respuestaSendCode(
    {required String destinatario, required BuildContext context}) async {
  var code = generarCodigo();

  destinatario = destinatario.trim();

  UserController controllerPass = Get.find();

  await controllerPass.NewCode1(code, destinatario);

  await PeticionesChangePassword.EnviarCodigo(
      destino: destinatario, code: code);

  // print("Hola ${controllerPass.code}");

  await Future.delayed(Duration(minutes: 5), () async {
    await controllerPass.NewCode("");
    // print("Hola borrado ${controllerPass.code}");
  });
}

Future<void> respuestaChangePassword({
  required BuildContext context,
  required String codigo,
  required String pass,
  required String confpass,
  required String correo,
}) async {
  UserController controllerPass = Get.find();

  codigo = codigo.trim();

  pass = pass.trim();
  confpass = confpass.trim();
  correo = correo.trim();

  // print(correo);

  if (codigo == "") {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlert(
          title: "Valida tu Informacion",
          text:
              "Ingresa el codigo de verificación que hemos mandado a tu correo",
        );
      },
    );
  } else if (pass == "") {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlert(
          title: "Valida tu Informacion",
          text: "Por favor ingresa la nueva contraseña",
        );
      },
    );
  } else if (confpass == "") {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlert(
          title: "Valida tu Informacion",
          text: "Por favor ingresa confirma tu contraseña",
        );
      },
    );
  } else {
    if (codigo == controllerPass.code) {
      if (!isPasswordSecure(pass)) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomAlert(
              title: "Contraseña Insegura",
              text:
                  "Por favor verifica que contenga almenos un numero, una letra minuscula, una letra mayuscula y sean almenos 7 caracteres",
            );
          },
        );
      } else {
        if (pass == confpass) {
          await PeticionesChangePassword.actualizarPassword(
              correo, pass, context);
          controllerPass.NewCode("");
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return CustomAlert(
                title: "Error de Contraseña",
                text: "Las contraseñas no coinciden",
              );
            },
          );
        }
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomAlert(
            title: "Valida tu Informacion",
            text: "Codigo de verificacion incorrecto",
          );
        },
      );
    }
  }
}

String generarCodigo() {
  var random = Random();
  int codigo = random.nextInt(900000) + 100000;
  return codigo.toString();
}
