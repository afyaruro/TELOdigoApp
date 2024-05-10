import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telodigo/data/controllers/usercontroller.dart';
import 'package:telodigo/domain/models/reserva.dart';

class PeticionesReserva {
  static final CollectionReference collection =
      FirebaseFirestore.instance.collection("Reservas");

  static final CollectionReference collectionHotel =
      FirebaseFirestore.instance.collection("Negocios");
  static final UserController controlleruser = Get.find();

  static Future<String> RegistrarReserva(
      Reserva reserva, BuildContext context) async {
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
              Text("Reservando Habitación..."),
            ],
          ),
        );
      },
    );

    try {
      var docRef = collection.doc();
      await docRef.set(reserva.toJson()).timeout(
        Duration(seconds: 15),
        onTimeout: () async {
          await docRef.delete().timeout(Duration(seconds: 0), onTimeout: () {
            throw TimeoutException(
                "La operación ha tardado demasiado en completarse");
          });
        },
      );
      Navigator.pop(context);
      return "create";
    } catch (e) {
      print('Error al enviar el mensaje: $e');
      Navigator.pop(context);
      return "error";
    }
  }

  static Future<List<Reserva>> listReservas() async {
    final QuerySnapshot querySnapshot = await collection
        .where('idUser', isEqualTo: controlleruser.usuario!.userName)
        .get();

    List<Reserva> reservas = [];

    final List<DocumentSnapshot> documents = querySnapshot.docs;

    for (DocumentSnapshot data in documents) {
      if (data.data() != null) {
        Map<String, dynamic> jsonData = data.data()! as Map<String, dynamic>;
        Reserva reserva = Reserva.fromJson(jsonData);
        reservas.add(reserva);
      }
    }

    return reservas;
  }

  static Future<List<Reserva>> listReservasFiltro(String filtro) async {
    final QuerySnapshot querySnapshot = await collection
        .where('idUser', isEqualTo: controlleruser.usuario!.userName)
        .where('estado', isEqualTo: filtro)
        .get();

    List<Reserva> reservas = [];

    final List<DocumentSnapshot> documents = querySnapshot.docs;

    for (DocumentSnapshot data in documents) {
      if (data.data() != null) {
        Map<String, dynamic> jsonData = data.data()! as Map<String, dynamic>;
        Reserva reserva = Reserva.fromJson(jsonData);
        reservas.add(reserva);
      }
    }

    return reservas;
  }

  static Future<List<Reserva>> listReservasAnfitrion() async {
    final QuerySnapshot querySnapshot = await collection
        .where('idUserHotel', isEqualTo: controlleruser.usuario!.userName)
        .where('estado', isEqualTo: "En espera")
        .get();

    List<Reserva> reservas = [];

    final List<DocumentSnapshot> documents = querySnapshot.docs;

    for (DocumentSnapshot data in documents) {
      if (data.data() != null) {
        Map<String, dynamic> jsonData = data.data()! as Map<String, dynamic>;
        Reserva reserva = Reserva.fromJson(jsonData);
        reservas.add(reserva);
      }
    }

    return reservas;
  }

  static Future<void> VerificarCodigo(
      int id, int hotelid, String metodoPago, BuildContext context) async {
    try {
      QuerySnapshot querySnapshot =
          await collection.where('key', isEqualTo: id).get();

      DocumentSnapshot document = querySnapshot.docs.first;
      String documentoId = document.id;

      await collection.doc(documentoId).update({
        'estado': "En la Habitacion",
      });

      if (metodoPago == "Efectivo") {
        QuerySnapshot querySnapshot2 =
            await collectionHotel.where('id', isEqualTo: hotelid).get();

        DocumentSnapshot document2 = querySnapshot2.docs.first;
        String documentoId2 = document2.id;

        await collectionHotel.doc(documentoId2).update({
          'saldo': document2["saldo"] - 5.0,
        });

        
      }
    } catch (e) {
      print("Ocurrió un error: $e");
    }
  }
}
