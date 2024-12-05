import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telodigo/data/controllers/controllerDisable.dart';
import 'package:telodigo/data/service/peticionesInicioSesion.dart';
import 'package:telodigo/data/service/peticionnegocio.dart';
import 'package:telodigo/ui/components/customcomponents/customalert.dart';
import 'package:telodigo/ui/components/customcomponents/custombackgroundlogin.dart';
import 'package:telodigo/ui/components/customcomponents/customoption.dart';
import 'package:telodigo/ui/components/customcomponents/customtextfield.dart';
import 'package:telodigo/ui/components/respuestas/respuesta_sign_in.dart';
import 'package:telodigo/ui/pages/administrador/homeAdmin.dart';
import 'package:telodigo/ui/pages/change_password/change_password.dart';

class sign_in extends StatefulWidget {
  final DisableController disableController;

  const sign_in({super.key, required this.disableController});

  @override
  State<sign_in> createState() => _sign_inState();
}

class _sign_inState extends State<sign_in> {
  final TextEditingController controller_userName =
      TextEditingController(text: "");
  final TextEditingController controller_password =
      TextEditingController(text: "");
  static final DisableController disableController = Get.find();

  @override
  void initState() {
    super.initState();
    disableController.setCorreo("");
    disableController.setPassword("");
    disableController.setPasswordConfirma("");
    disableController.setUsuario("");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        body: CustomBackgroundLogin(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Container(
                  padding: const EdgeInsets.only(
                      left: 50, right: 50, top: 50, bottom: 50),
                  child: const Image(
                    image: AssetImage('assets/logo.png'),
                    height: 100,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0,
                ),
                CustomOption(true, context, controllerDisable: widget.disableController),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                CustomTextFieldSingUp(
                    disableController: disableController,
                    nombre: "Usuario",
                    isPassword: false,
                    controller: controller_userName),
                CustomTextFieldSingUp(
                    disableController: disableController,
                    nombre: "Contraseña",
                    isPassword: true,
                    controller: controller_password),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 50),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      splashColor: Color.fromARGB(123, 206, 206, 206),
                      onTap: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const changePassword()));
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "¿Olvidaste tu contraseña?",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                Obx(
                  () => ElevatedButton(
                    onPressed: disableController.password.isNotEmpty &&
                            disableController.usuario.isNotEmpty
                        ? () async {
                            if (controller_userName.text == "Admin" &&
                                controller_password.text.isNotEmpty) {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return const AlertDialog(
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        CircularProgressIndicator(),
                                        SizedBox(height: 10),
                                        Text("Iniciando Sesion..."),
                                      ],
                                    ),
                                  );
                                },
                              );

                              var resp = await PeticionesInicioSesion.Login(
                                  controller_userName.text,
                                  controller_password.text,
                                  context);

                              if (resp == "Password-Correct") {
                                Navigator.pop(context);
                                // print("Hola, haz ingresado correctamente");
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const HomeAdmin()),
                                  (Route<dynamic> route) => false,
                                );
                              } else if (resp == "Password-Incorrect") {
                                Navigator.pop(context);
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return const CustomAlert(
                                      title: "Valida tu Informacion",
                                      text:
                                          "La contraseña indicada es incorrecta",
                                    );
                                  },
                                );
                              } else if (resp == "no-exist") {
                                Navigator.pop(context);
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return const CustomAlert(
                                      title: "Valida tu Informacion",
                                      text:
                                          "El usuario no se encuentra registrado en el sistema",
                                    );
                                  },
                                );
                              } else if (resp == "timeout") {
                              } else {
                                Navigator.pop(context);
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return const CustomAlert(
                                      title: "Error Desconocido",
                                      text:
                                          "Estamos teniendo errores por favor intenta mas tarde",
                                    );
                                  },
                                );
                              }
                            } else {
                              var resp = await login(
                                  user: controller_userName.text,
                                  password: controller_password.text,
                                  context: context);

                              PeticionesNegocio.listNegocios();
                              if (resp == true || resp == false) {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                              }
                            }
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                      foregroundColor: const Color.fromARGB(
                          255, 115, 8, 134), // Personaliza el color del texto.
                      disabledBackgroundColor: const Color.fromARGB(
                          106, 235, 230, 230), // Color del botón deshabilitado.
                      disabledForegroundColor: const Color.fromARGB(
                          162, 255, 255, 255), // Color del texto deshabilitado.
                    ),
                    child: const Text("¡COMENZAR!"),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ));
  }
}
