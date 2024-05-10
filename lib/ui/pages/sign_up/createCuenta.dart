// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:telodigo/data/service/peticionnegocio.dart';
import 'package:telodigo/ui/components/customcomponents/custombackgroundlogin.dart';
import 'package:telodigo/ui/components/customcomponents/custombuttonborderradius.dart';
import 'package:telodigo/ui/components/customcomponents/exitconfirmation.dart';
import 'package:telodigo/ui/pages/home/home.dart';

class CreateCuenta extends StatelessWidget {
  const CreateCuenta({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Mostrar la alerta y esperar la respuesta del usuario
        bool exits = await showDialog(
          context: context,
          builder: (context) => ExitConfirmationDialog(),
        );
        if (exits) {
          exit(0);
        }
        // Devolver false para evitar que la acción de retroceso continúe
        return false;
      },
      child: Scaffold(
        body: CustomBackgroundLogin(
            child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
              ),
              Image(
                image: AssetImage("assets/star.png"),
                height: 140,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50.0, vertical: 30),
                child: Center(
                    child: Text(
                  "Felicidades su cuenta se ha creado exitosamente",
                  style: TextStyle(
                      color: Color.fromARGB(226, 219, 224, 255), fontSize: 15),
                  textAlign: TextAlign.center,
                )),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              CustomButtonsRadius(
                  Colors.white, Colors.black, "Continuar", false, () {
                PeticionesNegocio.listNegocios();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          HomeUser()), //debe mandar ya adentro de la app
                  (Route<dynamic> route) => false,
                );
              }),
              SizedBox(height: MediaQuery.of(context).size.height * 0.2),
            ],
          ),
        )),
      ),
    );
  }
}
