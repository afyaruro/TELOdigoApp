
import 'package:flutter/material.dart';
import 'package:telodigo/ui/components/customcomponents/customalert.dart';
import 'package:telodigo/ui/components/customcomponents/custombackgroundlogin.dart';
import 'package:telodigo/ui/components/customcomponents/custombuttonborderradius.dart';
import 'package:telodigo/ui/components/customcomponents/customtextfield.dart';
import 'package:telodigo/ui/components/respuestas/respuesta_change_password.dart';
import 'package:telodigo/ui/pages/change_password/change_password2.dart';

class changePassword extends StatefulWidget {
  const changePassword({super.key});

  @override
  State<changePassword> createState() => _changePasswordState();
}

class _changePasswordState extends State<changePassword> {
  final TextEditingController controller_correo =
      TextEditingController(text: "");

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
                  height: MediaQuery.of(context).size.height * 0.15,
                ),
                CustomTextField1(
                    nombre: "Correo Electronico",
                    isPassword: false,
                    controller: controller_correo),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),

                CustomButtonsRadiusx(
                    Colors.white, Colors.black, "Enviar Codigo", 
                    () async {
                  if (controller_correo.text == "") {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return  CustomAlert(
                          title: "Valida tu Informacion",
                          text: "Ingresa un correo electronico",
                        );
                      },
                    );
                  } else {
                    respuestaSendCode(
                        destinatario: controller_correo.text, context: context);
                    Navigator.push(
                        context,
                         MaterialPageRoute(
                            builder: (context) => const changePassword2()));
                  }
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
