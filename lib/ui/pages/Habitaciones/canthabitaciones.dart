import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:telodigo/domain/models/habitaciones.dart';
import 'package:telodigo/domain/models/hoteles.dart';

class CantHabitaciones extends StatefulWidget {
  final Hoteles hotel;
  const CantHabitaciones({super.key, required this.hotel});

  @override
  State<CantHabitaciones> createState() => _CantHabitacionesState();
}

class _CantHabitacionesState extends State<CantHabitaciones> {
  List<Habitaciones> habitaciones = [];

  @override
  void initState() {
    super.initState();

    habitaciones = widget.hotel.habitaciones;
  }

  @override
  Widget build(BuildContext context) {
    Future<void> ActualizarHabitaciones() async {
      final CollectionReference collection =
          FirebaseFirestore.instance.collection("Negocios");

      QuerySnapshot querySnapshot = await collection
          .where('user', isEqualTo: widget.hotel.user)
          .where('nombre', isEqualTo: widget.hotel.nombre)
          .get();

      DocumentSnapshot document = querySnapshot.docs.first;
      String documentoId = document.id;

      await collection.doc(documentoId).update({
        "habitaciones":
            habitaciones.map((habitacion) => habitacion.toJson()).toList(),
      });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 29, 7, 48),
        foregroundColor: Colors.white,
      ),
      body: Container(
        color: Color.fromARGB(255, 29, 7, 48),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 50),
              Container(
                width: 400,
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    "Disponibilidad de habitaciones",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                width: 400,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    widget.hotel.nombre,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ),
              ),
              for (var habitacion in habitaciones)
                Container(
                  width: 400,
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromARGB(59, 255, 255, 255)),
                  margin: EdgeInsets.only(right: 30, left: 30, top: 10),
                  child: Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 12,
                                  height: 12,
                                  decoration: BoxDecoration(
                                      color: habitacion.cantidad > 0
                                          ? Color(0xFF00FF0A)
                                          : Colors.amber,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(6))),
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  habitacion.cantidad > 0
                                      ? "Disponible"
                                      : "No disponible",
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ]),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            habitacion.nombre,
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                          Container(
                            child: Text(
                              "${habitacion.cantidad}",
                              style: TextStyle(color: Colors.white),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color.fromARGB(255, 194, 194, 194),
                                    width: 1),
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          Row(
                            children: [
                              Container(
                                  width: 30,
                                  decoration: ShapeDecoration(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    shape: CircleBorder(),
                                  ),
                                  child: IconButton(
                                    onPressed: () async {
                                      setState(() {
                                        if (habitacion.cantidad > 0) {
                                          habitacion.cantidad =
                                              habitacion.cantidad - 1;
                                        }
                                      });

                                      await ActualizarHabitaciones();
                                    },
                                    icon: Icon(Icons.remove),
                                    color: Color.fromARGB(255, 26, 15, 90),
                                    iconSize: 15,
                                  )),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                  width: 30,
                                  decoration: ShapeDecoration(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    shape: CircleBorder(),
                                  ),
                                  child: IconButton(
                                    onPressed: () async {
                                      setState(() {
                                        habitacion.cantidad =
                                            habitacion.cantidad + 1;
                                      });

                                      await ActualizarHabitaciones();
                                    },
                                    icon: Icon(Icons.add),
                                    color: Color.fromARGB(255, 26, 15, 90),
                                    iconSize: 15,
                                  ))
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: Padding(
      //   padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      //   child: ElevatedButton(
      //       style: ElevatedButton.styleFrom(
      //           padding: EdgeInsets.symmetric(vertical: 15),
      //           backgroundColor: Color(0xFF1098E7)),
      //       onPressed: () {
      //         print("${habitaciones[0].cantidad}");
      //         // Navigator.push(
      //         //     context,
      //         //     MaterialPageRoute(
      //         //         builder: (context) => CrearAnuncioView6()));
      //       },
      //       child: Text(
      //         "Actualizar",
      //         style: TextStyle(color: Colors.white),
      //       )),
      // ),
    );
  }
}
