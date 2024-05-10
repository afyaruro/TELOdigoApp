import 'package:flutter/material.dart';
import 'package:telodigo/data/service/PeticionesReservas.dart';
import 'package:telodigo/domain/models/reserva.dart';
import 'package:telodigo/ui/pages/Reservar/verificarcodigo.dart';

class ListReservasUserAnfitrion extends StatefulWidget {
  const ListReservasUserAnfitrion({super.key});

  @override
  State<ListReservasUserAnfitrion> createState() => _ListReservasUserAnfitrionState();
}

class _ListReservasUserAnfitrionState extends State<ListReservasUserAnfitrion> {
  // List<Hoteles> hoteles = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Reserva>>(
        future: 
                 PeticionesReserva.listReservasAnfitrion(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              color: Color.fromARGB(255, 29, 7, 48),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            final List<Reserva> reservas = snapshot.data ?? [];

            return Container(
              color: Color.fromARGB(255, 29, 7, 48),
              child: reservas.isEmpty
                  ? Column(
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                            height: MediaQuery.of(context).size.height - 204,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height - 60,
                              child: Center(
                                child: Text(
                                  "No tienes Reservas",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ))
                      ],
                    )
                  : Column(
                      children: [
                        SizedBox(
                          height: 50,
                        ),

                        // barra de busqueda
                        // Text(
                        //   "Tus Reservas",
                        //   style: TextStyle(
                        //       color: Colors.white,
                        //       fontWeight: FontWeight.w500,
                        //       fontSize: 18),
                        // ),
                        
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                            height: MediaQuery.of(context).size.height - 204,
                            child: SingleChildScrollView(
                                child: ListHotel(reservaList: reservas))),
                      ],
                    ),
            );
          }
        },
      ),
    );
  }
}

class ListHotel extends StatefulWidget {
  final List<Reserva> reservaList;
  const ListHotel({super.key, required this.reservaList});

  @override
  State<ListHotel> createState() => _ListHotelState();
}

class _ListHotelState extends State<ListHotel> {
  late Reserva? selectedReserva;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          for (Reserva reserva in widget.reservaList)
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VerificarCodigo(reserva: reserva,)));
              },
              child: Container(
                width: 400,
                margin: EdgeInsets.only(right: 30, left: 30, top: 10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.white),
                    borderRadius: BorderRadius.circular(20)),
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
                                  color: reserva.metodoPago != "Efectivo"
                                      ? Color(0xFF00FF0A)
                                      
                                          : const Color.fromARGB(
                                              255, 255, 7, 7),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6))),
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            Text(
                              reserva.metodoPago != "Efectivo"
                                  ? "Pago"
                                  :  "No ha Pagado",
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 2),
                            borderRadius: BorderRadius.circular(75),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(75),
                            child: Image.network(
                              reserva.fotoPrincipal,
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          children: [
                            Container(
                                width: 170,
                                child: Text(
                                  "${reserva.nombreNegocio}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                                width: 170,
                                child: Text(
                                  "Reservado por:",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                )),
                            Container(
                                width: 170,
                                child: Text(
                                  "${reserva.idUser}",
                                  style: TextStyle(color: Colors.white),
                                ))
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }
}
