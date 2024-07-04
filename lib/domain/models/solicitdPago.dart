import 'package:cloud_firestore/cloud_firestore.dart';

class SolicitudPago {
  final DateTime fecha;
  final String userAnfitrion;
  final double monto;
  final String numeroCuenta;
  final String nombreTitular;
  final String banco;
  final String celularContacto;
  final String estado;
  final String concepto;
  final String motivo;
  final String id;

  SolicitudPago({
    required this.fecha,
    required this.userAnfitrion,
    required this.banco,
    required this.celularContacto,
    required this.nombreTitular,
    required this.monto,
    required this.numeroCuenta,
    required this.concepto,
    required this.motivo,
    required this.estado,
    required this.id,
  });

  Map<String, dynamic> toJson() => {
        "fecha": fecha,
        "userAnfitrion": userAnfitrion,
        "numeroCuenta": numeroCuenta,
        "celularContacto": celularContacto,
        "nombreTitular": nombreTitular,
        "monto": monto,
        "banco": banco,
        "motivo": motivo,
        "estado": estado,
        "concepto": concepto,
        "id": id,
      };

  factory SolicitudPago.fromJson(Map<String, dynamic> json) {
    DateTime fecha = (json['fecha'] as Timestamp).toDate();
    return SolicitudPago(
        fecha: fecha,
        userAnfitrion: json['userAnfitrion'],
        banco: json['banco'],
        celularContacto: json['celularContacto'],
        monto: json['monto'],
        nombreTitular: json['nombreTitular'],
        numeroCuenta: json['numeroCuenta'],
        motivo: json['motivo'],
        estado: json['estado'],
        concepto: json['concepto'],
        id: json['id']);
  }
}
