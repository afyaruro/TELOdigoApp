import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telodigo/data/controllers/usercontroller.dart';
import 'package:telodigo/data/service/PeticionesReservas.dart';
import 'package:telodigo/data/service/peticionesReporte.dart';
import 'package:telodigo/domain/models/hoteles.dart';
import 'package:telodigo/domain/models/reserva.dart';
import 'package:telodigo/ui/components/customcomponents/customalert.dart';
import 'package:telodigo/ui/pages/home/home.dart';
import 'package:telodigo/ui/pages/opciones%20anfitrion/configure_card.dart';

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
  bool isYape = false;
  bool isPlin = false;
  bool isButtonDisabled = false;

  @override
  void initState() {
    super.initState();
  }

  String calcularHoraReserva(int espera) {
    int hour = DateTime.now().hour;
    int hourFinal = DateTime.now().hour + espera;

    int minute = DateTime.now().minute;

    hour = hour % 24;
    hourFinal = hourFinal % 24;

    // Determine AM or PM based on hour
    // String amPm = hour > 12 ? "PM" : "AM";
    String amPm = hour >= 12 ? "PM" : "AM";
    String amPmFinal = hourFinal >= 12 ? "PM" : "AM";

    // Adjust hour for 12-hour format
    if (hour >= 12) {
      hour -= 12;
    }

    if (hourFinal >= 12) {
      hourFinal -= 12;
    }

    // Format hour and minute with leading zeros
    String formattedHour = hour.toString().padLeft(2, '0');
    String formattedHourFinal = hourFinal.toString().padLeft(2, '0');
    String formattedMinute = minute.toString().padLeft(2, '0');

    // Construct and return the non-military time string
    return "${formattedHour}:${formattedMinute} $amPm - ${formattedHourFinal}:${formattedMinute} $amPmFinal";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // centerTitle: true,
        foregroundColor: Colors.white,
        title: const Text(
          "Confirma y paga",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        backgroundColor: const Color.fromARGB(255, 29, 7, 48),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: const Color.fromARGB(255, 29, 7, 48),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                width: 400,
                margin: const EdgeInsets.only(right: 30, left: 30, top: 40),
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
                              widget.hotel.nombre,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            )),
                        Container(
                            width: 130,
                            child: Text(
                              widget.hotel.direccion,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300),
                            ))
                      ],
                    )
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                width: 400,
                margin: const EdgeInsets.only(right: 30, left: 30, top: 20),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.white),
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 40,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Hora",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            calcularHoraReserva(widget.selectedHorasHabitacion),
                            // "${widget.horaReserva.toString().padLeft(2, '0')}:${widget.minutoReserva.toString().padLeft(2, '0')} - ${(widget.horaReserva + widget.selectedHorasHabitacion).toString().padLeft(2, '0')}:${widget.minutoReserva.toString().padLeft(2, '0')}",
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Habitación",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                          Container(
                            width: 140,
                            child: Text(
                              overflow: TextOverflow.visible,
                              "${widget.selectedHabitacion} - ${widget.selectedHorasHabitacion} h",
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                width: 400,
                margin: const EdgeInsets.only(right: 30, left: 30, top: 20),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.white),
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Información del precio",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "TOTAL: ",
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          "S/${widget.selectedPrecioHabitacion}",
                          style: const TextStyle(color: Colors.white),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                width: 400,
                margin: const EdgeInsets.only(right: 30, left: 30, top: 20),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.white),
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
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
                                      const Text(
                                        "Tarjeta de crédito",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      Checkbox(
                                        value: isTarjeta,
                                        onChanged: (newBool) {
                                          setState(() {
                                            isTarjeta = newBool!;
                                            isEfectivo = false;
                                            isYape = false;
                                            isPlin = false;
                                          });
                                        },
                                        activeColor: const Color.fromARGB(
                                            255, 190, 160, 209),
                                        checkColor: Colors.white,
                                        hoverColor: const Color.fromARGB(
                                            255, 156, 110, 187),
                                        shape: const CircleBorder(),
                                      ),
                                    ],
                                  )
                                : metodoP == "Efectivo"
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "Efectivo",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          Checkbox(
                                            value: isEfectivo,
                                            onChanged: (newBool) {
                                              setState(() {
                                                isEfectivo = newBool!;
                                                isTarjeta = false;
                                                isYape = false;
                                                isPlin = false;
                                              });
                                            },
                                            activeColor: const Color.fromARGB(
                                                255, 190, 160, 209),
                                            checkColor: Colors.white,
                                            hoverColor: const Color.fromARGB(
                                                255, 156, 110, 187),
                                            shape: const CircleBorder(),
                                          ),
                                        ],
                                      )
                                    : metodoP == "Yape"
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Image.asset(
                                                    "assets/yape.png",
                                                    height: 50,
                                                    width: 50,
                                                  ),
                                                  const Text(
                                                    "Yape",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                              Checkbox(
                                                value: isYape,
                                                onChanged: (newBool) {
                                                  setState(() {
                                                    isYape = newBool!;
                                                    isTarjeta = false;
                                                    isEfectivo = false;
                                                    isPlin = false;
                                                  });
                                                },
                                                activeColor:
                                                    const Color.fromARGB(
                                                        255, 190, 160, 209),
                                                checkColor: Colors.white,
                                                hoverColor:
                                                    const Color.fromARGB(
                                                        255, 156, 110, 187),
                                                shape: const CircleBorder(),
                                              ),
                                            ],
                                          )
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Image.asset(
                                                    "assets/plin.png",
                                                    height: 30,
                                                    width: 30,
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  const Text(
                                                    "Plin",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                              Checkbox(
                                                value: isPlin,
                                                onChanged: (newBool) {
                                                  setState(() {
                                                    isPlin = newBool!;
                                                    isTarjeta = false;
                                                    isEfectivo = false;
                                                    isYape = false;
                                                  });
                                                },
                                                activeColor:
                                                    const Color.fromARGB(
                                                        255, 190, 160, 209),
                                                checkColor: Colors.white,
                                                hoverColor:
                                                    const Color.fromARGB(
                                                        255, 156, 110, 187),
                                                shape: const CircleBorder(),
                                              ),
                                            ],
                                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: isButtonDisabled
                    ? null
                    : () async {
                        setState(() {
                          isButtonDisabled = true;
                        });

                        if (isEfectivo || isYape || isPlin) {
                          final CollectionReference collection =
                              FirebaseFirestore.instance.collection("Reservas");
                          var reservasCount = (await collection.get()).size;
                          var metodoPago = "";

                          if (isEfectivo) {
                            metodoPago = "Efectivo";
                          } else if (isYape) {
                            metodoPago = "Yape";
                          } else if (isPlin) {
                            metodoPago = "Plin";
                          }
                          var horaFinal = widget.horaReserva +
                              widget.selectedHorasHabitacion +
                              1;

                          DateTime fechaFinal = DateTime.now();
                          DateTime fechaMaximaLLegada = DateTime.now();

                          if (horaFinal >= 24) {
                            horaFinal = horaFinal - 24;
                            fechaFinal =
                                fechaFinal.add(const Duration(days: 1));
                          }

                          int horaMaxima = widget.horaReserva + 1;

                          if (horaMaxima >= 24) {
                            horaMaxima = horaMaxima - 24;
                            fechaMaximaLLegada =
                                fechaMaximaLLegada.add(const Duration(days: 1));
                          }

                          var codigo = generarCodigo();
                          Reserva reserva = Reserva(
                              fechaMaximaLLegada: fechaMaximaLLegada,
                              minutoMaximoLlegada: widget.minutoReserva,
                              horaMaximaLlegada: horaMaxima,
                              fecha: DateTime.now(),
                              nombreCliente:
                                  "${controlleruser.usuario!.nombres} ${controlleruser.usuario!.apellidos}",
                              key: reservasCount + 1,
                              precio: widget.selectedPrecioHabitacion,
                              idUserHotel: widget.hotel.user,
                              metodoPago: metodoPago,
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
                              horaFinalReserva: horaFinal,
                              fechaFinal: fechaFinal,
                              minutoInicioReserva: widget.minutoReserva,
                              minutoFinalReserva: widget.minutoReserva,
                              idHotel: widget.hotel.id,
                              idUser: controlleruser.usuario!.userName);

                          if (await PeticionesReserva
                                  .comprobarDisponibilidadReserva2(
                                      idHotel: widget.hotel.id,
                                      nombreHabitacion:
                                          widget.selectedHabitacion) >
                              0) {
                            var resp = await PeticionesReserva.RegistrarReserva(
                                reserva, context);

                            if (resp == "create") {
                              await PeticionesReporte.addReporteNumeroReserva(
                                  reserva.idUserHotel);

                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Center(
                                        child: Text(
                                      "¡Tu reserva ha sido confirmada con éxito!",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    )),
                                    content: Container(
                                      height: 140,
                                      child: Column(
                                        children: [
                                          Text(
                                              "Tu código es $codigo, recuerda que te lo pedirán en el establecimiento."),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          ElevatedButton(
                                            child:
                                                const Text('Ir a mis reservas'),
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  CupertinoPageRoute(
                                                      builder: (context) =>
                                                          const HomeUser(
                                                            currentIndex: 1,
                                                          )));
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );

                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Center(
                                        child: Text(
                                      "TOLERANCIA DE 1 HORA",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    )),
                                    content: Container(
                                      height: 140,
                                      child: Column(
                                        children: [
                                          const Text(
                                              "Recuerda que tienes MÁXIMO 1 HORA PARA LLEGAR al establecimiento seleccionado, ¡DATE PRISA!"),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          ElevatedButton(
                                            child: const Text('Aceptar'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
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
                          } else {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CustomAlert(
                                  title: "Lo sentimos...",
                                  text:
                                      "Unos segundos antes alguien ha reservado la última habitación disponible.",
                                );
                              },
                            );
                          }
                        } else if (isTarjeta) {
                          final CollectionReference collection =
                              FirebaseFirestore.instance.collection("Reservas");
                          var reservasCount = (await collection.get()).size;

                          var horaFinal = widget.horaReserva +
                              widget.selectedHorasHabitacion +
                              1;

                          DateTime fechaFinal = DateTime.now();
                          DateTime fechaMaximaLLegada = DateTime.now();

                          if (horaFinal >= 24) {
                            horaFinal = horaFinal - 24;
                            fechaFinal =
                                fechaFinal.add(const Duration(days: 1));
                          }

                          int horaMaxima = widget.horaReserva + 1;

                          if (horaMaxima >= 24) {
                            horaMaxima = horaMaxima - 24;
                            fechaMaximaLLegada =
                                fechaMaximaLLegada.add(const Duration(days: 1));
                          }

                          var codigo = generarCodigo();
                          Reserva reserva = Reserva(
                              fechaMaximaLLegada: fechaMaximaLLegada,
                              fechaFinal: fechaFinal,
                              minutoMaximoLlegada: widget.minutoReserva,
                              horaMaximaLlegada: horaMaxima,
                              fecha: DateTime.now(),
                              nombreCliente:
                                  "${controlleruser.usuario!.nombres} ${controlleruser.usuario!.apellidos}",
                              key: reservasCount + 1,
                              precio: widget.selectedPrecioHabitacion,
                              idUserHotel: widget.hotel.user,
                              metodoPago: "Tarjeta",
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
                              horaFinalReserva: horaFinal,
                              minutoInicioReserva: widget.minutoReserva,
                              minutoFinalReserva: widget.minutoReserva,
                              idHotel: widget.hotel.id,
                              idUser: controlleruser.usuario!.userName);

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ConfigureCard(
                                        reserva: reserva,
                                        motivo: "Reserva",
                                        id: widget.hotel.id,
                                        saldo: widget.selectedPrecioHabitacion,
                                      )));
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CustomAlert(
                                title: "Selecciona tu metodo de pago",
                                text: "Aun no has elegido un metodo de pagos",
                              );
                            },
                          );
                        }
                        setState(() {
                          isButtonDisabled = false;
                        });
                      },
                child: Text(
                  "Reservar",
                  style: TextStyle(
                      color: isButtonDisabled
                          ? Colors.white
                          : Color.fromARGB(255, 47, 4, 73)),
                ),
                style: ElevatedButton.styleFrom(
                    disabledBackgroundColor: Color.fromARGB(125, 52, 2, 92),
                    backgroundColor: const Color(0xffffffff)),
              ),
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
