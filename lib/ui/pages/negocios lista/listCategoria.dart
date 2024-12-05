// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:telodigo/data/service/PeticionesReservas.dart';
import 'package:telodigo/data/service/peticionesReporte.dart';
import 'package:telodigo/data/service/peticionnegocio.dart';
import 'package:telodigo/domain/models/hoteles.dart';
import 'package:telodigo/ui/pages/home/home.dart';
import 'package:telodigo/ui/pages/view%20hotel/viewhotelclientes.dart';

class NegociosCategory extends StatefulWidget {
  final String categoryFiltro;
  final String textFiltro;
  const NegociosCategory({
    super.key,
    required this.categoryFiltro,
    required this.textFiltro,
  });

  @override
  State<NegociosCategory> createState() => _NegociosCategoryState();
}

class _NegociosCategoryState extends State<NegociosCategory> {
  late List<Hoteles> hoteles = [];
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.textFiltro);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Container(
              width: 150,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "TELO",
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "digo",
                    style: TextStyle(
                        fontSize: 25,
                        color: Color.fromARGB(255, 129, 133, 190),
                        fontWeight: FontWeight.w600),
                  ),
                ],
              )),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HomeUser(
                            currentIndex: 0,
                          )));
            },
          ),
          foregroundColor: Colors.white,
          backgroundColor: Color(0xFF3B2151)),
      backgroundColor: Color(0xFF3B2151),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Color(0xFF1F1F1F),
                  // border: Border.all(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(50)),
              width: 400,
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      onSubmitted: (value) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NegociosCategory(
                                      textFiltro: controller.text,
                                      categoryFiltro: widget.categoryFiltro,
                                    )));
                      },
                      controller: controller,
                      style: TextStyle(color: Color(0xFFBFB8E1)),
                      decoration: InputDecoration(
                        hintStyle: TextStyle(
                            color: Color.fromARGB(255, 247, 247, 247),
                            fontWeight: FontWeight.w500),
                        hintText: 'Busca tu TELO',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide.none,
                          gapPadding: 10,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 106, 81, 153),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NegociosCategory(
                                      textFiltro: controller.text,
                                      categoryFiltro: widget.categoryFiltro,
                                    )));
                      },
                      icon: Icon(Icons.search, color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
            FutureBuilder<List<Hoteles>>(
              future: PeticionesNegocio.listNegociosPrincipal(
                  widget.categoryFiltro, widget.textFiltro),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    // child: CircularProgressIndicator(), // Muestra la barra de carga
                    child: Text(
                      "Cargando Establecimientos...",
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else {
                  final List<Hoteles> hoteles = snapshot.data ?? [];

                  return hoteles.isEmpty
                      ? FirstHotel()
                      : ListNegocios(
                          hotelList: hoteles,
                        );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ListNegocios extends StatefulWidget {
  final List<Hoteles> hotelList;

  const ListNegocios({
    super.key,
    required this.hotelList,
  });

  @override
  State<ListNegocios> createState() => _ListNegociosState();
}

class _ListNegociosState extends State<ListNegocios> {
  late Hoteles? selectedHotel;

  @override
  void initState() {
    super.initState();

    // PeticionesReserva.actualizarCulminado(context, "user");
    PeticionesReserva.cancelarReservas(context);
    PeticionesReserva.calificar(context);
    PeticionesReserva.culminado(context);
  }

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
        color: Color(0xFF3B2151),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            for (Hoteles hotel in widget.hotelList)
              InkWell(
                onTap: () async {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              child: CircularProgressIndicator(),
                              width: 30,
                              height: 30,
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Text("Cargando Negocio..."),
                          ],
                        ),
                      );
                    },
                  );
                  PeticionesReporte.reporteViewAdd(hotel.user);
                  bool isFavorito =
                      await PeticionesNegocio.isFavorito(hotel.id);
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewHotelCliente(
                                estadoFavorito: isFavorito,
                                hotel: hotel,
                              )));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(top: 5),
                  color: Color(0xFF20102F),
                  child: Row(
                    children: [
                      Image.network(
                        hotel.fotos[0].image,
                        fit: BoxFit.cover,
                        width: 150,
                        height: 100,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width - 170,
                              child: Text(
                                overflow: TextOverflow.ellipsis,
                                "${hotel.nombre}",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromARGB(255, 159, 131, 204)),
                              ),
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width - 170,
                                child: Text(
                                  overflow: TextOverflow.ellipsis,
                                  "S/${hotel.habitaciones[0].precios[0].precio}",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color:
                                          Color.fromARGB(255, 255, 255, 255)),
                                )),
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
                                            style:
                                                TextStyle(color: Colors.white),
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
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ],
                                      )),
                            Container(
                              width: MediaQuery.of(context).size.width - 170,
                              child: Text(
                                overflow: TextOverflow.ellipsis,
                                "Direccion: ${hotel.direccion}",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Color.fromARGB(255, 255, 255, 255)),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
          ],
        ));
  }
}

class FirstHotel extends StatelessWidget {
  const FirstHotel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "No se encontraron establecimientos",
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(
            height: 150,
          )
        ],
      ),
    );
  }
}
//