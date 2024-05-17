import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:telodigo/domain/models/usuario.dart';

class MapController extends GetxController {
  final Rx<double> _latitud = 0.0.obs;
  double get latitud => _latitud.value;

  final Rx<double> _longitud = 0.0.obs;
  double get logitud => _longitud.value;


    Future<void> getCurrentLocation() async {
    final GeolocatorPlatform geolocator = GeolocatorPlatform.instance;

    _latitud.value = -12.04318;
    _longitud.value = -77.02824;
    
    try {
      Position position = await geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      print(position.longitude);
      print(position.latitude);

      _latitud.value = position.latitude;
      _longitud.value = position.longitude;
    } catch (e) {
      print("Error al obtener la ubicación: $e");
    }
  }
}
