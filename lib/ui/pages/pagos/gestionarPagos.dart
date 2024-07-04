// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:telodigo/data/controllers/usercontroller.dart';
// import 'package:telodigo/domain/models/solicitdPago.dart';
// import 'package:telodigo/ui/pages/home%20anfitrion/homeanfitrion.dart';
// import 'package:telodigo/ui/pages/pagos/cantidadRetiro.dart';
// import 'package:telodigo/ui/pages/pagos/detalleSolicitud.dart';

// class SolicitarPagos extends StatefulWidget {
//   const SolicitarPagos({super.key});

//   @override
//   State<SolicitarPagos> createState() => _SolicitarPagosState();
// }

// class _SolicitarPagosState extends State<SolicitarPagos> {
//   static final UserController controlleruser = Get.find();
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   Future<double> saldoActual() async {
//     QuerySnapshot querySnapshot = await FirebaseFirestore.instance
//         .collection("Usuarios")
//         .where('userName', isEqualTo: controlleruser.usuario!.userName)
//         .get();

//     if (querySnapshot.docs.isNotEmpty) {
//       DocumentSnapshot document = querySnapshot.docs.first;
//       double saldoActual = document['saldoCuenta'];

//       return saldoActual;
//     }

//     return 0.0;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => const HomeAnfitrion(
//                   currentIndex: 4,
//                 ),
//               ),
//             );
//           },
//         ),
//         title: const Text(
//           "Solicitar Pago",
//           style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
//         ),
//         backgroundColor: const Color.fromARGB(255, 29, 7, 48),
//         foregroundColor: Colors.white,
//       ),
//       backgroundColor: const Color.fromARGB(255, 29, 7, 48),
//       body: SingleChildScrollView(
//         child: Container(
//           width: MediaQuery.of(context).size.width,
//           child: Column(
//             children: [
//               const SizedBox(height: 50),
//               Text(
//                 "S/${controlleruser.usuario!.saldoCuenta.toStringAsFixed(2)}",
//                 style: const TextStyle(color: Colors.white, fontSize: 30),
//               ),
//               const Text(
//                 "Dinero en la cuenta",
//                 style:
//                     TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => CantidadRetiro(
//                         saldoCuenta: controlleruser.usuario!.saldoCuenta,
//                       ),
//                     ),
//                   );
//                 },
//                 child: const Text("Retirar"),
//               ),
//               const SizedBox(height: 30),
//               const Text(
//                 "Historial de retiros",
//                 style:
//                     TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
//               ),
//               const SizedBox(height: 20),
//               const Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 20),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       "Concepto",
//                       style: TextStyle(
//                           color: Colors.white, fontWeight: FontWeight.w600),
//                     ),
//                     Text(
//                       "Estado",
//                       style: TextStyle(
//                           color: Colors.white, fontWeight: FontWeight.w600),
//                     ),
//                   ],
//                 ),
//               ),
//               StreamBuilder<QuerySnapshot>(
//                 stream: _firestore
//                     .collection('Pagos')
//                     .where('userAnfitrion',
//                         isEqualTo: controlleruser.usuario!.userName)
//                     .snapshots(),
//                 builder: (context, snapshot) {
//                   if (!snapshot.hasData) {
//                     return const Center(child: CircularProgressIndicator());
//                   }

//                   final pagos = snapshot.data!.docs.map((doc) {
//                     return SolicitudPago.fromJson(
//                         doc.data() as Map<String, dynamic>);
//                   }).toList();

//                   // Ordenar los pagos por fecha, del más nuevo al más antiguo
//                   pagos.sort((a, b) => b.fecha.compareTo(a.fecha));

//                   return ListView.builder(
//                     shrinkWrap: true,
//                     physics:
//                         NeverScrollableScrollPhysics(), // Prevents the inner ListView from scrolling
//                     itemCount: pagos.length,
//                     itemBuilder: (context, index) {
//                       final pago = pagos[index];
//                       return InkWell(
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => DetalleSolicitudPago(
//                                 solicitudPago: pago,
//                               ),
//                             ),
//                           );
//                         },
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 20, vertical: 10),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     pago.concepto,
//                                     style: const TextStyle(
//                                         color:
//                                             Color.fromARGB(255, 101, 57, 202)),
//                                   ),
//                                   Text(
//                                     "${pago.fecha.day.toString().padLeft(2, '0')}/${pago.fecha.month.toString().padLeft(2, '0')}/${pago.fecha.year} - ${pago.fecha.hour.toString().padLeft(2, '0')}:${pago.fecha.minute.toString().padLeft(2, '0')}",
//                                     style:
//                                         const TextStyle(color: Colors.white70),
//                                   ),
//                                 ],
//                               ),
//                               Text(
//                                 pago.estado,
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.w500,
//                                     color: pago.estado == "En espera"
//                                         ? const Color.fromARGB(
//                                             255, 255, 255, 255)
//                                         : pago.estado == "Rechazado"
//                                             ? Colors.red
//                                             : Colors.green),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:telodigo/data/controllers/usercontroller.dart';
import 'package:telodigo/domain/models/solicitdPago.dart';
import 'package:telodigo/ui/pages/home%20anfitrion/homeanfitrion.dart';
import 'package:telodigo/ui/pages/pagos/cantidadRetiro.dart';
import 'package:telodigo/ui/pages/pagos/detalleSolicitud.dart';

class SolicitarPagos extends StatefulWidget {
  const SolicitarPagos({super.key});

  @override
  State<SolicitarPagos> createState() => _SolicitarPagosState();
}

class _SolicitarPagosState extends State<SolicitarPagos> {
  static final UserController controlleruser = Get.find();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<double> saldoActual() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("Usuarios")
        .where('userName', isEqualTo: controlleruser.usuario!.userName)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot document = querySnapshot.docs.first;
      double saldoActual = document['saldoCuenta'];

      return saldoActual;
    }

    return 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeAnfitrion(
                  currentIndex: 4,
                ),
              ),
            );
          },
        ),
        title: const Text(
          "Solicitar Pago",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color.fromARGB(255, 29, 7, 48),
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color.fromARGB(255, 29, 7, 48),
      body: FutureBuilder<double>(
        future: saldoActual(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Error al cargar el saldo"));
          } else {
            double saldo = snapshot.data ?? 0.0;
            return SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    Text(
                      "S/${saldo.toStringAsFixed(2)}",
                      style: const TextStyle(color: Colors.white, fontSize: 30),
                    ),
                    const Text(
                      "Dinero en la cuenta",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CantidadRetiro(
                              saldoCuenta: saldo,
                            ),
                          ),
                        );
                      },
                      child: const Text("Retirar"),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      "Historial de retiros",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 20),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Concepto",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "Estado",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    StreamBuilder<QuerySnapshot>(
                      stream: _firestore
                          .collection('Pagos')
                          .where('userAnfitrion',
                              isEqualTo: controlleruser.usuario!.userName)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        final pagos = snapshot.data!.docs.map((doc) {
                          return SolicitudPago.fromJson(
                              doc.data() as Map<String, dynamic>);
                        }).toList();

                        // Ordenar los pagos por fecha, del más nuevo al más antiguo
                        pagos.sort((a, b) => b.fecha.compareTo(a.fecha));

                        return ListView.builder(
                          shrinkWrap: true,
                          physics:
                              NeverScrollableScrollPhysics(), // Prevents the inner ListView from scrolling
                          itemCount: pagos.length,
                          itemBuilder: (context, index) {
                            final pago = pagos[index];
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetalleSolicitudPago(
                                      solicitudPago: pago,
                                    ),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          pago.concepto,
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 101, 57, 202)),
                                        ),
                                        Text(
                                          "${pago.fecha.day.toString().padLeft(2, '0')}/${pago.fecha.month.toString().padLeft(2, '0')}/${pago.fecha.year} - ${pago.fecha.hour.toString().padLeft(2, '0')}:${pago.fecha.minute.toString().padLeft(2, '0')}",
                                          style: const TextStyle(
                                              color: Colors.white70),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      pago.estado,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: pago.estado == "En espera"
                                              ? const Color.fromARGB(
                                                  255, 255, 255, 255)
                                              : pago.estado == "Rechazado"
                                                  ? Colors.red
                                                  : Colors.green),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
