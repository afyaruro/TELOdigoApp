import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:telodigo/ui/components/customcomponents/custombackgroundlogin.dart';
import 'package:telodigo/ui/components/customcomponents/custombuttonborderradius.dart';
import 'package:telodigo/ui/components/customcomponents/customdatepicker.dart';
import 'package:telodigo/ui/components/customcomponents/customoption.dart';
import 'package:telodigo/ui/components/customcomponents/customtextfield.dart';
import 'package:telodigo/ui/components/respuestas/respuesta_sign_up.dart';
import 'package:telodigo/ui/pages/sign_up/createCuenta.dart';
import 'package:telodigo/ui/pages/terminos&condiciones/terminos&condiciones.dart';

class sign_up extends StatefulWidget {
  const sign_up({super.key});

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
  final TextEditingController controller_fecha =
      TextEditingController(text: "Fecha de Nacimiento");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            CustomOption(false, context),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            CustomTextField1(
                nombre: "Correo Electrónico",
                isPassword: false,
                controller: controller_correo),
            CustomDatePicker(controller: controller_fecha),
            CustomTextField1(
                nombre: "Usuario",
                isPassword: false,
                controller: controller_userName),
            CustomTextField1(
                nombre: "Contraseña",
                isPassword: true,
                controller: controller_password),
            Container(
              width: 400,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
                    hoverColor: Color.fromARGB(255, 156, 110, 187),
                  ),
                  const Text(
                    "Acepto los ",
                    style: TextStyle(color: Colors.white),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      splashColor: Color.fromARGB(123, 206, 206, 206),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: const Text(
                          "terminos y condiciones",
                          style: TextStyle(
                              color: Color.fromARGB(255, 156, 110, 187)),
                        ),
                      ),
                      onTap: () async {
                        await Future.delayed(Duration(milliseconds: 600), () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) =>
                                      const terminos_condiciones()));
                        });
                      },
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            CustomButtonsRadius(
              const Color(0xffffffff),
              const Color(0xff3B2151),
              "¡REGISTRARME!",
              false,
              () async {
                bool resp = await newUser(
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
                    isChecked = false;
                  });

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CreateCuenta()),
                    (Route<dynamic> route) => false,
                  );
                }
              },
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
