import 'package:get/get.dart';
import 'package:telodigo/domain/models/usuario.dart';

class UserController extends GetxController {
  final Rx<dynamic> _code = "".obs;
  String get code => _code.value;

  final Rx<dynamic> _correo = "".obs;
  String get correo => _correo.value;

  final Rxn<Usuario> _usuario = Rxn<Usuario>();
  Usuario? get usuario => _usuario.value;

  Future<void> NewCode(String code) async {
    _code.value = code;
  }

  Future<void> NewCode1(String code, String correo) async {
    _code.value = code;
    _correo.value = correo;
  }

  Future<void> DatosUser(Usuario user) async {
    _usuario.value = user;
  }
}
