import 'package:cloud_firestore/cloud_firestore.dart';

class Informe{
  final DateTime fecha;
  final String correo;
  final String mensaje;

  Informe({
    required this.fecha,
    required this.mensaje,
    required this.correo
  });

  Map<String, dynamic> toJson() => {
        "fecha": fecha,
        "mensaje": mensaje,
        "correo": correo
      };

  factory Informe.fromJson(Map<String, dynamic> json) {
     DateTime fecha = (json['fecha'] as Timestamp).toDate();
    return Informe(
      fecha: fecha,
      correo: json['correo'],
      mensaje: json['mensaje']
    );
  }
}
