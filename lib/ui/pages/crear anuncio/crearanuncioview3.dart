import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telodigo/data/controllers/negociocontroller.dart';
import 'package:telodigo/ui/pages/crear%20anuncio/crearanunciomap.dart';
import 'package:telodigo/ui/pages/crear%20anuncio/crearanuncioview4.dart';

class CrearAnuncioView3 extends StatefulWidget {
  const CrearAnuncioView3({super.key});

  @override
  State<CrearAnuncioView3> createState() => _CrearAnuncioView3State();
}

class _CrearAnuncioView3State extends State<CrearAnuncioView3> {
  TextEditingController controller = TextEditingController(text: "");
  static final NegocioController controllerhotel = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 21, 1, 37),
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Paso 4 de 10",
          style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontSize: 15,
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 21, 1, 37),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 50),
              Container(
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    "Proporciona tu ubicación a tus futuros clientes",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ),
              ),
              Container(
                  width: 400,
                  margin: const EdgeInsets.only(
                    top: 5,
                    left: 30,
                    right: 30,
                  ),
                  child: const Text(
                    "Dirección del Establecimiento",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontWeight: FontWeight.w500, color: Colors.white),
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: CustomTextField1(
                    dimension: 40, nombre: "", controller: controller),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 15),
              backgroundColor: const Color.fromARGB(255, 16, 152, 231),
              disabledBackgroundColor:
                  const Color.fromARGB(255, 200, 200, 200).withOpacity(0.12),
            ),
            onPressed: controller.text != ""
                ? () {
                    controllerhotel.NewDireccion(controller.text);

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CrearAnuncioMap()));
                  }
                : null,
            child: const Text(
              "Siguiente",
              style: TextStyle(color: Colors.white),
            )),
      ),
    );
  }
}
