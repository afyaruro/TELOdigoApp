import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telodigo/data/controllers/usercontroller.dart';
import 'package:telodigo/ui/components/customcomponents/customalert.dart';

class PeticionesNegocio {
  static final CollectionReference collection =
      FirebaseFirestore.instance.collection("Negocios");
  

  static Future<String> crearNegocio(
      Map<String, dynamic> hotel, BuildContext context) async {


showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return  AlertDialog(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(child: CircularProgressIndicator(), width: 30, height: 30,),
              SizedBox(width: 30,),
              Text("Creando Negocio..."),
            ],
          ),
        );
      },
    );


try{

    await collection.doc().set(hotel).timeout(
          Duration(seconds: 5),
          onTimeout: () async {
            Navigator.pop(context);
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return const CustomAlert(
                  title: "Error de Conexion",
                  text: "La operación ha tardado demasiado en completarse",
                );
              },
            );

            throw TimeoutException(
                "La operación ha tardado demasiado en completarse");
          },
        );

        return "create";

    } catch (error) {
      print("Error al agregar usuario: $error");
      return "error";
    }
  }
}
