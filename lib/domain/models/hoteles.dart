import 'package:telodigo/domain/models/habitaciones.dart';

class Hoteles {

  final String nombre;
  final String tipoEspacio;
  final List<Habitaciones> habitaciones;
  final String direccion;
  final String horaAbrir;
  final String horaCerrar;
  final String longitud;
  final String latitud;

  Hoteles({
    required this.direccion,
    required this.nombre,
    required this.tipoEspacio,
    required this.habitaciones,
    required this.latitud,
    required this.longitud,
    required this.horaAbrir, required this.horaCerrar, 
  });

  factory Hoteles.desdeDoc(Map<String, dynamic> data) {
    return Hoteles(
      nombre: data['nombre'] ?? '',
      tipoEspacio: data['tipoEspacio'] ?? '',
      habitaciones: data['habitaciones'] ?? '',
      longitud: data['longitud'] ?? '',
      latitud: data['latitud'] ?? '',
      direccion: data['direccion'] ?? '',
      horaAbrir: data['horaAbrir'] ?? '',
      horaCerrar: data['horaCerrar'] ?? '',

    );
  }

  Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "tipoEspacio": tipoEspacio,
        "habitaciones": habitaciones
      };
}
