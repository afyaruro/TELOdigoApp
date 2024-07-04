import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telodigo/data/controllers/negociocontroller.dart';
import 'package:telodigo/ui/pages/crear%20anuncio/crearanuncioview3.dart';

class CrearAnuncioViewCategorias extends StatefulWidget {
  const CrearAnuncioViewCategorias({
    super.key,
  });

  @override
  State<CrearAnuncioViewCategorias> createState() =>
      _CrearAnuncioViewCategoriasState();
}

class _CrearAnuncioViewCategoriasState
    extends State<CrearAnuncioViewCategorias> {
  bool btnFichos = false;
  bool btnEconomicos = false;
  bool btnCaletas = false;
  bool btnTematicos = false;
  bool btnInclusivos = false;
  bool btnBungalows = false;

  List<String> categorias = [];

  static final NegocioController controllernegocio = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 21, 1, 37),
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Paso 3 de 10",
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
              child: Column(children: [
            const SizedBox(height: 50),
            Container(
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  "Selecciona las categorias a la que se ajusta tu negocio",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Wrap(
              runSpacing: 10,
              spacing: 20,
              children: [
                Container(
                    width: 140,
                    height: 80,
                    child: btnCategory(
                      nombre: "FICHOS",
                      btn: btnFichos,
                      function: () {
                        btnFichos = !btnFichos;
                        setState(() {});
                      },
                    )),
                Container(
                    width: 140,
                    height: 80,
                    child: btnCategory(
                      nombre: "ECONOMICOS",
                      btn: btnEconomicos,
                      function: () {
                        btnEconomicos = !btnEconomicos;
                        setState(() {});
                      },
                    )),
                Container(
                    width: 140,
                    height: 80,
                    child: btnCategory(
                      nombre: "CALETAS",
                      btn: btnCaletas,
                      function: () {
                        btnCaletas = !btnCaletas;
                        setState(() {});
                      },
                    )),
                Container(
                    width: 140,
                    height: 80,
                    child: btnCategory(
                      nombre: "TEMATICOS",
                      btn: btnTematicos,
                      function: () {
                        btnTematicos = !btnTematicos;
                        setState(() {});
                      },
                    )),
                Container(
                    width: 140,
                    height: 80,
                    child: btnCategory(
                      nombre: "TODXS (LGBTIQ+)",
                      btn: btnInclusivos,
                      function: () {
                        btnInclusivos = !btnInclusivos;
                        setState(() {});
                      },
                    )),
                Container(
                    width: 140,
                    height: 80,
                    child: btnCategory(
                      nombre: "BUNGALOWS",
                      btn: btnBungalows,
                      function: () {
                        btnBungalows = !btnBungalows;
                        setState(() {});
                      },
                    ))
              ],
            ),
          ]))),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 15),
              backgroundColor: const Color(0xFF1098E7),
              disabledBackgroundColor:
                  const Color.fromARGB(255, 200, 200, 200).withOpacity(0.12),
            ),
            onPressed: btnFichos ||
                    btnBungalows ||
                    btnCaletas ||
                    btnEconomicos ||
                    btnInclusivos ||
                    btnTematicos
                ? () {
                    if (btnFichos) {
                      categorias.add("FICHOS");
                    }

                    if (btnEconomicos) {
                      categorias.add("ECONOMICOS");
                    }

                    if (btnCaletas) {
                      categorias.add("CALETAS");
                    }

                    if (btnTematicos) {
                      categorias.add("TEMATICOS");
                    }

                    if (btnInclusivos) {
                      categorias.add("INCLUSIVOS (LGBT friendly)");
                    }

                    if (btnBungalows) {
                      categorias.add("BUNGALOWS");
                    }

                    controllernegocio.ListCategorias(categorias);
                    categorias = [];

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CrearAnuncioView3()));
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

class btnCategory extends StatelessWidget {
  final String nombre;
  final bool btn;
  final Function function;

  const btnCategory({
    super.key,
    required this.nombre,
    required this.btn,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: btn
              ? const Color.fromARGB(255, 80, 27, 167)
              : const Color.fromARGB(255, 255, 255, 255),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        onPressed: () {
          function();
        },
        child: Text(
          nombre,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 13,
              color: btn
                  ? const Color.fromARGB(255, 255, 255, 255)
                  : const Color.fromARGB(255, 80, 27, 167)),
        ));
  }
}
