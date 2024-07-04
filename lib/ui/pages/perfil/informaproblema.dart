import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telodigo/data/controllers/usercontroller.dart';
import 'package:telodigo/domain/models/informe.dart';
import 'package:telodigo/ui/pages/home/home.dart';

class InformaProblema extends StatefulWidget {
  const InformaProblema({super.key});

  @override
  State<InformaProblema> createState() => _InformaProblemaState();
}

class _InformaProblemaState extends State<InformaProblema> {
  TextEditingController controller = TextEditingController();
  bool isButtonDisabled = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Color.fromARGB(255, 29, 7, 48),
        title: Text(
          "Informa un problema",
          style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500,
              color: Color.fromARGB(255, 255, 255, 255)),
        ),
      ),
      backgroundColor: Color.fromARGB(255, 29, 7, 48),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              height: 150,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromARGB(255, 221, 219, 219),
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: TextField(
                controller: controller,
                maxLines: null,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Escribe aquí...',
                  hintStyle: TextStyle(color: Colors.white),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(8.0),
                ),
              ),
            ),
           
            ElevatedButton(
              onPressed: isButtonDisabled
                  ? null
                  : () {
                      if (controller.text.isEmpty) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text(
                                "Error al validar",
                                style: TextStyle(fontSize: 15),
                              ),
                              content: const Text(
                                  "Por favor, digite un mensaje en el cual informe su problema."),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text("Aceptar"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        setState(() {
                          isButtonDisabled = true;
                        });

                        crearInforme(controller.text).then((_) {
                          Future.delayed(Duration(seconds: 5), () {
                            setState(() {
                              isButtonDisabled = false;
                            });
                          });
                        });
                      }
                    },
              child: const Text("Enviar"),
            ),
          ],
        ),
      ),
    );
  }

  Future crearInforme(String mensaje) async {
    final UserController controlleruser = Get.find();
    final CollectionReference collection =
        FirebaseFirestore.instance.collection("InformeProblema");
    final nuevoReporte = Informe(
      correo: controlleruser.usuario!.correo,
      mensaje: mensaje,
      fecha: DateTime.now(),
    );

    await collection.add(nuevoReporte.toJson());

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "¡Enviado Correctamente!",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
          content: const Text("Hemos recibido su informe de error correctamente. Muy pronto estaremos contactándonos con usted."),
          actions: [
            TextButton(
              child: const Text("Aceptar"),
              onPressed: () {
                // Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomeUser(
                              currentIndex: 4,
                            )));
              },
            ),
          ],
        );
      },
    );
  }
}
