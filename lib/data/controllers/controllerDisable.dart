import 'package:get/get.dart';

class DisableController extends GetxController {
  // Variables reactivas
  final Rx<String> _correo = "".obs;
  final Rx<String> _usuario = "".obs;
  final Rx<String> _password = "".obs;
  final Rx<String> _passwordConfirma = "".obs;

  // Getters para acceder a los valores
  String get correo => _correo.value;
  String get usuario => _usuario.value;
  String get password => _password.value;
  String get passwordConfirma => _passwordConfirma.value;

  // Setters para actualizar los valores
  void setCorreo(String value) => _correo.value = value;
  void setUsuario(String value) => _usuario.value = value;
  void setPassword(String value) => _password.value = value;
  void setPasswordConfirma(String value) => _passwordConfirma.value = value;
}
