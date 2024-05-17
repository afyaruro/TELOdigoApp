import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telodigo/data/controllers/usercontroller.dart';
import 'package:telodigo/data/service/peticionnegocio.dart';
import 'package:telodigo/domain/models/habitaciones.dart';
import 'package:telodigo/domain/models/hoteles.dart';
import 'package:telodigo/ui/components/customcomponents/customcarrusel.dart';
import 'package:telodigo/ui/pages/Reservar/consultardiponibilidad.dart';

class ViewHotelCliente extends StatefulWidget {
  final Hoteles hotel;
  const ViewHotelCliente({super.key, required this.hotel});

  @override
  State<ViewHotelCliente> createState() => _ViewHotelClienteState();
}

class _ViewHotelClienteState extends State<ViewHotelCliente> {
  late double estrellas = 0;
  bool estadoFavorito = false;
  late Hoteles favoritoa;
  List<Hoteles> favoritos = [];

  static final UserController controlleruser = Get.find();

  @override
  void initState() {
    super.initState();

    PeticionesNegocio.listFavoritos().then((value) {
      setState(() {
        favoritos = value;

        for (var favorito in favoritos) {
          print("hola hotel ${widget.hotel.id} favorito ${favorito.id}");

          if (widget.hotel.id == favorito.id) {
            estadoFavorito = true;
            // print(favoritoa.id);
          }
        }
      });
    });

    setState(() {
      estrellas = widget.hotel.calificacion;

      // print("$estadoFavorito");
    });
  }

  bool IsFavorite() {
    for (var favorito in favoritos) {
      print("hola hotel ${widget.hotel.id} favorito ${favorito.id}");

      if (widget.hotel.id == favorito.id) {
        favoritoa = favorito;
        print(favoritoa.id);
        return true;
      }
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
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

    Widget listServicios(String servicio) {
      if (servicio == "WIFI") {
        // return Container(width: 30, child: Image.asset("assets/wifi.png"));
        return Icon(
          Icons.network_wifi,
          color: Color.fromARGB(255, 105, 47, 170),
        );
      } else if (servicio == "Agua Caliente")
        return Icon(
          Icons.bathtub,
          color: Color.fromARGB(255, 105, 47, 170),
        );
      else if (servicio == "Netflix") {
        return Container(width: 40, child: Image.asset("assets/Netflix.png"));
      } else if (servicio == "Sillon Tántrico") {
        // return Container(width: 30, child: Image.asset("assets/sofa.png"));
        return Icon(
          Icons.chair,
          color: Color.fromARGB(255, 105, 47, 170),
        );
      } else if (servicio == "TV") {
        return Icon(
          Icons.tv,
          color: Color.fromARGB(255, 105, 47, 170),
        );
      } else if (servicio == "Cochera") {
        // return Container(width: 23, child: Image.asset("assets/garage.png"));
        return Icon(
          Icons.garage,
          color: Color.fromARGB(255, 105, 47, 170),
        );
      }
      return Container();
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: Color.fromARGB(255, 29, 7, 48),
        title: Container(
          width: 200,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "TELO",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              ),
              Text(
                "digo",
                style: TextStyle(
                    color: Color.fromARGB(255, 129, 133, 190),
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(color: Color.fromARGB(255, 29, 7, 48)),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Container(
            width: 400,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                //galeria
                ImageCarousel(
                  imageUrls: widget.hotel.fotos,
                ),

                //calificacion fija por ahora debo cambiar la calificacion en la variable
                Container(
                    width: 400,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        EstrellasPoint(estrellas),
                        IconButton(
                            onPressed: () async {
                              if (estadoFavorito) {
                                IsFavorite();

                                // print("hola soy false");

                                // controllerNegocio.removeFavorito(favoritoa);
                                await PeticionesNegocio.EliminarFavorito(
                                    favoritoa.id, favoritoa.nombre);

                                // await PeticionesNegocio.listFavoritos();

                                // print(favoritoa);
                                setState(() {
                                  estadoFavorito = false;
                                });

                                // print("Hola");
                              } else {
                                var favorito = <String, dynamic>{
                                  "nombre": widget.hotel.nombre,
                                  "idHotel": widget.hotel.id,
                                  "idUser": controlleruser.usuario!.userName,
                                };

                                PeticionesNegocio.nuevoFavorito(
                                    favorito, context);

                                // await PeticionesNegocio.listFavoritos();

                                setState(() {
                                  estadoFavorito = true;
                                });
                              }
                            },
                            icon: estadoFavorito
                                ? Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  )
                                : Icon(
                                    Icons.favorite_border,
                                    color: Color.fromARGB(255, 105, 47, 170),
                                  ))
                      ],
                    )),
                Container(
                  width: 400,
                  child: Text(
                    widget.hotel.nombre,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                ),

                Container(
                  width: 400,
                  child: Text(
                    widget.hotel.direccion,
                    style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 12,
                        fontWeight: FontWeight.w300),
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top: 10),
                  width: 400,
                  child: Text(
                    "Horario de atención",
                    style: const TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),

                Container(
                  width: 400,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Todos los dias",
                          style: const TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255))),
                      Container(
                        width: 1,
                        height: 20,
                        color: const Color.fromARGB(221, 255, 255, 255),
                      ),
                      widget.hotel.horaAbrir == "24 Horas"
                          ? Text("24 Horas",
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255)))
                          : Text(
                              "${widget.hotel.horaAbrir} - ${widget.hotel.horaCerrar}",
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255)))
                    ],
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top: 10),
                  width: 400,
                  child: Text(
                    "Tipo de Habitaciones",
                    style: const TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),

                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      for (Habitaciones habitacion in widget.hotel.habitaciones)
                        Container(
                          width: 130,
                          child: Center(
                              child: Text("${habitacion.nombre}",
                                  style: const TextStyle(
                                      color:
                                          Color.fromARGB(255, 255, 255, 255)))),
                        ),
                    ],
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 20),
                  width: 400,
                  child: Text(
                    "Servicios",
                    style: const TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (var servicio in widget.hotel.servicios)
                      Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          listServicios(servicio),
                          SizedBox(
                            width: 10,
                          )
                        ],
                      ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ConsultarDisponibilidad(
                                    hotel: widget.hotel,
                                  )));
                    },
                    child: Text("Comprobar Disponibilidad")),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
