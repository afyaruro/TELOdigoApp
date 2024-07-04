import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:telodigo/data/service/peticionesPagoMP.dart';
import 'package:telodigo/data/service/peticionesPagos.dart';
import 'package:telodigo/domain/models/solicitdPago.dart';
import 'package:telodigo/ui/pages/pagos/gestionarPagos.dart';

class PeticionesSolicitudPago {
  static final CollectionReference collection =
      FirebaseFirestore.instance.collection("Pagos");

  static Future<void> nuevaSolicitudPago(
      SolicitudPago solicitud, BuildContext context) async {
    await collection.add(solicitud.toJson());
    await PeticionesPagos.descontarPago(
        solicitud.userAnfitrion, solicitud.monto);

    mostrarAlertaExito(
        funcion: () {
          Navigator.of(context).pop();
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const SolicitarPagos()),
            (Route<dynamic> route) => false,
          );
        },
        color: Color.fromARGB(255, 4, 167, 39),
        icon: Icons.check_box_rounded,
        context: context,
        title: "Solicitud Exitosa",
        mensaje:
            "La solicitud de su pago ha sido exitosa recuerda que el plazo para hacer efectivo el pago es maximo de 72 horas",
        monto: double.parse(solicitud.monto.toString()));
  }
}
