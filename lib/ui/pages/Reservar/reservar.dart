import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:telodigo/data/controllers/usercontroller.dart';
import 'package:telodigo/data/service/PeticionesReservas.dart';
import 'package:telodigo/domain/models/hoteles.dart';
import 'package:telodigo/domain/models/reserva.dart';
import 'package:telodigo/ui/components/customcomponents/customalert.dart';
import 'package:telodigo/ui/pages/home/home.dart';

class ReservarHabitacion extends StatefulWidget {
  final Hoteles hotel;
  final String selectedHabitacion;
  final int selectedHorasHabitacion;
  final double selectedPrecioHabitacion;
  final int horaReserva;
  final int minutoReserva;

  const ReservarHabitacion(
      {super.key,
      required this.hotel,
      required this.selectedHabitacion,
      required this.selectedHorasHabitacion,
      required this.selectedPrecioHabitacion,
      required this.horaReserva,
      required this.minutoReserva});

  @override
  State<ReservarHabitacion> createState() => _ReservarHabitacionState();
}

class _ReservarHabitacionState extends State<ReservarHabitacion> {
  static final UserController controlleruser = Get.find();

  bool isEfectivo = false;
  bool isTarjeta = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // centerTitle: true,
        foregroundColor: Colors.white,
        title: Text(
          "Confirma y paga",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        backgroundColor: Color.fromARGB(255, 29, 7, 48),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Color.fromARGB(255, 29, 7, 48),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                width: 400,
                margin: EdgeInsets.only(right: 30, left: 30, top: 40),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.white),
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          widget.hotel.fotos[0].image,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                            width: 130,
                            child: Text(
                              "${widget.hotel.nombre}",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            )),
                        Container(
                            width: 130,
                            child: Text(
                              "${widget.hotel.direccion}",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300),
                            ))
                      ],
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                width: 400,
                margin: EdgeInsets.only(right: 30, left: 30, top: 20),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.white),
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 40,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hora",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "${widget.horaReserva.toString().padLeft(2, '0')}:${widget.minutoReserva.toString().padLeft(2, '0')} - ${(widget.horaReserva + widget.selectedHorasHabitacion).toString().padLeft(2, '0')}:${widget.minutoReserva.toString().padLeft(2, '0')}",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Habitacion",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "${widget.selectedHabitacion} - ${widget.selectedHorasHabitacion} h",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                width: 400,
                margin: EdgeInsets.only(right: 30, left: 30, top: 20),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.white),
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Información del precio",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "TOTAL: ",
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          "S/${widget.selectedPrecioHabitacion}",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                width: 400,
                margin: EdgeInsets.only(right: 30, left: 30, top: 20),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.white),
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Selecciona metodó de pago",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                    Container(
                      child: Column(
                        children: [
                          for (var metodoP in widget.hotel.metodosPago)
                            metodoP == "Tarjeta de Credito"
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Tarjeta de credito",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      Checkbox(
                                        value: isTarjeta,
                                        onChanged: (newBool) {
                                          setState(() {
                                            isTarjeta = newBool!;
                                            isEfectivo = false;
                                          });
                                        },
                                        activeColor: const Color.fromARGB(
                                            255, 190, 160, 209),
                                        checkColor: Colors.white,
                                        hoverColor:
                                            Color.fromARGB(255, 156, 110, 187),
                                        shape: CircleBorder(),
                                      ),
                                    ],
                                  )
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Efectivo",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      Checkbox(
                                        value: isEfectivo,
                                        onChanged: (newBool) {
                                          setState(() {
                                            isEfectivo = newBool!;
                                            isTarjeta = false;
                                          });
                                        },
                                        activeColor: const Color.fromARGB(
                                            255, 190, 160, 209),
                                        checkColor: Colors.white,
                                        hoverColor:
                                            Color.fromARGB(255, 156, 110, 187),
                                        shape: CircleBorder(),
                                      ),
                                    ],
                                  )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (isEfectivo) {
                      final CollectionReference collection =
                          FirebaseFirestore.instance.collection("Reservas");
                      var reservasCount = (await collection.get()).size;

                      var codigo = generarCodigo();
                      Reserva reserva = Reserva(
                          key: reservasCount + 1,
                          precio: widget.selectedPrecioHabitacion,
                          idUserHotel: widget.hotel.user,
                          metodoPago: "Efectivo",
                          codigo: codigo,
                          estado: "En espera",
                          nombreNegocio: widget.hotel.nombre,
                          direccion: widget.hotel.direccion,
                          longitud: widget.hotel.longitud,
                          latitud: widget.hotel.latitud,
                          fotoPrincipal: widget.hotel.fotos[0].image,
                          tiempoReserva: widget.selectedHorasHabitacion,
                          habitacion: widget.selectedHabitacion,
                          horaInicioReserva: widget.horaReserva,
                          horaFinalReserva: widget.horaReserva +
                              widget.selectedHorasHabitacion,
                          minutoInicioReserva: widget.minutoReserva,
                          minutoFinalReserva: widget.minutoReserva,
                          idHotel: widget.hotel.id,
                          idUser: controlleruser.usuario!.userName);

                      var resp = await PeticionesReserva.RegistrarReserva(
                          reserva, context);

                      if (resp == "create") {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Center(
                                  child: Text(
                                "RESERVA CONFIRMADA",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              )),
                              content: Container(
                                height: 140,
                                child: Column(
                                  children: [
                                    Text(
                                        "Tu reserva ha sido creada con exito, tu codigo es $codigo, recuerda que te lo pediran en el establecimiento"),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    ElevatedButton(
                                      child: Text('Ir a mis reservas'),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            CupertinoPageRoute(
                                                builder: (context) =>
                                                    const HomeUser(
                                                      currentIndex: 2,
                                                    )));
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CustomAlert(
                              title: "Presentamos Errores",
                              text:
                                  "No hemos podido crear tu reserva por favor intenta mas tarde",
                            );
                          },
                        );
                      }
                    } else if (isTarjeta) {
//aqui va lo de la tarjeta de credito
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const CustomAlert(
                            title: "Selecciona tu metodo de pago",
                            text: "Aun no has elegido un metodo de pagos",
                          );
                        },
                      );
                    }
                  },
                  child: Text("Reservar"))
            ],
          ),
        ),
      ),
    );
  }

  String generarCodigo() {
    var random = Random();
    int codigo = random.nextInt(900000) + 100000;
    return codigo.toString();
  }
}
