import 'package:telodigo/domain/models/habitaciones.dart';
import 'package:telodigo/domain/models/images.dart';

class Hoteles {
  final String id;
  late String nombre;
  final String tipoEspacio;
  final List<Habitaciones> habitaciones;
  late String direccion;
  // final String horaAbrir;
  // final String horaCerrar;
  final String tipoHorario;
  final int horaAbrir;
  final int horaCerrar;
  final int minutoAbrir;
  final int minutoCerrar;

  final double longitud;
  final double latitud;
  final List<String> metodosPago;
  late List<String> servicios;
  final List<String> categorias;
  final List<Imagens> fotos;
  final String user;
  final double saldo;
  final double calificacion;
  final String estado;

  Hoteles({
    required this.tipoHorario,
    required this.minutoAbrir,
    required this.minutoCerrar,
    required this.estado,
    required this.categorias,
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

    final List<String> categorias = (data["categorias"] as List).cast<String>();

    final List<dynamic> fotosJson = (data["fotos"] as List).cast<dynamic>();
    final List<Imagens> fotos =
        fotosJson.map((json) => Imagens.fromJson(json)).toList();

    final String id = data["id"];

    return Hoteles(
      categorias: categorias,
      id: id,
      estado: data['estado'] ?? '',
      nombre: data['nombre'] ?? '',
      tipoEspacio: data['tipoEspacio'] ?? '',
      habitaciones: habitaciones,
      longitud: data['longitud'] ?? '',
      latitud: data['latitud'] ?? '',
      direccion: data['direccion'] ?? '',
      horaAbrir: data['horaAbrir'] ?? 0,
      horaCerrar: data['horaCerrar'] ?? 0,
      metodosPago: metodosPago,
      servicios: servicios,
      fotos: fotos,
      user: data['user'] ?? '',
      saldo: data['saldo'] ?? 0.0,
      calificacion: data['calificacion'] ?? '',
      tipoHorario: data['tipoHorario'] ?? '',
      minutoAbrir: data['minutoAbrir'] ?? 0,
      minutoCerrar: data['minutoCerrar'] ?? 0,
    );
  }
}
