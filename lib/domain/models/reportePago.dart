import 'package:cloud_firestore/cloud_firestore.dart';

class ReportePago {
  final DateTime fecha;
  final String userAnfitrion;
  final double valor;

  ReportePago({
    required this.fecha,
    required this.userAnfitrion,
    required this.valor,
  });

  Map<String, dynamic> toJson() => {
        "fecha": fecha,
        "userAnfitrion": userAnfitrion,
        "valor": valor,
      };

  factory ReportePago.fromJson(Map<String, dynamic> json) {
    DateTime fecha = (json['fecha'] as Timestamp).toDate();
    return ReportePago(
      fecha: fecha,
      userAnfitrion: json['userAnfitrion'],
      valor: json['valor']
    );
  }
}
