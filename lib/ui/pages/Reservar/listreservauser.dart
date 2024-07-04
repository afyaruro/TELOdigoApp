// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:telodigo/data/service/PeticionesReservas.dart';
import 'package:telodigo/domain/models/reserva.dart';
import 'package:telodigo/ui/pages/Reservar/viewreserva.dart';
import 'package:telodigo/ui/pages/chats/viewchat.dart';

class ListReservasUser extends StatefulWidget {
  const ListReservasUser({super.key});

  @override
  State<ListReservasUser> createState() => _ListReservasUserState();
}

class _ListReservasUserState extends State<ListReservasUser> {
  bool selectedEspera = true;
  bool selectedHabitacion = false;
  bool selectedCulminado = false;
  bool selectedCanceladas = false;

  @override
  void initState() {
    super.initState();

    PeticionesReserva.cancelarReservas(context);
    PeticionesReserva.calificar(context);
    PeticionesReserva.culminado(context);

    // setState(() async {
    //   await PeticionesReserva.cancelarReservas(context);
    //   await PeticionesReserva.culminado(context);
    //   await PeticionesReserva.calificar(context);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Reserva>>(
        future: !selectedEspera &&
                !selectedHabitacion &&
                !selectedCulminado &&
                !selectedCanceladas
            ? PeticionesReserva.listReservas(context)
            : selectedEspera
                ? PeticionesReserva.listReservasFiltro("En espera", context)
                : selectedHabitacion
                    ? PeticionesReserva.listReservasFiltro(
                        "En la Habitacion", context)
                    : selectedCulminado
                        ? PeticionesReserva.listReservasFiltro(
                            "Culminado", context)
                        : PeticionesReserva.listReservasFiltro(
                            "Cancelada", context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              color: Color.fromARGB(255, 29, 7, 48),
              child: Center(
                // child: CircularProgressIndicator(),
                child: Text(
                  "Cargando tus reservas...",
                  style: TextStyle(color: Colors.white),
                ),
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
                        Text(
                          "Tus Reservas",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 18),
                        ),
                        Container(
                          width: 400,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                        value: selectedEspera,
                                        onChanged: (estado) {
                                          setState(() {
                                            selectedEspera = estado!;
                                            selectedCulminado = false;
                                            selectedHabitacion = false;
                                            selectedCanceladas = false;
                                          });
                                        }),
                                    Text(
                                      "En espera",
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Checkbox(
                                        value: selectedHabitacion,
                                        onChanged: (estado) {
                                          setState(() {
                                            selectedHabitacion = estado!;
                                            selectedEspera = false;
                                            selectedCulminado = false;
                                            selectedCanceladas = false;
                                          });
                                        }),
                                    Text(
                                      "En la Habitación",
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Checkbox(
                                        value: selectedCulminado,
                                        onChanged: (estado) {
                                          setState(() {
                                            selectedCulminado = estado!;
                                            selectedEspera = false;
                                            selectedHabitacion = false;
                                            selectedCanceladas = false;
                                          });
                                        }),
                                    Text(
                                      "Culminado",
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Checkbox(
                                        value: selectedCanceladas,
                                        onChanged: (estado) {
                                          setState(() {
                                            selectedCanceladas = estado!;
                                            selectedEspera = false;
                                            selectedHabitacion = false;
                                            selectedCulminado = false;
                                          });
                                        }),
                                    Text(
                                      "Canceladas",
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  width: 20,
                                )
                              ],
                            ),
                          ),
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
                        Text(
                          "Tus Reservas",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 18),
                        ),
                        Container(
                          width: 400,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                        value: selectedEspera,
                                        onChanged: (estado) {
                                          setState(() {
                                            selectedEspera = estado!;
                                            selectedCulminado = false;
                                            selectedHabitacion = false;
                                            selectedCanceladas = false;
                                          });
                                        }),
                                    Text(
                                      "En espera",
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Checkbox(
                                        value: selectedHabitacion,
                                        onChanged: (estado) {
                                          setState(() {
                                            selectedHabitacion = estado!;
                                            selectedEspera = false;
                                            selectedCulminado = false;
                                            selectedCanceladas = false;
                                          });
                                        }),
                                    Text(
                                      "En la Habitación",
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Checkbox(
                                        value: selectedCulminado,
                                        onChanged: (estado) {
                                          setState(() {
                                            selectedCulminado = estado!;
                                            selectedEspera = false;
                                            selectedHabitacion = false;
                                            selectedCanceladas = false;
                                          });
                                        }),
                                    Text(
                                      "Culminado",
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Checkbox(
                                        value: selectedCanceladas,
                                        onChanged: (estado) {
                                          setState(() {
                                            selectedCanceladas = estado!;
                                            selectedEspera = false;
                                            selectedCulminado = false;
                                            selectedHabitacion = false;
                                          });
                                        }),
                                    Text(
                                      "Canceladas",
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  width: 20,
                                )
                              ],
                            ),
                          ),
                        ),
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
                        builder: (context) => ViewReserva(
                              reserva: reserva,
                            )));
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
                                  color: reserva.estado == "En espera"
                                      ? Color(0xFF00FF0A)
                                      : reserva.estado == "En la Habitacion"
                                          ? Colors.amberAccent
                                          : const Color.fromARGB(
                                              255, 255, 7, 7),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6))),
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            Text(
                              reserva.estado == "En espera"
                                  ? "En espera"
                                  : reserva.estado == "En la Habitacion"
                                      ? "En la Habitación"
                                      : reserva.estado == "Culminado"
                                          ? "Culminado"
                                          : "Cancelada por la app",
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ViewChat(
                                            reserva: reserva,
                                          )));
                            },
                            child: Row(
                              children: [
                                Text("Chat"),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.message,
                                  size: 20,
                                ),
                              ],
                            ))
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
                                  "Habitación:",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                )),
                            Container(
                                width: 170,
                                child: Text(
                                  "${reserva.habitacion} - ${reserva.tiempoReserva} h",
                                  style: TextStyle(color: Colors.white),
                                )),
                          ],
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Código: ${reserva.codigo}",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
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
