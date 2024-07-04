import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telodigo/data/controllers/usercontroller.dart';
import 'package:telodigo/domain/models/usuario.dart';
import 'package:telodigo/ui/pages/administrador/VerificarNegocio/listaNegociosNoVerificados.dart';
import 'package:telodigo/ui/pages/anuncios%20anfitrion/anunciosanfitrion.dart';
import 'package:telodigo/ui/pages/inicio/init_page.dart';

class SalirAdmin extends StatelessWidget {
  const SalirAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    final UserController controlleruser = Get.find();

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: const Color.fromARGB(255, 29, 7, 48),
          height: MediaQuery.of(context).size.height - 60,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Wrap(
                spacing: 10,
                runSpacing: 20,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AnunciosAnfitrion()));
                      },
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.business_sharp),
                          Text(
                            "Registrar TELO",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    child: ElevatedButton(
                      onPressed: () async {
                        Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ListNegociosNoVerificados()));
                        
                      },
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.app_registration),
                          Text(
                            "TELOS por Aprobar",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 10),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    child: ElevatedButton(
                      onPressed: () async {
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
                                  Text("Cerrando Sesion..."),
                                ],
                              ),
                            );
                          },
                        );

                        Usuario usuario = Usuario(
                            saldoCuenta: 0,
                            userName: "",
                            password: "",
                            nombres: "",
                            apellidos: "",
                            correo: "",
                            fechaNacimiento: "",
                            foto: "",
                            modoOscuro: false);

                        controlleruser.DatosUser(usuario);

                        Future.delayed(
                          Duration(seconds: 2),
                          () {
                            Navigator.pop(context);
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Init_Page()),
                              (Route<dynamic> route) => false,
                            );
                          },
                        );
                      },
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.exit_to_app),
                          Text(
                            "Cerrar Sesión",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
