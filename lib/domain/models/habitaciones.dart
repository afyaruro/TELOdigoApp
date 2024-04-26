class Habitaciones {
  final String nombre;
  List<Precios> precios = [];
  int cantidad = 0;

  Habitaciones({
    required this.nombre,
  });

    Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "cantidad": cantidad,
        "precios": precios.map((precio) => precio.toJson()).toList(),
      };
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
}

