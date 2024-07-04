// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:telodigo/data/service/PeticionesReservas.dart';
import 'package:telodigo/data/service/peticionesReporte.dart';
import 'package:telodigo/data/service/peticionnegocio.dart';
import 'package:telodigo/domain/models/hoteles.dart';
import 'package:telodigo/ui/pages/favoritos/hotelfavorite.dart';

class Favoritos extends StatefulWidget {
  const Favoritos({super.key});

  @override
  State<Favoritos> createState() => _FavoritosState();
}

class _FavoritosState extends State<Favoritos> {
  List<Hoteles> hoteles = [];

  @override
  void initState() {
    super.initState();

    PeticionesReserva.cancelarReservas(context);
    PeticionesReserva.calificar(context);
    PeticionesReserva.culminado(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Hoteles>>(
        future: PeticionesNegocio.listFavoritos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              color: Color.fromARGB(255, 29, 7, 48),
              child: Center(
                // child: CircularProgressIndicator(),
                child: Text(
                  "Cargando tus favoritos...",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            final List<Hoteles> hoteles = snapshot.data ?? [];

            return Container(
              color: Color.fromARGB(255, 29, 7, 48),
              child: hoteles.isEmpty
                  ? Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height - 60,
                      child: Center(
                        child: Text(
                          "No tienes Favoritos",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  : Column(
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        Text(
                          "Tus Favoritos",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 18),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                            height: MediaQuery.of(context).size.height - 160,
                            child: SingleChildScrollView(
                                child: ListHotel(hotelList: hoteles))),
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
  final List<Hoteles> hotelList;
  const ListHotel({super.key, required this.hotelList});

  @override
  State<ListHotel> createState() => _ListHotelState();
}

class _ListHotelState extends State<ListHotel> {
  late Hoteles? selectedHotel;

  String calcularHora(Hoteles hotel) {
    int hourAbrir = hotel.horaAbrir;
    int hourCerrar = hotel.horaCerrar;

    int minuteAbrir = hotel.minutoAbrir;

    int minuteCerrar = hotel.minutoCerrar;

    hourAbrir = hourAbrir % 24;
    hourCerrar = hourCerrar % 24;

    // Determine AM or PM based on hour
    // String amPm = hour > 12 ? "PM" : "AM";
    String amPm = hourAbrir >= 12 ? "PM" : "AM";
    String amPmFinal = hourCerrar >= 12 ? "PM" : "AM";

    // Adjust hour for 12-hour format
    if (hourAbrir >= 12) {
      hourAbrir -= 12;
    }

    if (hourCerrar >= 12) {
      hourCerrar -= 12;
    }

    // Format hour and minute with leading zeros
    String formattedHourAbrir = hourAbrir.toString().padLeft(2, '0');
    String formattedHourCerrar = hourCerrar.toString().padLeft(2, '0');
    String formattedMinuteAbrir = minuteAbrir.toString().padLeft(2, '0');
    String formattedMinuteCerrar = minuteCerrar.toString().padLeft(2, '0');

    // Construct and return the non-military time string
    return "${formattedHourAbrir}:${formattedMinuteAbrir} $amPm - ${formattedHourCerrar}:${formattedMinuteCerrar} $amPmFinal";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          for (Hoteles hotel in widget.hotelList)
            InkWell(
              onTap: () async {
                PeticionesReporte.reporteViewAdd(hotel.user);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewFavorito(
                              hotel: hotel,
                            )));
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(top: 5),
                color: Color(0xFF3B2151),
                child: Row(
                  children: [
                    Image.network(
                      hotel.fotos[0].image,
                      fit: BoxFit.cover,
                      width: 150,
                      height: 100,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 170,
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 140,
                                child: Text(
                                  "${hotel.nombre}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              IconButton(
                                  onPressed: () async {
                                    await PeticionesNegocio.EliminarFavorito(
                                        hotel.id, hotel.nombre);

                                    // Favorito favorito = Favorito(
                                    //     nombre: hotel.nombre,
                                    //     idHotel: hotel.id,
                                    //     idUser:
                                    //         controlleruser.usuario!.userName);

                                    setState(() {
                                      widget.hotelList.remove(hotel);
                                    });

                                    // controllernegocio.removeFavorito(favorito);

                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             const HomeUser(
                                    //               currentIndex: 3,
                                    //             )));
                                    // print("hola");
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ))
                            ],
                          ),
                          Container(
                              child: hotel.tipoHorario == "24 Horas"
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Horario de Atención:",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500)),
                                        Text(
                                          "24 Horas",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    )
                                  : Column(
                                      children: [
                                        Text("Horario de Atención:",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500)),
                                        Text(calcularHora(hotel),
                                            // "Servicio: ${hotel.horaAbrir.toString().padLeft(2, '0')}:${hotel.minutoAbrir.toString().padLeft(2, '0')} - ${hotel.horaCerrar.toString().padLeft(2, '0')}:${hotel.minutoCerrar.toString().padLeft(2, '0')}",
                                            style:
                                                TextStyle(color: Colors.white)),
                                      ],
                                    )),
                          Container(
                            child: Text(
                              "Direccion: ${hotel.direccion}",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Container(child: EstrellasPoint(hotel.calificacion)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget EstrellasPoint(double est) {
    if (est >= 1 && est < 1.5) {
      return Row(
        children: [
          Icon(
            Icons.star,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
          Icon(
            Icons.star_border,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
          Icon(
            Icons.star_border,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
          Icon(
            Icons.star_border,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
          Icon(
            Icons.star_border,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
        ],
      );
    } else if (est >= 1.5 && est < 2) {
      return Row(
        children: [
          Icon(
            Icons.star,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
          Icon(
            Icons.star_half,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
          Icon(
            Icons.star_border,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
          Icon(
            Icons.star_border,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
          Icon(
            Icons.star_border,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
        ],
      );
    } else if (est >= 2 && est < 2.5) {
      return Row(
        children: [
          Icon(
            Icons.star,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
          Icon(
            Icons.star,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
          Icon(
            Icons.star_border,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
          Icon(
            Icons.star_border,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
          Icon(
            Icons.star_border,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
        ],
      );
    } else if (est >= 2.5 && est < 3) {
      return Row(
        children: [
          Icon(
            Icons.star,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
          Icon(
            Icons.star,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
          Icon(
            Icons.star_half,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
          Icon(
            Icons.star_border,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
          Icon(
            Icons.star_border,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
        ],
      );
    } else if (est >= 3 && est < 3.5) {
      return Row(
        children: [
          Icon(
            Icons.star,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
          Icon(
            Icons.star,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
          Icon(
            Icons.star,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
          Icon(
            Icons.star_border,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
          Icon(
            Icons.star_border,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
        ],
      );
    } else if (est >= 3.5 && est < 4) {
      return Row(
        children: [
          Icon(
            Icons.star,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
          Icon(
            Icons.star,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
          Icon(
            Icons.star,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
          Icon(
            Icons.star_half,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
          Icon(
            Icons.star_border,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
        ],
      );
    } else if (est >= 4 && est < 4.5) {
      return Row(
        children: [
          Icon(
            Icons.star,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
          Icon(
            Icons.star,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
          Icon(
            Icons.star,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
          Icon(
            Icons.star,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
          Icon(
            Icons.star_border,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
        ],
      );
    } else if (est >= 4.5 && est < 5) {
      return Row(
        children: [
          Icon(
            Icons.star,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
          Icon(
            Icons.star,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
          Icon(
            Icons.star,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
          Icon(
            Icons.star,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
          Icon(
            Icons.star_half,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
        ],
      );
    } else if (est == 5) {
      return Row(
        children: [
          Icon(
            Icons.star,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
          Icon(
            Icons.star,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
          Icon(
            Icons.star,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
          Icon(
            Icons.star,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
          Icon(
            Icons.star,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
        ],
      );
    } else if (est >= 0.5 && est < 1) {
      return Row(
        children: [
          Icon(
            Icons.star_half,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
          Icon(
            Icons.star_border,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
          Icon(
            Icons.star_border,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
          Icon(
            Icons.star_border,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
          Icon(
            Icons.star_border,
            color: Color.fromARGB(255, 105, 47, 170),
          ),
        ],
      );
    }

    return Row(
      children: [
        Icon(
          Icons.star_border,
          color: Color.fromARGB(255, 105, 47, 170),
        ),
        Icon(
          Icons.star_border,
          color: Color.fromARGB(255, 105, 47, 170),
        ),
        Icon(
          Icons.star_border,
          color: Color.fromARGB(255, 105, 47, 170),
        ),
        Icon(
          Icons.star_border,
          color: Color.fromARGB(255, 105, 47, 170),
        ),
        Icon(
          Icons.star_border,
          color: Color.fromARGB(255, 105, 47, 170),
        ),
      ],
    );
  }
}
