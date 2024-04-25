import 'dart:async';

import 'package:get/get.dart';
import 'package:telodigo/domain/models/habitaciones.dart';
import 'package:telodigo/domain/models/images.dart';
// import 'package:telodigo/domain/models/hoteles.dart';

class NegocioController extends GetxController {
  // final Rxn<Hoteles> _hotel = Rxn<Hoteles>();
  // Hoteles? get hotel => _hotel.value;

  final Rx<dynamic> _tipoEspacio = "".obs;
  String get tipoEspacio => _tipoEspacio.value;

  final Rx<dynamic> _nombreNegocio = "".obs;
  String get nombreNegocio => _nombreNegocio.value;

  final Rx<dynamic> _horaAbrir = "".obs;
  String get horaAbrir => _horaAbrir.value;

  final Rx<dynamic> _horaCerrar = "".obs;
  String get horaCerrar => _horaCerrar.value;

  final Rxn<List<Habitaciones>> _habitaciones = Rxn<List<Habitaciones>>();
  List<Habitaciones>? get habitaciones => _habitaciones.value;

  final Rxn<List<String>> _metodosPago = Rxn<List<String>>();
  List<String>? get metodosPago => _metodosPago.value;

  final Rxn<List<Imagens>> _images = Rxn<List<Imagens>>();
  List<Imagens>? get images => _images.value;

   final Rxn<List<String>> _servicios = Rxn<List<String>>();
  List<String>? get servicios => _servicios.value;
  

  Future<void> IngresarTipoEspacio(String espacio) async {
    _tipoEspacio.value = espacio;
  }

  Future<void> informacionBasica(
      {required String nombreNegocio,
      required String horaAbrir,
      required String horaCerrar,
      required List<Habitaciones> habitaciones}) async {
    _nombreNegocio.value = nombreNegocio;
    _horaAbrir.value = horaAbrir;
    _horaCerrar.value = horaCerrar;
    _habitaciones.value = habitaciones;
  }

  Future<void> NewMetodoPago(List<String> metodos) async {
    _metodosPago.value = [];
    _metodosPago.value = metodos;
  }



  Future<void> NewImagen(List<Imagens> images) async {
    _images.value = [];
    _images.value = images;
  }

  Future<void> deleteImagen(Imagens image) async {
    _images.value!.remove(image);
  }

  Future<void> NewServicios(List<String> servicios) async {
    _servicios.value = [];
    _servicios.value = servicios;
  }
}
