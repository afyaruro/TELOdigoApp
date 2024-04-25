import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telodigo/data/controllers/negociocontroller.dart';
import 'package:telodigo/domain/models/habitaciones.dart';
import 'package:telodigo/ui/pages/crear%20anuncio/crearanuncioview6.dart';

class CrearAnuncioView5 extends StatefulWidget {
  const CrearAnuncioView5({super.key});

  @override
  State<CrearAnuncioView5> createState() => _CrearAnuncioView5State();
}

class _CrearAnuncioView5State extends State<CrearAnuncioView5> {
  static final NegocioController controllerhotel = Get.find();

  List<Habitaciones> habitaciones = controllerhotel.habitaciones!;

  bool banderaBtnActive = true;

bool verificarCantidad(List<Habitaciones> habitaciones) {
  return habitaciones.any((habitacion) => habitacion.cantidad == 0);
}

Widget btnActive(List<Habitaciones> habitaciones){
  if(verificarCantidad(habitaciones)){
    banderaBtnActive = true;
  } else {
    banderaBtnActive = false;
  }
  return Container();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 21, 1, 37),
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Paso 5 de 9",
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
              btnActive(habitaciones),
              const SizedBox(height: 50),
              Container(
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    "Agrega la cantidad de habitaciones por tipo de cuarto",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              for (var habitacion in habitaciones)
                Container(
                  width: 400,
                  margin: EdgeInsets.symmetric(
                    horizontal: 30,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        habitacion.nombre,
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Row(
                        children: [
                          Container(
                              width: 30,
                              decoration: ShapeDecoration(
                                color: Color.fromARGB(255, 29, 29, 29),
                                shape: CircleBorder(),
                              ),
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (habitacion.cantidad > 0) {
                                      habitacion.cantidad =
                                          habitacion.cantidad - 1;
                                    }
                                  });
                                },
                                icon: Icon(Icons.remove),
                                color: Colors.white,
                                iconSize: 15,
                              )),
                          SizedBox(
                            width: 10,
                          ),
                          Text("${habitacion.cantidad}"),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                              width: 30,
                              decoration: ShapeDecoration(
                                color: Color(0xFF1098E7),
                                shape: CircleBorder(),
                              ),
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    habitacion.cantidad =
                                        habitacion.cantidad + 1;
                                  });
                                },
                                icon: Icon(Icons.add),
                                color: Colors.white,
                                iconSize: 15,
                              ))
                        ],
                      ),
                      
                    ],
                  ),
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
                backgroundColor: Color(0xFF1098E7)),
            onPressed: banderaBtnActive
                ? null
                : () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CrearAnuncioView6()));
                  },
            child: Text(
              "Siguiente",
              style: TextStyle(color: Colors.white),
            )),
      ),
    );
  }
}
