import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telodigo/data/controllers/negociocontroller.dart';
import 'package:telodigo/ui/pages/crear%20anuncio/crearanuncioview8.dart';

class CrearAnuncioView7 extends StatefulWidget {
  const CrearAnuncioView7({super.key});

  @override
  State<CrearAnuncioView7> createState() => _CrearAnuncioView7State();
}

class _CrearAnuncioView7State extends State<CrearAnuncioView7> {
  bool checkYape = false;
  bool checkEfectivo = false;
  bool checkPlin = false;
  bool checkTarjeta = false;

  static final NegocioController controllerhotel = Get.find();
  List<String> metodos = [];

  bool btnAcive() {
    if (checkYape || checkEfectivo || checkPlin || checkTarjeta) {
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 21, 1, 37),
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Paso 8 de 10",
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
                  "Añade tus métodos de pago",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  "¿Cómo pueden pagarte los clientes?",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            Container(
              width: 400,
              margin: EdgeInsets.only(top: 30),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  "Selecciona los método de pago que tienes disponible",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ),
            ),
            Container(
                width: 400,
                margin:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Efectivo",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white),
                              ),
                              Checkbox(
                                value: checkEfectivo,
                                onChanged: (newbool) {
                                  setState(() {
                                    checkEfectivo = newbool!;
                                  });
                                },
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: 170,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Tarjeta de crédito",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white),
                              ),
                              Checkbox(
                                value: checkTarjeta,
                                onChanged: (newbool) {
                                  setState(() {
                                    checkTarjeta = newbool!;
                                  });
                                },
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Yape",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white),
                              ),
                              Checkbox(
                                value: checkYape,
                                onChanged: (newbool) {
                                  setState(() {
                                    checkYape = newbool!;
                                  });
                                },
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: 170,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Plin",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white),
                              ),
                              Checkbox(
                                value: checkPlin,
                                onChanged: (newbool) {
                                  setState(() {
                                    checkPlin = newbool!;
                                  });
                                },
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ))
          ]))),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                disabledBackgroundColor:
                    const Color.fromARGB(255, 200, 200, 200).withOpacity(0.12),
                padding: const EdgeInsets.symmetric(vertical: 15),
                backgroundColor: const Color(0xFF1098E7)),
            onPressed: btnAcive()
                ? null
                : () {
                    if (checkYape) {
                      metodos.add("Yape");
                    }
                    if (checkPlin) {
                      metodos.add("Plin");
                    }
                    if (checkTarjeta) {
                      metodos.add("Tarjeta de Credito");
                    }
                    if (checkEfectivo) {
                      metodos.add("Efectivo");
                    }

                    controllerhotel.NewMetodoPago(metodos);
                    metodos = [];

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CrearAnuncioView8()));
                  },
            child: Text(
              "Siguiente",
              style: TextStyle(color: Colors.white),
            )),
      ),
    );
  }
}
