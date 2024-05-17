// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// import 'package:flutter/material.dart';
// import 'package:telodigo/data/service/peticionnegocio.dart';
// import 'package:telodigo/domain/models/hoteles.dart';
// import 'package:telodigo/ui/pages/view%20hotel/viewhotelclientes.dart';

// class NegociosCliente extends StatefulWidget {
//   const NegociosCliente({super.key});

//   @override
//   State<NegociosCliente> createState() => _NegociosClienteState();
// }

// class _NegociosClienteState extends State<NegociosCliente> {
//   late List<Hoteles> hoteles = [];

//   @override
//   void initState() {
//     super.initState();

//     PeticionesNegocio.listNegociosClientes().then((value) {
//       setState(() {
//         hoteles = value;
//         // print(value.length);
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder<List<Hoteles>>(
//         future: PeticionesNegocio.listNegociosClientes(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           } else if (snapshot.hasError) {
//             return Center(
//               child: Text('Error: ${snapshot.error}'),
//             );
//           } else {
//             final List<Hoteles> hoteles = snapshot.data ?? [];

//             return SingleChildScrollView(
//               child: hoteles.isEmpty
//                   ? FirstHotel()
//                   : ListNegocios(hotelList: hoteles),
//             );
//           }
//         },
//       ),
//     );
//   }
// }

// class ListNegocios extends StatefulWidget {
//   final List<Hoteles> hotelList;
//   const ListNegocios({super.key, required this.hotelList});

//   @override
//   State<ListNegocios> createState() => _ListNegociosState();
// }

// class _ListNegociosState extends State<ListNegocios> {
//   late Hoteles? selectedHotel;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         color: const Color.fromARGB(255, 228, 228, 228),
//         width: MediaQuery.of(context).size.width,
//         height: MediaQuery.of(context).size.height - 60,
//         child: Column(
//           children: [
//             for (Hoteles hotel in widget.hotelList)
//               InkWell(
//                 onTap: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => ViewHotelCliente(
//                                 hotel: hotel,
//                               )));
//                 },
//                 child: Container(
//                   width: MediaQuery.of(context).size.width,
//                   margin: EdgeInsets.only(top: 5),
//                   color: Color.fromARGB(235, 255, 255, 255),
//                   child: Row(
//                     children: [
//                       Image.network(hotel.fotos[0].image,
//                         fit: BoxFit.cover,
//                         width: 150,
//                         height: 100,
//                       ),
//                       Container(
//                         margin: EdgeInsets.symmetric(horizontal: 10),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               "${hotel.nombre}",
//                               style: TextStyle(
//                                   fontSize: 15, fontWeight: FontWeight.w500),
//                             ),
//                             Container(
//                                 child: Text("S/30.05",
//                                     style: TextStyle(
//                                         fontSize: 20,
//                                         fontWeight: FontWeight.w500))),
//                             Container(
//                                 child: hotel.horaAbrir == "24 Horas"
//                                     ? Text(
//                                         "Servicio: ${hotel.horaAbrir}",
//                                         style: TextStyle(
//                                             fontSize: 12,
//                                             fontWeight: FontWeight.w500),
//                                       )
//                                     : Text(
//                                         "Servicio: ${hotel.horaAbrir} - ${hotel.horaCerrar} Horas",
//                                         style: TextStyle(
//                                             fontSize: 12,
//                                             fontWeight: FontWeight.w500),
//                                       )),
//                             Container(
//                               child: Text(
//                                 "Direccion: ${hotel.direccion}",
//                                 style: TextStyle(fontSize: 12),
//                               ),
//                             )
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
            
//           ],
//         ));
//   }
// }

// class FirstHotel extends StatelessWidget {
//   const FirstHotel({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: MediaQuery.of(context).size.width,
//       height: MediaQuery.of(context).size.height,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Text("Aun no existen registros"),
//         ],
//       ),
//     );
//   }
// }
// //