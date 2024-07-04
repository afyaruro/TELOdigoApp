import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telodigo/data/controllers/usercontroller.dart';
import 'package:telodigo/domain/models/usuario.dart';
import 'package:telodigo/ui/components/customcomponents/customalert.dart';

class PeticionesInicioSesion {
  static Usuario? usuario;

  static final UserController controlleruser = Get.find();

  static final CollectionReference collection =
      FirebaseFirestore.instance.collection("Usuarios");

  static Future<String> Login(
      String user, String pass, BuildContext context) async {
    var resp = await buscarUsuario(user, context);

    if (resp == "exist") {
      if (usuario?.password == pass) {

        controlleruser.DatosUser(usuario!);
        return "Password-Correct";
      } else {
        return "Password-Incorrect";
      }
    } else {
      return resp;
    }
  }

  static Future<String> buscarUsuario(
      String userName, BuildContext context) async {
    try {
      DocumentSnapshot document = await collection
          .doc(userName)
          .get()
          .timeout(Duration(seconds: 10), onTimeout: () {
        throw TimeoutException(
            "La operación ha tardado demasiado en completarse");
      });

      if (document.exists) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        usuario = Usuario.desdeDoc(data);
        return "exist";
      } else {
        return "no-exist";
      }
    } catch (error) {
      Navigator.pop(context);
      print("Error al buscar usuario: $error");

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return  CustomAlert(
            title: "Error de Conexión",
            text: "Verifica tu conexión a internet",
          );
        },
      );

      return "timeout";
    }
  }
}
