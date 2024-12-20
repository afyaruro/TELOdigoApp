// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telodigo/data/controllers/usercontroller.dart';
import 'package:telodigo/ui/components/customcomponents/exitconfirmation.dart';
import 'package:telodigo/ui/pages/anuncios%20anfitrion/anunciosanfitrion.dart';
import 'package:telodigo/ui/pages/home%20anfitrion/homeanfitrion.dart';

class AnuncioCreado extends StatelessWidget {
  const AnuncioCreado({super.key});

  @override
  Widget build(BuildContext context) {
    final UserController controlleruser = Get.find();
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
        return false;
      },
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
              ),
              Image(
                image: AssetImage("assets/negocio_create.png"),
                height: 140,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50.0, vertical: 30),
                child: Center(
                    child: Text(
                  "¡Felicidades, has conseguido registrar tu negocio exitosamente!",
                  style: TextStyle(
                      color: Color.fromARGB(225, 0, 0, 0),
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                )),
              ),
              // SizedBox(height: MediaQuery.of(context).size.height,
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10),
                child: Center(
                    child: Text(
                  "Te recordamos que para que tu negocio sea visible para otros usuarios, debes haber recargado más de 5 soles.",
                  style: TextStyle(
                      color: Color.fromARGB(225, 0, 0, 0),
                      fontSize: 15,
                      fontWeight: FontWeight.w300),
                  textAlign: TextAlign.center,
                )),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: Color(0xFF1098E7)),
              onPressed: () {
                controlleruser.usuario!.userName == "Admin"
                    ? Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AnunciosAnfitrion()),
                        (Route<dynamic> route) => false,
                      )
                    : Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeAnfitrion()),
                        (Route<dynamic> route) => false,
                      );
              },
              child: Text(
                "Siguiente",
                style: TextStyle(color: Colors.white),
              )),
        ),
      ),
    );
  }
}
