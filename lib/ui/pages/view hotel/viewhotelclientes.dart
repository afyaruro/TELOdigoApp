import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telodigo/data/controllers/usercontroller.dart';
import 'package:telodigo/data/service/peticionnegocio.dart';
import 'package:telodigo/domain/models/habitaciones.dart';
import 'package:telodigo/domain/models/hoteles.dart';
import 'package:telodigo/ui/components/customcomponents/customcarrusel.dart';
import 'package:telodigo/ui/pages/Reservar/consultardiponibilidad.dart';
import 'package:telodigo/ui/pages/datos%20generales/datos_generales.dart';

class ViewHotelCliente extends StatefulWidget {
  final Hoteles hotel;
  final bool estadoFavorito;
  const ViewHotelCliente(
      {super.key, required this.hotel, required this.estadoFavorito});

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

    estadoFavorito = widget.estadoFavorito;

    setState(() {
      estrellas = widget.hotel.calificacion;
    });
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
    Widget listServicios(String servicio) {
      if (servicio == "WIFI") {
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
          child: const Row(
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
                        Container(
                          width: 100,
                          child: Row(
                            children: [
                              Text(
                                estrellas.toStringAsFixed(1),
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold),
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.white,
                                size: 10,
                              )
                            ],
                          ),
                        ),
                        IconButton(
                            onPressed: () async {
                              if (estadoFavorito) {
                                setState(() {
                                  estadoFavorito = false;
                                });
                                await PeticionesNegocio.eliminarFavorito(
                                    widget.hotel.id);
                              } else {
                                var favorito = <String, dynamic>{
                                  "nombre": widget.hotel.nombre,
                                  "idHotel": widget.hotel.id,
                                  "idUser": controlleruser.usuario!.userName,
                                };

                                setState(() {
                                  estadoFavorito = true;
                                });

                                PeticionesNegocio.nuevoFavorito(
                                    favorito, context);
                              }
                            },
                            icon: estadoFavorito
                                ? Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  )
                                : Icon(
                                    Icons.favorite_border,
                                    color: Color.fromARGB(255, 255, 255, 255),
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
                      widget.hotel.tipoHorario == "24 Horas"
                          ? Text(
                              "24 Horas",
                              style: TextStyle(color: Colors.white),
                            )
                          : Text(calcularHora(widget.hotel),
                              // "${widget.hotel.horaAbrir.toString().padLeft(2, '0')}:${widget.hotel.minutoAbrir.toString().padLeft(2, '0')} - ${widget.hotel.horaCerrar.toString().padLeft(2, '0')}:${widget.hotel.minutoCerrar.toString().padLeft(2, '0')}",
                              style: TextStyle(color: Colors.white))
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

                widget.hotel.servicios.isEmpty
                    ? Text(
                        "No hay servicios",
                        style: TextStyle(color: Colors.white),
                      )
                    : Row(
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
                      if (widget.hotel.user == "Admin") {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                "¡AÚN ESTAMOS CONVENCIENDO A ESTE TELO!",
                                style: TextStyle(fontSize: 15),
                                textAlign: TextAlign.center,
                              ),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    child: Text(
                                        style: TextStyle(fontSize: 12),
                                        "Este establecimiento no se encuentra disponible por el momento."),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                      width: double.infinity,
                                      child: Text(
                                          "Disculpe por las molestias :(")),
                                ],
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: Text("Aceptar"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      } else if (controlleruser.usuario!.nombres == "" ||
                          controlleruser.usuario!.apellidos == "") {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                "Configura tu Nombre",
                                style: TextStyle(fontSize: 15),
                              ),
                              content:
                                  Text("Debes configurar tu nombre y apellido"),
                              actions: <Widget>[
                                TextButton(
                                  child: Text("Configurar"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Datos_Generales()));
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ConsultarDisponibilidad(
                                      hotel: widget.hotel,
                                    )));
                      }
                    },
                    child: Text("Ver Precios")),
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
