import 'package:telodigo/domain/models/habitaciones.dart';
import 'package:telodigo/domain/models/images.dart';

class Hoteles {

  final String nombre;
  final String tipoEspacio;
  final List<Habitaciones> habitaciones;
  final String direccion;
  final String horaAbrir;
  final String horaCerrar;
  final double longitud;
  final double latitud;
  final List<String> metodosPago;
  final List<String> servicios;
  final List<Imagens> fotos;
  final String user;

  Hoteles( {
    required this.user,
    required this.fotos,
    required this.servicios,
    required this.metodosPago,
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
      metodosPago: data['metodosPago'] ?? '',
      servicios: data['servicios'] ?? '',
      fotos: data['fotos'] ?? '',
      user: data['user'] ?? '',

    );
  }

  Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "tipoEspacio": tipoEspacio,
        "habitaciones": habitaciones
      };
}
