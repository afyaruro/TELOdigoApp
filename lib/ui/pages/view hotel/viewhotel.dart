import 'package:flutter/material.dart';
import 'package:telodigo/domain/models/habitaciones.dart';
import 'package:telodigo/domain/models/hoteles.dart';
import 'package:telodigo/ui/components/customcomponents/customcarrusel.dart';
import 'package:telodigo/ui/pages/Editar%20Establecimiento/editar.dart';

class ViewHotel extends StatefulWidget {
  final Hoteles hotel;
  const ViewHotel({super.key, required this.hotel});

  @override
  State<ViewHotel> createState() => _ViewHotelState();
}

class _ViewHotelState extends State<ViewHotel> {
  late double estrellas = 0;
  @override
  void initState() {
    super.initState();

    setState(() {
      estrellas = widget.hotel.calificacion;
    });
  }

  String calcularHoraReserva(Hoteles hotel) {
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
        return Icon(
          Icons.garage_rounded,
          color: Color.fromARGB(255, 105, 47, 170),
        );
      }
      return Container();
    }

/*  */
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 29, 7, 48),
        foregroundColor: Colors.white,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(color: Color.fromARGB(255, 29, 7, 48)),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Container(
            width: 400,
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
                              color: widget.hotel.estado == "por verificar"
                                  ? Color.fromARGB(255, 255, 115, 0)
                                  : widget.hotel.estado == "rechazado"
                                      ? const Color.fromARGB(255, 194, 18, 6)
                                      : widget.hotel.saldo > 5.0
                                          ? Color(0xFF00FF0A)
                                          : Colors.amber,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6))),
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        Text(
                          widget.hotel.estado == "por verificar"
                              ? "Por verificar"
                              : widget.hotel.estado == "rechazado"
                                  ? "Rechazado"
                                  : widget.hotel.saldo > 5.0
                                      ? "Publicado"
                                      : "Recargar",
                          style: const TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditarEstablecimiento(
                                        estrellas: estrellas,
                                        hotel: widget.hotel,
                                      )));
                        },
                        child: Text(
                          "Editar",
                          style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255)),
                        ))
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                ImageCarousel(
                  imageUrls: widget.hotel.fotos,
                ),

                // Container(width: 400, child: EstrellasPoint(estrellas)),
                Container(
                  width: 400,
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
                            color: Color.fromARGB(255, 255, 255, 255),
                          )),
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
                          : Text(calcularHoraReserva(widget.hotel),
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
                                  style: TextStyle(color: Colors.white))),
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
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
