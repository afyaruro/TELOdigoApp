class Habitaciones {
  final String nombre;
  final List<Precios> precios;
  late int cantidad;

  Habitaciones({
    required this.nombre,
    required this.precios,
    required this.cantidad,
  });

  Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "cantidad": cantidad,
        "precios": precios.map((precio) => precio.toJson()).toList(),
      };

  factory Habitaciones.fromMap(Map<String, dynamic> map) {
    return Habitaciones( 
      nombre: map['nombre'],
      cantidad: map['cantidad'],
      precios: (map['precios'] as List<dynamic>)
          .map((e) => Precios.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class Precios {
  double precio;
  int hora;

  Precios({
    required this.precio,
    required this.hora,
  });

  Map<String, dynamic> toJson() => {
        "precio": precio,
        "hora": hora,
      };

  factory Precios.fromJson(Map<String, dynamic> json) {
    return Precios(
      precio: json["precio"],
      hora: json["hora"],
    );
  }
}
