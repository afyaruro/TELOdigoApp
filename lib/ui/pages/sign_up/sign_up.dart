import 'package:flutter/material.dart';
import 'package:telodigo/data/controllers/controllerDisable.dart';
import 'package:telodigo/ui/components/customcomponents/custombackgroundlogin.dart';
import 'package:telodigo/ui/components/customcomponents/customdatepicker.dart';
import 'package:telodigo/ui/components/customcomponents/customoption.dart';
import 'package:telodigo/ui/components/customcomponents/customtextfield.dart';
import 'package:telodigo/ui/components/respuestas/respuesta_sign_up.dart';
import 'package:telodigo/ui/pages/sign_up/createCuenta.dart';
import 'package:telodigo/ui/pages/terminos&condiciones/terminos&condiciones.dart';

class sign_up extends StatefulWidget {
  final DisableController disableController;
  const sign_up({super.key, required this.disableController});

  @override
  State<sign_up> createState() => _sign_upState();
}

class _sign_upState extends State<sign_up> {
  bool isChecked = false;
  final TextEditingController controller_userName =
      TextEditingController(text: "");
  final TextEditingController controller_correo =
      TextEditingController(text: "");
  final TextEditingController controller_password =
      TextEditingController(text: "");

  final TextEditingController controller_passwordConfirmar =
      TextEditingController(text: "");

  final TextEditingController controller_fecha =
      TextEditingController(text: "Fecha de Nacimiento");

  // static final DisableController disableController = Get.find();

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.disableController.setCorreo("");
      widget.disableController.setPassword("");
      widget.disableController.setPasswordConfirma("");
      widget.disableController.setUsuario("");
    // });
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
                CustomOption(false, context, controllerDisable: widget.disableController),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                CustomTextFieldSingUp(
                    disableController: widget.disableController,
                    nombre: "Correo Electrónico",
                    isPassword: false,
                    controller: controller_correo),
                CustomDatePicker(controller: controller_fecha),
                CustomTextFieldSingUp(
                    disableController: widget.disableController,
                    nombre: "Usuario",
                    isPassword: false,
                    controller: controller_userName),
                CustomTextFieldSingUp(
                    disableController: widget.disableController,
                    nombre: "Contraseña",
                    isPassword: true,
                    controller: controller_password),
                CustomTextFieldSingUp(
                    disableController: widget.disableController,
                    nombre: "Verificar Contraseña",
                    isPassword: true,
                    controller: controller_passwordConfirmar),
                Container(
                  width: 400,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Row(
                    children: [
                      Checkbox(
                        value: isChecked,
                        onChanged: (newbool) {
                          setState(() {
                            isChecked = newbool!;
                          });
                        },
                        activeColor: const Color.fromARGB(255, 190, 160, 209),
                        checkColor: Colors.white,
                        hoverColor: const Color.fromARGB(255, 156, 110, 187),
                      ),
                      const Text(
                        "Acepto los ",
                        style: TextStyle(color: Colors.white),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          splashColor: Color.fromARGB(123, 206, 206, 206),
                          child: const Padding(
                            padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                            child: Text(
                              "términos y condiciones",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 156, 110, 187)),
                            ),
                          ),
                          onTap: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const terminos_condiciones()));
                          },
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                ElevatedButton(
                  onPressed: controller_correo.text.isNotEmpty &&
                          controller_fecha.text != "Fecha de Nacimiento" &&
                          controller_password.text.isNotEmpty &&
                          controller_userName.text.isNotEmpty &&
                          controller_passwordConfirmar.text.isNotEmpty &&
                          isChecked
                      ? () async {
                          bool resp = await newUser(
                              corfirmPass: controller_passwordConfirmar.text,
                              userName: controller_userName.text,
                              password: controller_password.text,
                              correo: controller_correo.text,
                              context: context,
                              isChecked: isChecked,
                              fechaNacimiento: controller_fecha.text);

                          if (resp == true || resp == false) {
                            FocusScope.of(context).requestFocus(FocusNode());
                          }

                          if (resp) {
                            setState(() {
                              controller_fecha.text = "Fecha de Nacimiento";
                              controller_userName.text = "";
                              controller_password.text = "";
                              controller_correo.text = "";
                              controller_passwordConfirmar.text = "";

                              isChecked = false;
                            });

                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const CreateCuenta()),
                              (Route<dynamic> route) => false,
                            );
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
                  child: const Text("¡REGISTRARME!"),
                ),
                const SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
        ));
  }
}
