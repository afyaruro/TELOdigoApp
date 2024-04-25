import 'package:flutter/material.dart';
import 'package:telodigo/data/service/peticionesdatosgenerales.dart';
import 'package:telodigo/ui/components/customcomponents/customalert.dart';

Future<bool> respuestaActualizarDatos(
    {required String nombres,
    required String apellidos,
    required String fechaNacimiento,
    required String foto,
    required String userName,
    required BuildContext context}) async {
      
  FocusScope.of(context).unfocus();
  nombres = nombres.trim();
  apellidos = apellidos.trim();

  final DateTime fechaNacimientoDateTime = DateTime.parse(fechaNacimiento);
  final DateTime fechaMayorEdad =
      DateTime.now().subtract(const Duration(days: 365 * 18));
  if (fechaNacimientoDateTime.isAfter(fechaMayorEdad)) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const CustomAlert(
          title: "Validación de Edad",
          text: "Debes ser mayor de edad",
        );
      },
    );
  } else {
    await PeticionesDatosPersonales.actualizarDatosPersonales(
        nombres, apellidos, fechaNacimiento, foto, userName, context);
    return true;
  }

  return false;
}
