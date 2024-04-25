class Habitaciones {
  final String nombre;
  List<Precios> precios = [];
  int cantidad = 0;

  Habitaciones({
    required this.nombre,
  });
}

// class Precios {
//   final double precio = 0;
//   final int tiempo = 0;

//   Precios({
//     required double precio,
//     required int tiempo,
//   });
// }

class Precios {
  double precio;
  int hora;

  Precios({
    required this.precio,
    required this.hora,
  });
}

