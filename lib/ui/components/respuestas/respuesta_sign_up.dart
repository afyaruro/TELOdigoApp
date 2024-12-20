import 'package:flutter/material.dart';
import 'package:telodigo/config/imgbase64/perfil.dart';
import 'package:telodigo/data/service/peticionesusuario.dart';
import 'package:telodigo/ui/components/customcomponents/customalert.dart';

Future<bool> newUser(
    {required String userName,
    required String password,
    required String correo,
    required String fechaNacimiento,
    required BuildContext context,
    required String corfirmPass,
    required bool isChecked}) async {
  RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  correo = correo.trim();
  userName = userName.trim();
  password = password.trim();
  corfirmPass = corfirmPass.trim();

  FocusScope.of(context).unfocus();

  if (userName.isEmpty ||
      password.isEmpty ||
      correo.isEmpty ||
      fechaNacimiento.isEmpty ||
      !isChecked) {
    CamposVacios(
        context: context,
        correo: correo,
        fechaNacimiento: fechaNacimiento,
        isChecked: isChecked,
        password: password,
        userName: userName);
  } else {
    // Validar que el usuario sea mayor de edad
    final DateTime fechaNacimientoDateTime = DateTime.parse(fechaNacimiento);
    final DateTime fechaMayorEdad =
        DateTime.now().subtract(const Duration(days: 365 * 18));
    if (fechaNacimientoDateTime.isAfter(fechaMayorEdad)) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const CustomAlert(
            title: "Validación de Edad",
            text: "Debes ser mayor de edad para registrarte",
          );
        },
      );
    } else if (!emailRegex.hasMatch(correo)) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const CustomAlert(
            title: "Validación de Correo",
            text: "Por favor digite un correo electrónico válido",
          );
        },
      );
    } else if (!isPasswordSecure(password)) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              "Contraseña Insegura",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            content: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Por favor, verifica que contenga al menos:"),
                SizedBox(
                  height: 10,
                ),
                Text("• un número"),
                Text("• una letra minúscula"),
                Text("• una letra mayúscula"),
                Text("• al menos 7 caracteres")
              ],
            ),
            actions: [
              TextButton(
                child: Text('Aceptar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else if (password != corfirmPass) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const CustomAlert(
            title: "Validación tu contraseña",
            text: "Las contraseñas no coinciden",
          );
        },
      );
    } else {
      var usuario = <String, dynamic>{
        "userName": userName,
        "password": password,
        "nombres": "",
        "apellidos": "",
        "correo": correo,
        "fechaNacimiento": fechaNacimiento,
        "foto": ImagenPerfilDefault.img,
        "modoOscuro": false,
        "saldoCuenta": 0.0
      };

      var respuesta = await PeticionesUsuario.crearUsuario(
          usuario, userName, context, correo);
      if (respuesta == "create") {
        Navigator.pop(context);

        return true;
      } else if (respuesta == "correo-invalido") {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const CustomAlert(
              title: "Correo No Valido",
              text: "El correo que deseas usar ya se encuentra en uso",
            );
          },
        );
      } else if (respuesta == "timeout") {}
    }
  }

  return false;
}

bool isPasswordSecure(String password) {
  // Verificar si la contraseña tiene al menos 7 caracteres
  if (password.length < 7) {
    return false;
  }

  // Verificar si la contraseña contiene al menos un número
  if (!password.contains(RegExp(r'\d'))) {
    return false;
  }

  // Verificar si la contraseña contiene al menos una letra mayúscula
  if (!password.contains(RegExp(r'[A-Z]'))) {
    return false;
  }

  // Verificar si la contraseña contiene al menos una letra minúscula
  if (!password.contains(RegExp(r'[a-z]'))) {
    return false;
  }

  // La contraseña es segura
  return true;
}

bool contienePuntosComas(String valor) {
  return valor.contains('.') || valor.contains(',');
}

void CamposVacios(
    {required String userName,
    required String password,
    required String correo,
    required String fechaNacimiento,
    required BuildContext context,
    required bool isChecked}) {
  if (correo.trim().isEmpty) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const CustomAlert(
          title: "Validación de Campos",
          text: "Por favor digite su correo electronico",
        );
      },
    );
    return;
  }

  if (correo.contains(',')) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const CustomAlert(
          title: "Validación de Campos",
          text: "El correo electronico no puede contener comas",
        );
      },
    );
    return;
  }

  if (correo.contains(' ')) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const CustomAlert(
          title: "Validación de Campos",
          text: "El correo electronico no puede contener espacios",
        );
      },
    );
    return;
  }

  if (fechaNacimiento == "Fecha de Nacimiento") {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const CustomAlert(
          title: "Validación de Campos",
          text: "Por favor seleccione la fecha de nacimiento",
        );
      },
    );
    return;
  }

  if (userName.isEmpty) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const CustomAlert(
          title: "Validación de Campos",
          text: "Por favor verifique el usuario",
        );
      },
    );
    return;
  }

  if (contienePuntosComas(userName) || userName.contains(' ')) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const CustomAlert(
          title: "Validación de Campos",
          text: "El nombre de usuario no puede contener puntos, ni comas, ni espacios",
        );
      },
    );
    return;
  }
  if (password.isEmpty) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const CustomAlert(
          title: "Validación de Campos",
          text: "Por favor verifique la contraseña",
        );
      },
    );
    return;
  }
  if (isChecked == false) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const CustomAlert(
          title: "Terminos y Condiciones",
          text: "Por favor acepta los terminos y condiciones",
        );
      },
    );
    return;
  }
}
