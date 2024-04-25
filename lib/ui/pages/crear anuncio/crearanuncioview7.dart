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
        backgroundColor: Color.fromARGB(255, 21, 1, 37),
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Paso 7 de 9",
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
                  "Añade tus métodos de pago",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
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
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Container(
                width: 400,
                margin: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 80,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Yape",
                                style: TextStyle(fontSize: 14),
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
                              Text(
                                "Efectivo",
                                style: TextStyle(fontSize: 14),
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
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 80,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Plin",
                                style: TextStyle(fontSize: 14),
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
                        Container(
                          width: 170,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Tarjeta de Credito",
                                style: TextStyle(fontSize: 14),
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
                  ],
                ))
          ]))),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15),
                backgroundColor: Color(0xFF1098E7)),
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
