import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:telodigo/ui/components/customcomponents/custombackgroundlogin.dart';
import 'package:telodigo/ui/components/customcomponents/custombuttonborderradius.dart';
import 'package:telodigo/ui/components/customcomponents/customoption.dart';
import 'package:telodigo/ui/components/customcomponents/customtextfield.dart';
import 'package:telodigo/ui/components/respuestas/respuesta_sign_in.dart';
import 'package:telodigo/ui/pages/change_password/change_password.dart';

class sign_in extends StatefulWidget {
  const sign_in({super.key});

  @override
  State<sign_in> createState() => _sign_inState();
}

class _sign_inState extends State<sign_in> {
  
  final TextEditingController controller_userName =
      TextEditingController(text: "");
  final TextEditingController controller_password =
      TextEditingController(text: "");

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
            CustomOption(true, context),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            CustomTextField1(
                nombre: "Usuario",
                isPassword: false,
                controller: controller_userName),
            CustomTextField1(
                nombre: "Contraseña",
                isPassword: true,
                controller: controller_password),
            Padding(
              padding: EdgeInsets.only(top: 10, bottom: 50),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  splashColor: Color.fromARGB(123, 206, 206, 206),
                  onTap: () async {
                    await Future.delayed(Duration(milliseconds: 500), () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => const changePassword()));
                    });
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(10),
                    child:  Text(
                      "¿Olvidaste tu contraseña?",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            CustomButtonsRadius(const Color(0xffffffff),
                const Color(0xff3B2151), "¡COMENZAR!", false, () async {
                  var resp = await login(user: controller_userName.text, password: controller_password.text, context: context);

                  if(resp == true || resp == false){
                    FocusScope.of(context).requestFocus(FocusNode());
                  }

                }),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    ));
  }
}
