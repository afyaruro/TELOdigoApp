import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telodigo/data/controllers/usercontroller.dart';
import 'package:telodigo/ui/components/customcomponents/custombackgroundlogin.dart';
import 'package:telodigo/ui/components/customcomponents/custombuttonborderradius.dart';
import 'package:telodigo/ui/components/customcomponents/customtextfield.dart';
import 'package:telodigo/ui/components/respuestas/respuesta_change_password.dart';

class changePassword2 extends StatefulWidget {
  const changePassword2({super.key});

  @override
  State<changePassword2> createState() => _changePassword2State();
}

class _changePassword2State extends State<changePassword2> {
  final TextEditingController controller_codigo =
      TextEditingController(text: "");
  final TextEditingController controller_pass = TextEditingController(text: "");
  final TextEditingController controller_confpass =
      TextEditingController(text: "");

  UserController controllerPass = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),

        appBar: AppBar(
          backgroundColor: Color(0xff3B2151),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: CustomBackgroundLogin(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      left: 50, right: 50, top: 20, bottom: 20),
                  child: const Image(
                    image: AssetImage('assets/logo.png'),
                    height: 100,
                  ),
                ),
                Text(
                  "Cambiar contraseña",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                CustomTextField1(
                    nombre: "Codigo de Verificación",
                    isPassword: false,
                    controller: controller_codigo),
                CustomTextField1(
                    nombre: "Nueva Contraseña",
                    isPassword: true,
                    controller: controller_pass),
                CustomTextField1(
                    nombre: "Confirmar Contraseña",
                    isPassword: true,
                    controller: controller_confpass),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                CustomButtonsRadiusx(const Color(0xffffffff),
                    const Color(0xff3B2151), "¡CONFIRMAR!",  () async {
                  await respuestaChangePassword(
                      codigo: controller_codigo.text,
                      pass: controller_pass.text,
                      confpass: controller_confpass.text,
                      context: context,
                      correo: controllerPass.correo);

                  FocusScope.of(context).requestFocus(FocusNode());
                }),
                const SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
        ));
  }
}
