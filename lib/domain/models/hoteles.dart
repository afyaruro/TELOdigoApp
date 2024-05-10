import 'package:telodigo/domain/models/habitaciones.dart';
import 'package:telodigo/domain/models/images.dart';

class Hoteles {
  final int id;
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
  final double saldo;
  final double calificacion;

  Hoteles({
    required this.id,
    required this.calificacion,
    required this.saldo,
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
    required this.horaAbrir,
    required this.horaCerrar,
  });

  factory Hoteles.desdeDoc(Map<String, dynamic> data) {
    final List<dynamic> habitacionesJson =
        (data["habitaciones"] as List).cast<dynamic>();
    final List<Habitaciones> habitaciones =
        habitacionesJson.map((json) => Habitaciones.fromMap(json)).toList();

    final List<String> servicios = (data["servicios"] as List).cast<String>();

    final List<String> metodosPago =
        (data["metodosPago"] as List).cast<String>();

    final List<dynamic> fotosJson = (data["fotos"] as List).cast<dynamic>();
    final List<Imagens> fotos =
        fotosJson.map((json) => Imagens.fromJson(json)).toList();

    final int id = data["id"];

    return Hoteles(
      id: id,
      nombre: data['nombre'] ?? '',
      tipoEspacio: data['tipoEspacio'] ?? '',
      habitaciones: habitaciones,
      longitud: data['longitud'] ?? '',
      latitud: data['latitud'] ?? '',
      direccion: data['direccion'] ?? '',
      horaAbrir: data['horaAbrir'] ?? '',
      horaCerrar: data['horaCerrar'] ?? '',
      metodosPago: metodosPago,
      servicios: servicios,
      fotos: fotos,
      user: data['user'] ?? '',
      saldo: data['saldo'] ?? '',
      calificacion: data['calificacion'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "tipoEspacio": tipoEspacio,
        "habitaciones": habitaciones
      };
}
