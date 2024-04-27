import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telodigo/data/controllers/usercontroller.dart';
import 'package:telodigo/domain/models/habitaciones.dart';
import 'package:telodigo/domain/models/hoteles.dart';
import 'package:telodigo/domain/models/images.dart';
import 'package:telodigo/ui/components/customcomponents/customalert.dart';

class PeticionesNegocio {
  static final CollectionReference collection =
      FirebaseFirestore.instance.collection("Negocios");
  static final UserController controlleruser = Get.find();

  static Future<List<Hoteles>> listNegocios() async {
    final QuerySnapshot querySnapshot = await collection
        .where('user', isEqualTo: controlleruser.usuario!.userName)
        .get();

    List<Hoteles> hoteles = [];

    final List<DocumentSnapshot> documents = querySnapshot.docs;

    for (DocumentSnapshot data in documents) {
      final String direccion = data["direccion"];

      final String horaAbrir = data["horaAbrir"];

      final String horaCerrar = data["horaCerrar"];

      final double latitud = data["latitud"];

      final double longitud = data["longitud"];

      final String nombre = data["nombre"];

      final double saldo = data["saldo"];

      final String tipoEspacio = data["tipoEspacio"];

      final List<String> servicios = (data["servicios"] as List).cast<String>();

      final List<String> metodosPago =
          (data["metodosPago"] as List).cast<String>();

      final List<dynamic> fotosJson = (data["fotos"] as List).cast<dynamic>();
      final List<Imagens> fotos =
          fotosJson.map((json) => Imagens.fromJson(json)).toList();

      final List<dynamic> habitacionesJson =
          (data["habitaciones"] as List).cast<dynamic>();
      final List<Habitaciones> habitaciones =
          habitacionesJson.map((json) => Habitaciones.fromMap(json)).toList();

      Hoteles hotel = Hoteles(
          saldo: saldo,
          user: controlleruser.usuario!.userName,
          fotos: fotos,
          servicios: servicios,
          metodosPago: metodosPago,
          direccion: direccion,
          nombre: nombre,
          tipoEspacio: tipoEspacio,
          habitaciones: habitaciones,
          latitud: latitud,
          longitud: longitud,
          horaAbrir: horaAbrir,
          horaCerrar: horaCerrar);

      hoteles.add(hotel);

      
    }



    return hoteles;
  }

  static Future<String> crearNegocio(
      Map<String, dynamic> hotel, BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: CircularProgressIndicator(),
                width: 30,
                height: 30,
              ),
              SizedBox(
                width: 30,
              ),
              Text("Creando Negocio..."),
            ],
          ),
        );
      },
    );

    try {
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
