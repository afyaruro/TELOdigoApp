// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telodigo/data/controllers/usercontroller.dart';
import 'package:telodigo/data/service/peticionnegocio.dart';
import 'package:telodigo/domain/models/hoteles.dart';
import 'package:telodigo/ui/components/customcomponents/custombuttonborderradius.dart';
import 'package:telodigo/ui/pages/Habitaciones/canthabitaciones.dart';
import 'package:telodigo/ui/pages/administrador/homeAdmin.dart';
import 'package:telodigo/ui/pages/crear%20anuncio/crearanuncioview1.dart';
import 'package:telodigo/ui/pages/view%20hotel/viewhotel.dart';

class AnunciosAnfitrion extends StatefulWidget {
  const AnunciosAnfitrion({super.key});

  @override
  State<AnunciosAnfitrion> createState() => _AnunciosAnfitrionState();
}

class _AnunciosAnfitrionState extends State<AnunciosAnfitrion> {
  final UserController controlleruser = Get.find();
  String user = "";

  @override
  void initState() {
    super.initState();
    user = controlleruser.usuario!.userName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Hoteles>>(
        future: PeticionesNegocio.listNegocios(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              color: Color.fromARGB(255, 29, 7, 48),
              child: Center(
                // child: CircularProgressIndicator(),
                child: Text(
                  "Cargando tus negocios...",
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
              child: SingleChildScrollView(
                child: hoteles.isEmpty
                    ? FirstHotel(
                        user: user,
                      )
                    : ListHotel(hotelList: hoteles),
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
  final UserController controlleruser = Get.find();
  String user = "";

  @override
  void initState() {
    super.initState();
    user = controlleruser.usuario!.userName;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: user == "Admin"
            ? MediaQuery.of(context).size.height
            : MediaQuery.of(context).size.height - 60,
        child: Column(
          children: [
            user == "Admin"
                ? Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(
                      top: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomeAdmin(
                                          currentIndex: 4,
                                        )),
                                (Route<dynamic> route) => false,
                              );
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            )),
                      ],
                    ),
                  )
                : Container(),
            Container(
              width: 400,
              padding: user == "Admin"
                  ? EdgeInsets.only(top: 0, right: 20, left: 20, bottom: 10)
                  : EdgeInsets.only(top: 50, right: 20, left: 20, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    user == "Admin" ? "Repositorio de TELOS" : "Tus Anuncios",
                    style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 16, 152, 231)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CrearAnuncioView1()));
                    },
                    child: Text(
                      "Crear",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: user == "Admin"
                  ? MediaQuery.of(context).size.height - 126
                  : MediaQuery.of(context).size.height - 170,
              child: ListView.builder(
                padding: EdgeInsets.only(top: 10, bottom: 20),
                itemCount: widget.hotelList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                      padding: const EdgeInsets.only(
                        right: 30,
                        left: 30,
                        top: 10,
                      ),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color.fromARGB(31, 141, 139, 139)),
                        width: 400,
                        // height: 250,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                                          color: widget.hotelList[index]
                                                      .estado ==
                                                  "por verificar"
                                              ? Color.fromARGB(255, 255, 115, 0)
                                              : widget.hotelList[index]
                                                          .estado ==
                                                      "rechazado"
                                                  ? const Color.fromARGB(
                                                      255, 194, 18, 6)
                                                  : widget.hotelList[index]
                                                              .saldo >
                                                          5.0
                                                      ? Color(0xFF00FF0A)
                                                      : Colors.amber,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(6))),
                                    ),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    Text(
                                      widget.hotelList[index].estado ==
                                              "por verificar"
                                          ? "Por verificar"
                                          : widget.hotelList[index].estado ==
                                                  "rechazado"
                                              ? "Rechazado"
                                              : widget.hotelList[index].saldo >
                                                      5.0
                                                  ? "Publicado"
                                                  : "Recargar",
                                      style: const TextStyle(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "S/ ${widget.hotelList[index].saldo.toStringAsFixed(2)}",
                                      style: const TextStyle(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    const Icon(
                                      Icons.monetization_on_outlined,
                                      color: Color.fromARGB(255, 88, 39, 223),
                                      size: 30,
                                    )
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ClipRRect(
                                  child: Image.network(
                                    widget.hotelList[index].fotos[0].image,
                                    fit: BoxFit.cover,
                                    width: 100,
                                    height: 100,
                                  ),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                Container(
                                  width: 140,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        widget.hotelList[index].nombre,
                                        style: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: double.infinity,
                                        child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ViewHotel(
                                                            hotel: widget
                                                                    .hotelList[
                                                                index],
                                                          )));
                                            },
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                              ),
                                              backgroundColor:
                                                  const Color.fromARGB(
                                                      255, 255, 255, 255),
                                            ),
                                            child: Text("Ver más")),
                                      ),
                                      SizedBox(
                                        width: double.infinity,
                                        child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      CantHabitaciones(
                                                    hotel:
                                                        widget.hotelList[index],
                                                  ),
                                                ),
                                              );
                                            },
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                              ),
                                              backgroundColor:
                                                  const Color.fromARGB(
                                                      255, 255, 255, 255),
                                            ),
                                            child: Text("Habitaciones")),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ));
                },
              ),
            ),
          ],
        ));
  }
}

class FirstHotel extends StatelessWidget {
  final String user;

  FirstHotel({
    super.key,
    this.user = "",
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          user == "Admin"
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(
                    top: 20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          )),
                    ],
                  ),
                )
              : Container(),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.50 - 150,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                user == "Admin"
                    ? "Comienza a registrar tu repositorio de TELOS"
                    : "¿No has registrado aún tu negocio?",
                style: TextStyle(color: Colors.white),
              ),
              Container(
                  width: 200,
                  margin: EdgeInsets.only(top: 15),
                  child: CustomButtonsRadius(Color.fromARGB(255, 13, 161, 219),
                      Colors.white, "¡Registralo Aquí!", false, () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CrearAnuncioView1()));
                  }))
            ],
          ),
        ],
      ),
    );
  }
}
//