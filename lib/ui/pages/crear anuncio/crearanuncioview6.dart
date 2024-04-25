import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:telodigo/data/controllers/negociocontroller.dart';
import 'package:telodigo/domain/models/habitaciones.dart';
import 'package:telodigo/ui/pages/crear%20anuncio/crearanuncioview7.dart';

class CrearAnuncioView6 extends StatefulWidget {
  const CrearAnuncioView6({super.key});

  @override
  State<CrearAnuncioView6> createState() => _CrearAnuncioView6State();
}

class _CrearAnuncioView6State extends State<CrearAnuncioView6> {
  static final NegocioController controllerhotel = Get.find();
  TextEditingController horaController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 21, 1, 37),
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Paso 6 de 9",
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
              width: 400,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  "Añade tus precios",
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
                  "Añade los precios según los tipos de habitación y las horas",
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
                  "Seleccione el tipo de habitación para editar",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            for (var habitacion in controllerhotel.habitaciones!)
              Container(
                  width: 400,
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  decoration: BoxDecoration(
                      // color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black45, width: 1)),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(habitacion.nombre,
                              style: TextStyle(fontWeight: FontWeight.w500)),
                          IconButton(onPressed: () {}, icon: Icon(Icons.add))
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            child: Text(
                              "Hora",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ),
                          SizedBox(
                            width: 100,
                          ),
                          Container(
                            child: Text("Precio",
                                style: TextStyle(fontWeight: FontWeight.w500)),
                          )
                        ],
                      ),

//precios
                      for (var precio in habitacion.precios)
                        Row(
                          children: [
                            Container(
                              width: 40,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  horaController.text = value;
                                  precio.hora =
                                      int.tryParse(horaController.text) ??
                                          precio.hora;
                                },
                                onEditingComplete: () {
                                  setState(() {
                                    precio.hora =
                                        int.tryParse(horaController.text) ??
                                            precio.hora;
                                  });
                                },
                                controller: TextEditingController(
                                    text: precio.hora.toString()),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    habitacion.precios.remove(precio);
                                  });
                                },
                                icon: Icon(Icons.delete))
                          ],
                        ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(),
                          Container(
                            margin: EdgeInsets.all(10),
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blue,
                            ),
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  habitacion.precios
                                      .add(Precios(precio: 0, hora: 0));
                                });
                              },
                              icon: Icon(
                                Icons.add,
                                size: 15,
                              ),
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ],
                  )),

// Column(
//   children: [
//     for (var habitacion in controllerhotel.habitaciones!)
//       Column(
//         children: [
//           Container(
//             width: 400,
//             margin: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
//             padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               border: Border.all(color: Colors.black45, width: 1),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(habitacion.nombre, style: TextStyle(fontWeight: FontWeight.w500)),
//                     IconButton(
//                       onPressed: () {
//                         // Agregar un nuevo precio para esta habitación
//                         setState(() {
//                           habitacion.precios.add(Precios(precio: 0, tiempo: 0));
//                         });
//                       },
//                       icon: Icon(Icons.add),
//                     ),
//                   ],
//                 ),
//                 for (var precio in habitacion.precios)
//                   Row(
//                     children: [
//                       Expanded(
//                         child: TextField(
//                           decoration: InputDecoration(labelText: 'Hora'),
//                           onChanged: (value) {
//                             // Actualizar el tiempo en el modelo
//                             precio.tiempo = int.tryParse(value) ?? 0;
//                           },
//                         ),
//                       ),
//                       SizedBox(width: 20),
//                       Expanded(
//                         child: TextField(
//                           decoration: InputDecoration(labelText: 'Precio'),
//                           onChanged: (value) {
//                             // Actualizar el precio en el modelo
//                             precio.precio = double.tryParse(value) ?? 0.0;
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//               ],
//             ),
//           ),
//           SizedBox(height: 10),
//         ],
//       ),
//   ],
// ),
          ]))),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15),
                backgroundColor: Color(0xFF1098E7)),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CrearAnuncioView7()));
            },
            child: Text(
              "Siguiente",
              style: TextStyle(color: Colors.white),
            )),
      ),
    );
  }
}
