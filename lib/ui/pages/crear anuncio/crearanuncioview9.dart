import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telodigo/data/controllers/negociocontroller.dart';
import 'package:telodigo/ui/pages/crear%20anuncio/anunciocreado.dart';

class CrearAnuncioView9 extends StatefulWidget {
  const CrearAnuncioView9({super.key});

  @override
  State<CrearAnuncioView9> createState() => _CrearAnuncioView9State();
}

class _CrearAnuncioView9State extends State<CrearAnuncioView9> {
  bool btnWifi = false;
  bool btnTv = false;
  bool btnSillonTantrico = false;
  bool btnAguaCaliente = false;
  bool btnCochera = false;
  bool btnNetflix = false;

  List<String> servicios = [];

  static final NegocioController controllerhotel = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 21, 1, 37),
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Paso 9 de 9",
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
              child: Column(children: [
            const SizedBox(height: 50),
            Container(
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  "Cuéntale a los huéspedes todo lo que tu negocio tiene para ofrecer",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Container(
              width: 400,
              margin: EdgeInsets.only(top: 10),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  "Agrega solo los servicios que ofreces",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              width: 400,
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      width: 130,
                      height: 60,
                      child: btnServicios(
                        nombre: "Wifi",
                        btn: btnWifi,
                        function: () {
                          btnWifi = !btnWifi;
                          setState(() {});
                        },
                      )),
                  Container(
                      width: 130,
                      height: 60,
                      child: btnServicios(
                        nombre: "TV",
                        btn: btnTv,
                        function: () {
                          btnTv = !btnTv;
                          setState(() {});
                        },
                      ))
                ],
              ),
            ),
            Container(
              width: 400,
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      width: 130,
                      height: 60,
                      child: btnServicios(
                        nombre: "Sillon Tántrico",
                        btn: btnSillonTantrico,
                        function: () {
                          btnSillonTantrico = !btnSillonTantrico;
                          setState(() {});
                        },
                      )),
                  Container(
                      width: 130,
                      height: 60,
                      child: btnServicios(
                        nombre: "Agua Caliente",
                        btn: btnAguaCaliente,
                        function: () {
                          btnAguaCaliente = !btnAguaCaliente;
                          setState(() {});
                        },
                      ))
                ],
              ),
            ),
            Container(
              width: 400,
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      width: 130,
                      height: 60,
                      child: btnServicios(
                        nombre: "Cochera",
                        btn: btnCochera,
                        function: () {
                          btnCochera = !btnCochera;
                          setState(() {});
                        },
                      )),
                  Container(
                      width: 130,
                      height: 60,
                      child: btnServicios(
                        nombre: "Netflix",
                        btn: btnNetflix,
                        function: () {
                          btnNetflix = !btnNetflix;
                          setState(() {});
                        },
                      ))
                ],
              ),
            ),
          ]))),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15),
                backgroundColor: Color(0xFF1098E7)),
            onPressed: () {
              if (btnWifi) {
                servicios.add("WIFI");
              }

              if (btnTv) {
                servicios.add("TV");
              }

              if (btnSillonTantrico) {
                servicios.add("Sillon Tántrico");
              }

              if (btnAguaCaliente) {
                servicios.add("Agua Caliente");
              }

              if (btnCochera) {
                servicios.add("Cochera");
              }

              if (btnNetflix) {
                servicios.add("Netflix");
              }

              controllerhotel.NewServicios(servicios);

              servicios = [];

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AnuncioCreado()));
            },
            child: Text(
              "Siguiente",
              style: TextStyle(color: Colors.white),
            )),
      ),
    );
  }
}

class btnServicios extends StatelessWidget {
  final String nombre;
  final bool btn;
  final Function function;

  const btnServicios({
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
              ? Color.fromARGB(255, 0, 0, 0)
              : const Color.fromARGB(255, 255, 255, 255),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        onPressed: () {
          function();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Text(
            nombre,
            textAlign: TextAlign.center,
          ),
        ));
  }
}
