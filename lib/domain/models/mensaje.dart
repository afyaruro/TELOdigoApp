class Mensaje {
  final String id;
  final String type;
  final String mensaje;
  final String estado;
  late int position;
  

Mensaje({required this.id, required this.type, this.mensaje = "", this.estado = "Enviado",this.position = 0, 
    
  });

  Map<String, dynamic> toJson() => {
        "estado" : estado,
        "id": id,
        "type": type,
        "mensaje": mensaje,
        "position": position
      };

  factory Mensaje.fromJson(Map<String, dynamic> json) {
    return Mensaje(
      position: json['position'],
      id: json['id'],
      estado: json['estado'],
      type: json['type'],
      mensaje: json['mensaje']
    );
  }
}
