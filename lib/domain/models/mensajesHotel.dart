import 'package:cloud_firestore/cloud_firestore.dart';

class MensajesHotel {
  final int id;
  final String idPropietarioNegocio;
  final String idReserva;
  final String nombreCliente;
  late int position;
  final DateTime fecha;
  final String ultimoMensaje;
  final String nombreNegocio;
  final String noLeidos;

  MensajesHotel(
      {required this.id,
      required this.nombreCliente,
      required this.idPropietarioNegocio,
      required this.idReserva,
      this.position = 0,
      required this.ultimoMensaje,
      required this.nombreNegocio,
      required this.noLeidos,
      required this.fecha
      });

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombreCliente": nombreCliente,
        "idPropietarioNegocio": idPropietarioNegocio,
        "idReserva": idReserva,
        "position": position,
        "ultimoMensaje": ultimoMensaje,
        "nombreNegocio": nombreNegocio,
        "noLeidos": noLeidos,
        "fecha": fecha
      };

  factory MensajesHotel.fromJson(Map<String, dynamic> data) {
    DateTime fecha = (data["fecha"] as Timestamp).toDate();
    return MensajesHotel(
      fecha: fecha,
      id: data['id'],
      nombreCliente: data['nombreCliente'],
      idPropietarioNegocio: data['idPropietarioNegocio'],
      idReserva: data['idReserva'],
      position: data['position'],
      ultimoMensaje: data['ultimoMensaje'],
      nombreNegocio: data['nombreNegocio'],
      noLeidos: data['noLeidos'],
    );
  }
}
