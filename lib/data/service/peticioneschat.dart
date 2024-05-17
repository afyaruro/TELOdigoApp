import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:telodigo/domain/models/mensaje.dart';
import 'package:telodigo/domain/models/mensajesHotel.dart';

class PeticionesChats {
  static final CollectionReference collection =
      FirebaseFirestore.instance.collection("Chats");

  static final CollectionReference collection2 =
      FirebaseFirestore.instance.collection("Mensajes");

  static Future<bool> chatExists(MensajesHotel chat) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Chats')
        .where('idReserva', isEqualTo: chat.idReserva)
        .get();

    return querySnapshot.size > 0;
  }

  static Future SendChat(
      Mensaje mensaje, MensajesHotel chat, BuildContext context) async {
    bool exist = await chatExists(chat);
    if (exist) {
      // print(
      //     "Ya existe un chat para esta reserva aqui irian solo enviar mensaje");
      await SendMensaje(mensaje, context);
    } else {
      await collection.doc().set(chat.toJson());

      await SendMensaje(mensaje, context);

      return true;
    }
  }

  static Future SendMensaje(Mensaje mensaje, BuildContext context) async {
    mensaje.position = await countMensajes(mensaje.id);

    await collection2.doc().set(mensaje.toJson());

    QuerySnapshot querySnapshot =
        await collection.where('idReserva', isEqualTo: mensaje.id).get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot document = querySnapshot.docs.first;
      String documentoId = document.id;
      String stringNoLeidos = document['noLeidos'];
      int noLeidosActual = int.parse(stringNoLeidos);

      if (mensaje.type == "cliente") {
        await collection.doc(documentoId).update({
          'noLeidos': (noLeidosActual + 1).toString(),
        });
      }

      await collection.doc(documentoId).update({
        'ultimoMensaje': mensaje.mensaje,
        'fecha': DateTime.now(),
      });
    }
  }

  static Future<int> countMensajes(String idReserva) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Mensajes')
        .where('id', isEqualTo: idReserva)
        .get();

    return querySnapshot.size + 1;
  }

  static Future<void> ActualizarVistoReserva(String idReserva) async {
    QuerySnapshot querySnapshot =
        await collection.where('idReserva', isEqualTo: idReserva).get();

    QuerySnapshot querySnapshot2 = await collection2
        .where('id', isEqualTo: idReserva)
        .where('type', isEqualTo: 'cliente')
        .where('estado', isEqualTo: 'Enviado')
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      for (DocumentSnapshot document in querySnapshot.docs) {
        String documentoId = document.id;

        print(documentoId);

        await collection.doc(documentoId).update({
          'noLeidos': "0",
        });
      }
    }

    if (querySnapshot2.docs.isNotEmpty) {
      for (DocumentSnapshot document in querySnapshot2.docs) {
        String documentoId = document.id;

        await collection2.doc(documentoId).update({
          'estado': "visto",
        });
      }
    }
  }

  static Future<void> ActualizarVistoCliente(String idReserva) async {
    QuerySnapshot querySnapshot = await collection2
        .where('id', isEqualTo: idReserva)
        .where('type', isEqualTo: 'hotel')
        .where('estado', isEqualTo: 'Enviado')
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      for (DocumentSnapshot document in querySnapshot.docs) {
        String documentoId = document.id;

        await collection2.doc(documentoId).update({
          'estado': "visto",
        });
      }
    }
  }
}
