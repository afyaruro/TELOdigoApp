import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:telodigo/domain/models/favoritos.dart';
import 'package:telodigo/domain/models/habitaciones.dart';
import 'package:telodigo/domain/models/hoteles.dart';
import 'package:telodigo/domain/models/images.dart';
// import 'package:telodigo/domain/models/hoteles.dart';

class NegocioController extends GetxController {
  // final Rxn<Hoteles> _hotel = Rxn<Hoteles>();
  // Hoteles? get hotel => _hotel.value;

  final Rx<dynamic> _tipoEspacio = "".obs;
  String get tipoEspacio => _tipoEspacio.value;

  final Rx<dynamic> _nombreNegocio = "".obs;
  String get nombreNegocio => _nombreNegocio.value;

  final Rx<dynamic> _horaAbrir = 0.obs;
  int get horaAbrir => _horaAbrir.value;

  final Rx<dynamic> _horaCerrar = 0.obs;
  int get horaCerrar => _horaCerrar.value;

  final Rx<dynamic> _minutoAbrir = 0.obs;
  int get minutoAbrir => _minutoAbrir.value;

  final Rx<dynamic> _minutoCerrar = 0.obs;
  int get minutoCerrar => _minutoCerrar.value;

  final Rx<dynamic> _tipoHorario = "".obs;
  String get tipoHorario => _tipoHorario.value;

  final Rx<dynamic> _direccion = "".obs;
  String get direccion => _direccion.value;

  final Rx<double> _latitud = 0.0.obs;
  double get latitud => _latitud.value;

  final Rx<double> _longitud = 0.0.obs;
  double get longitud => _longitud.value;

  final Rxn<List<Habitaciones>> _habitaciones = Rxn<List<Habitaciones>>();
  List<Habitaciones>? get habitaciones => _habitaciones.value;

  final Rxn<List<File>> _fotosFile = Rxn<List<File>>();
  List<File>? get fotosFile => _fotosFile.value;

  final Rxn<List<String>> _metodosPago = Rxn<List<String>>();
  List<String>? get metodosPago => _metodosPago.value;

  final Rxn<List<Imagens>> _images = Rxn<List<Imagens>>([]);
  List<Imagens>? get images => _images.value;

  final Rxn<List<String>> _servicios = Rxn<List<String>>();
  List<String>? get servicios => _servicios.value;

  final Rxn<List<Hoteles>> _hoteles = Rxn<List<Hoteles>>([]);
  List<Hoteles>? get hoteles => _hoteles.value;

  final Rxn<List<Hoteles>> _hoteles2 = Rxn<List<Hoteles>>([]);
  List<Hoteles>? get hoteles2 => _hoteles2.value;

  final Rxn<List<Favorito>> _favoritos = Rxn<List<Favorito>>([]);
  List<Favorito>? get favoritos => _favoritos.value;

  final Rxn<List<Hoteles>> _hotelesfavoritos = Rxn<List<Hoteles>>([]);
  List<Hoteles>? get hotelesfavoritos => _hotelesfavoritos.value;

  final Rxn<List<String>> _categorias = Rxn<List<String>>();
  List<String>? get categorias => _categorias.value;

  Future<void> IngresarTipoEspacio(String espacio) async {
    _tipoEspacio.value = espacio;
  }

  Future<void> ListCategorias(List<String> categorias) async {
    _categorias.value = [];
    _categorias.value = categorias;
  }

  Future<void> informacionBasica(
      {required String nombreNegocio,
      required int horaAbrir,
      required int horaCerrar,
      required int minutoAbrir,
      required int minutoCerrar,
      required String tipoHorario,
      required List<Habitaciones> habitaciones}) async {
    _nombreNegocio.value = nombreNegocio;

    _horaAbrir.value = horaAbrir;
    _horaCerrar.value = horaCerrar;
    _minutoAbrir.value = minutoAbrir;
    _minutoCerrar.value = minutoCerrar;
    _tipoHorario.value = tipoHorario;

    _habitaciones.value = habitaciones;
  }

  Future<void> NewMetodoPago(List<String> metodos) async {
    _metodosPago.value = [];
    _metodosPago.value = metodos;
  }

  Future<void> RestartImagenes() async {
    _images.value = [];
  }

  Future<void> NewImagenF(List<File> images) async {
    _fotosFile.value = [];
    _fotosFile.value = images;
  }

  Future<void> deleteImagen(Imagens image) async {
    _images.value!.remove(image);
  }

  Future<void> addImagen(Imagens image) async {
    _images.value!.add(image);
  }

  Future<void> deleteImagenF(File image) async {
    _fotosFile.value!.remove(image);
  }

  Future<void> NewServicios(List<String> servicios) async {
    _servicios.value = [];
    _servicios.value = servicios;
  }

  Future<void> AddHotel(Hoteles hotel) async {
    _hoteles.value!.add(hotel);
  }

  Future<void> removeFavorito(Favorito favorito) async {
    _favoritos.value!.remove(favorito);
  }

  Future<void> ListHotel(List<Hoteles> hoteles) async {
    _hoteles.value = [];
    _hoteles.value = hoteles;
  }

  Future<void> AddFavorito(Favorito favorito) async {
    _favoritos.value!.add(favorito);
  }

  Future<void> ListFavoritos(List<Favorito> favoritos) async {
    _favoritos.value = [];
    _favoritos.value = favoritos;
  }

  Future<void> ListHotel2(List<Hoteles> hoteles) async {
    _hoteles2.value = [];
    _hoteles2.value = hoteles;
  }

  Future<void> NewDireccion(String direccion) async {
    _direccion.value = direccion;
  }

  Future<void> EstablecerCoodenadas(double latitud, double longitud) async {
    _latitud.value = latitud;
    _longitud.value = longitud;
  }

  Future<void> ListHabitaciones(List<Habitaciones> habitaciones) async {
    _habitaciones.value = habitaciones;
  }

  Future<void> HotelesFavorito(List<Hoteles> hoteles) async {
    _hotelesfavoritos.value = [];
    _hotelesfavoritos.value = hoteles;
  }
}
