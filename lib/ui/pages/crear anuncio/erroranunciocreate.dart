// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telodigo/data/controllers/negociocontroller.dart';
import 'package:telodigo/data/controllers/usercontroller.dart';
import 'package:telodigo/data/service/peticionnegocio.dart';
import 'package:telodigo/ui/components/customcomponents/exitconfirmation.dart';
import 'package:telodigo/ui/pages/crear%20anuncio/anunciocreado.dart';
import 'package:telodigo/ui/pages/home%20anfitrion/homeanfitrion.dart';

class ErrorAnuncioCreate extends StatelessWidget {
  final List<String> servicios;
  const ErrorAnuncioCreate({super.key, required this.servicios});

  @override
  Widget build(BuildContext context) {
    final NegocioController controllerhotel = Get.find();
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
                  "Hemos tenido un error al intentar crear el anuncio",
                  style: TextStyle(
                      color: Color.fromARGB(225, 0, 0, 0),
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                )),
              ),
              // SizedBox(height: MediaQuery.of(context).size.height,

              Container(
                width: 400,
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        backgroundColor: Color.fromARGB(255, 233, 233, 233)),
                    onPressed: () async {
                      final CollectionReference collection =
                          FirebaseFirestore.instance.collection("Negocios");
                      var hotelCount = (await collection.get()).size;

                      var negocio = <String, dynamic>{
                        "id": hotelCount + 1,
                        "nombre": controllerhotel.nombreNegocio,
                        "tipoEspacio": controllerhotel.tipoEspacio,
                        "habitaciones": controllerhotel.habitaciones
                            ?.map((habitacion) => habitacion.toJson())
                            .toList(),
                        "longitud": controllerhotel.longitud,
                        "latitud": controllerhotel.latitud,
                        "direccion": controllerhotel.direccion,

                        "horaAbrir": controllerhotel.horaAbrir,
                        "horaCerrar": controllerhotel.horaCerrar,
                        "minutoAbrir": controllerhotel.minutoAbrir,
                        "minutoCerrar": controllerhotel.minutoCerrar,
                        "tipoHorario": controllerhotel.tipoHorario,
                        
                        "metodosPago": controllerhotel.metodosPago,
                        "servicios": servicios,
                        "fotos": controllerhotel.images
                            ?.map((foto) => foto.toJson())
                            .toList(),
                        "user": controlleruser.usuario!.userName,
                        "saldo": 0.0,
                        "calificacion": 3.0,
                      };

                      var resp = await PeticionesNegocio.crearNegocio(
                          negocio, context, []);

                      if (resp == "create") {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AnuncioCreado()));
                      } else {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ErrorAnuncioCreate(
                                    servicios: servicios,
                                  )), //debe mandar ya adentro de la app
                          (Route<dynamic> route) => false,
                        );
                      }
                    },
                    child: Text(
                      "Vuelve a intentarlo",
                      style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                    )),
              ),

              Container(
                width: 400,
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        backgroundColor: Color(0xFF1098E7)),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const HomeAnfitrion()), //debe mandar ya adentro de la app
                        (Route<dynamic> route) => false,
                      );
                    },
                    child: Text(
                      "Cancelar",
                      style: TextStyle(color: Colors.white),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
