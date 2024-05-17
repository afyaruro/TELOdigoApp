import 'package:telodigo/domain/models/mensaje.dart';

class ChatMensajes {
  final int id;
  final List<Mensaje> mensajes;
  

  ChatMensajes(
      {required this.id,
      required this.mensajes,
      });

  Map<String, dynamic> toJson() => {
        "id": id,
        "mensajes": mensajes,
      };

  factory ChatMensajes.fromJson(Map<String, dynamic> data) {
    final List<dynamic> mensajesJson =
        (data["mensajes"] as List).cast<dynamic>();
    final List<Mensaje> mensajes =
        mensajesJson.map((json) => Mensaje.fromJson(json)).toList();
    return ChatMensajes(
        id: data['id'],
        mensajes: mensajes,);
  }
}
