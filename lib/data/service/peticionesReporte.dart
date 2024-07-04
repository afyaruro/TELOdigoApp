import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:telodigo/data/controllers/usercontroller.dart';
import 'package:telodigo/domain/models/reporte.dart';
import 'package:telodigo/domain/models/reportePago.dart';
import 'package:telodigo/domain/models/reporteView.dart';

class PeticionesReporte {
  static final CollectionReference collection =
      FirebaseFirestore.instance.collection("Reportes");

  static final CollectionReference collectionView =
      FirebaseFirestore.instance.collection("ReportesView");

      static final CollectionReference collectionPago =
      FirebaseFirestore.instance.collection("ReportesPagos");

  static final UserController controlleruser = Get.find();

  static Future<void> addReporteNumeroReserva(String userAnfitrion) async {
    // Buscar el reporte del usuario anfitrión
    final querySnapshot = await collection
        .where('userAnfitrion', isEqualTo: userAnfitrion)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      // Si existe un reporte para el usuario anfitrión, actualiza el número de reservas
      final reporteDoc = querySnapshot.docs.first;
      final reporteData = reporteDoc.data() as Map<String, dynamic>;
      final int numeroReservas = reporteData['numeroReservas'] as int;

      await reporteDoc.reference.update({
        'numeroReservas': numeroReservas + 1,
      });
    } else {
      // Si no existe un reporte para el usuario anfitrión, crea uno nuevo
      final nuevoReporte = Reporte(
        numeroReservas: 1,
        userAnfitrion: userAnfitrion,
      );

      await collection.add(nuevoReporte.toJson());
    }
  }

  static Future<void> reporteViewAdd(String userAnfitrion) async {
    // Si no existe un reporte para el usuario anfitrión, crea uno nuevo
    final nuevoReporte = ReporteView(
      userAnfitrion: userAnfitrion,
      fecha: DateTime.now(),
    );

    await collectionView.add(nuevoReporte.toJson());

  }

    static Future<void> reportePagoAdd(String userAnfitrion, double valor) async {
    final nuevoReporte = ReportePago(
      valor: valor,
      userAnfitrion: userAnfitrion,
      fecha: DateTime.now(),
    );

    await collectionPago.add(nuevoReporte.toJson());

  }
}
