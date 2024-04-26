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
        backgroundColor: Color.fromARGB(255, 21, 1, 37),
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Paso 3 de 9",
          style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontSize: 15,
          ),
        ),
      ),
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
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              Container(
                  width: 400,
                  margin: EdgeInsets.only(
                    top: 5,
                    left: 30,
                    right: 30,
                  ),
                  child: Text(
                    "Dirección del Establecimiento",
                    textAlign: TextAlign.start,
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: CustomTextField1(nombre: "", controller: controller),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15),
                backgroundColor: Color.fromARGB(255, 16, 152, 231)),
            onPressed: controller.text != ""
                ? () {
                    controllerhotel.NewDireccion(controller.text);

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CrearAnuncioMap()));
                  }
                : null,
            child: Text(
              "Siguiente",
              style: TextStyle(color: Colors.white),
            )),
      ),
    );
  }
}
