class Calificacion {
  final String idNegocio;
  final String idUserNegocio;
  final double calificacion;

  Calificacion({
    required this.idNegocio, required this.calificacion,  required this.idUserNegocio
  });

  Map<String, dynamic> toJson() => {
        "idNegocio": idNegocio,
        "calificacion": calificacion,
        "idUserNegocio": idUserNegocio
      };

  factory Calificacion.fromJson(Map<String, dynamic> json) {
    return Calificacion(
      idNegocio: json['idNegocio'],
      calificacion: json['calificacion'],
      idUserNegocio: json['idUserNegocio']
    );
  }
}
