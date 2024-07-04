import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:telodigo/data/controllers/usercontroller.dart';

class PeticionesPagos {
  static UserController controlleruser = Get.find();

  static final CollectionReference collection =
      FirebaseFirestore.instance.collection("Negocios");

  static final CollectionReference collectionUsuario =
      FirebaseFirestore.instance.collection("Usuarios");

  static Future<void> ActualizarSaldoNegocio(
      String idNegocio, double saldo) async {
    QuerySnapshot querySnapshot =
        await collection.where('id', isEqualTo: idNegocio).get();

    if (querySnapshot.docs.isNotEmpty) {
      for (DocumentSnapshot document in querySnapshot.docs) {
        String documentoId = document.id;
        double saldoActual = document['saldo'];

        await collection.doc(documentoId).update({
          'saldo': saldoActual + saldo,
        });
      }
    }
  }

  static Future<void> generarPago(String userName, double cantidad) async {
    QuerySnapshot querySnapshot =
        await collectionUsuario.where('userName', isEqualTo: userName).get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot document = querySnapshot.docs.first;
      String documentoId = document.id;
      double saldoActual = document['saldoCuenta'];

      await collectionUsuario.doc(documentoId).update({
        'saldoCuenta': saldoActual + cantidad,
      });

      controlleruser.usuario!.saldoCuenta = controlleruser.usuario!.saldoCuenta + cantidad;
    }
  }

   static Future<void> descontarPago(String userName, double cantidad) async {
    QuerySnapshot querySnapshot =
        await collectionUsuario.where('userName', isEqualTo: userName).get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot document = querySnapshot.docs.first;
      String documentoId = document.id;
      double saldoActual = document['saldoCuenta'];

      await collectionUsuario.doc(documentoId).update({
        'saldoCuenta': saldoActual - cantidad,
      });

      controlleruser.usuario!.saldoCuenta = controlleruser.usuario!.saldoCuenta - cantidad;
    }
  }

  static Future<void> ActualizarSaldoReserva(
      String idNegocio, double saldo) async {
    QuerySnapshot querySnapshot =
        await collection.where('id', isEqualTo: idNegocio).get();

    if (querySnapshot.docs.isNotEmpty) {
      for (DocumentSnapshot document in querySnapshot.docs) {
        String documentoId = document.id;
        double saldoActual = document['saldo'];

        await collection.doc(documentoId).update({
          'saldo': saldoActual - saldo,
        });
      }
    }
  }
}
