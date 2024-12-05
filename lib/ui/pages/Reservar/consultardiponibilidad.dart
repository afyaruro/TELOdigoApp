import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telodigo/data/controllers/usercontroller.dart';
import 'package:telodigo/data/service/PeticionesReservas.dart';
import 'package:telodigo/domain/models/habitaciones.dart';
import 'package:telodigo/domain/models/hoteles.dart';
import 'package:telodigo/ui/pages/Reservar/reservar.dart';

class ConsultarDisponibilidad extends StatefulWidget {
  final Hoteles hotel;
  const ConsultarDisponibilidad({super.key, required this.hotel});

  @override
  State<ConsultarDisponibilidad> createState() =>
      _ConsultarDisponibilidadState();
}

class _ConsultarDisponibilidadState extends State<ConsultarDisponibilidad> {
  String selectedNombreHabitacion = "";
  int selectedHorasHabitacion = 0;
  double selectedPrecioHabitacion = 0.0;
  List<Precios> listaPrecios = [];
  TextEditingController selectedHoraReserva = TextEditingController(text: "");
  TextEditingController selectedMinutosReserva =
      TextEditingController(text: "");
  int selectedNumeroHabitaciones = 0;
  static final UserController controlleruser = Get.find();

  String calcularHoraActual(int esperaEnMinutos) {
    DateTime ahora = DateTime.now();
    DateTime nuevaHora = ahora.add(Duration(minutes: esperaEnMinutos));
    int hour = nuevaHora.hour;
    int minute = nuevaHora.minute;

    String amPm = hour >= 12 ? "PM" : "AM";

    if (hour > 12) {
      hour -= 12;
    } else if (hour == 0) {
      hour = 12;
    }

    String formattedHour = hour.toString().padLeft(2, '0');
    String formattedMinute = minute.toString().padLeft(2, '0');

    return "$formattedHour:$formattedMinute $amPm";
  }

  @override
  void initState() {
    super.initState();
    selectedNombreHabitacion = widget.hotel.habitaciones[0].nombre;
    selectedHorasHabitacion = widget.hotel.habitaciones[0].precios[0].hora;
    selectedPrecioHabitacion = widget.hotel.habitaciones[0].precios[0].precio;
    selectedNumeroHabitaciones = widget.hotel.habitaciones[0].cantidad;
    listaPrecios = widget.hotel.habitaciones[0].precios;

    DateTime now = DateTime.now();
    selectedHoraReserva.text = now.hour.toString();
    selectedMinutosReserva.text = now.minute.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 29, 7, 48),
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color.fromARGB(255, 29, 7, 48),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(75),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(75),
                  child: Image.network(
                    widget.hotel.fotos[0].image,
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                width: 400,
                margin: const EdgeInsets.only(top: 20, left: 30, right: 30),
                child: Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    widget.hotel.nombre,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                  ),
                ),
              ),
              Container(
                width: 400,
                margin: const EdgeInsets.only(top: 20, left: 30, right: 30),
                child: const Center(
                  child: Text(
                    "Precio mínimo estándar",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        fontSize: 13),
                  ),
                ),
              ),
              Container(
                width: 400,
                margin: const EdgeInsets.only(top: 0, left: 30, right: 30),
                child: Center(
                  child: Text(
                    "S/ $selectedPrecioHabitacion",
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 25),
                  ),
                ),
              ),
              Container(
                width: 400,
                margin: const EdgeInsets.only(top: 0, left: 30, right: 30),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          selectedNombreHabitacion,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 18),
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Text(
                        selectedHorasHabitacion == 1
                            ? "$selectedHorasHabitacion Hora"
                            : "$selectedHorasHabitacion Horas",
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 400,
                margin: const EdgeInsets.only(top: 0, left: 30, right: 30),
                child: const Center(
                  child: Text(
                    "Incluye IGV y comisión de la App",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        fontSize: 13),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Container(
                  width: 400,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 120,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 1),
                            borderRadius: BorderRadius.circular(20)),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          borderRadius: BorderRadius.circular(20),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          iconEnabledColor:
                              const Color.fromARGB(255, 255, 255, 255),
                          style: const TextStyle(color: Colors.white),
                          value: selectedNombreHabitacion,
                          dropdownColor:
                              const Color.fromARGB(255, 108, 108, 150),
                          items: widget.hotel.habitaciones.map((habitacion) {
                            return DropdownMenuItem(
                              value: habitacion.nombre,
                              child: Center(child: Text(habitacion.nombre)),
                            );
                          }).toList(),
                          onChanged: (String? selectedHabitacion) {
                            setState(() {
                              selectedNombreHabitacion = selectedHabitacion!;

                              for (var habitacion
                                  in widget.hotel.habitaciones) {
                                if (habitacion.nombre ==
                                    selectedNombreHabitacion) {
                                  listaPrecios = habitacion.precios;
                                  selectedPrecioHabitacion =
                                      habitacion.precios[0].precio;
                                  selectedHorasHabitacion =
                                      habitacion.precios[0].hora;
                                  selectedNumeroHabitaciones =
                                      habitacion.cantidad;
                                }
                              }
                            });
                          },
                          underline: Container(
                            height: 0,
                            color: Colors.transparent,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Container(
                        width: 120,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 1),
                            borderRadius: BorderRadius.circular(20)),
                        child: DropdownButton<int>(
                          isExpanded: true,
                          borderRadius: BorderRadius.circular(20),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          iconEnabledColor:
                              const Color.fromARGB(255, 255, 255, 255),
                          style: const TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255)),
                          dropdownColor:
                              const Color.fromARGB(255, 108, 108, 150),
                          value: selectedHorasHabitacion,
                          items: listaPrecios.map((precio) {
                            return DropdownMenuItem(
                              value: precio.hora,
                              child: Center(
                                  child: Text(
                                precio.hora > 1
                                    ? "${precio.hora} Horas"
                                    : "${precio.hora} Hora",
                              )),
                            );
                          }).toList(),
                          onChanged: (int? selectedHora) {
                            setState(() {
                              selectedHorasHabitacion = selectedHora!;
                              for (var precio in listaPrecios) {
                                if (precio.hora == selectedHorasHabitacion) {
                                  selectedPrecioHabitacion = precio.precio;
                                }
                              }
                            });
                          },
                          underline: Container(
                            height: 0,
                            color: const Color.fromARGB(0, 255, 255, 255),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Container(
                  width: 400,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          const Text(
                            "Hora máxima de llegada:",
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: 12),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: 120,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Center(
                              child: Text(
                                calcularHoraActual(30),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () async {
                    final CollectionReference collection =
                        FirebaseFirestore.instance.collection("Reservas");

                    final QuerySnapshot querySnapshot = await collection
                        .where('idUser',
                            isEqualTo: controlleruser.usuario!.userName)
                        .where('estado',
                            whereIn: ["En espera", "En la Habitacion"]).get();

                    final int count = querySnapshot.size;

                    if (count < 2) {
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
                                  width: 30,
                                  height: 30,
                                  child: const CircularProgressIndicator(),
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                                const Flexible(
                                    child: Text(
                                  "Comprobando Disp...",
                                  overflow: TextOverflow.clip,
                                )),
                              ],
                            ),
                          );
                        },
                      );

                      if (widget.hotel.tipoHorario == "24 Horas") {
                        await ComprobarDisponibilidad2(
                            widget.hotel.id, selectedNombreHabitacion);
                      } else {
                        if (isReservationWithinHours(
                            duracionReserva: selectedHorasHabitacion,
                            horaAbrir: widget.hotel.horaAbrir,
                            minutoAbrir: widget.hotel.minutoAbrir,
                            horaCerrar: widget.hotel.horaCerrar,
                            minutoCerrar: widget.hotel.minutoCerrar)) {
                          await ComprobarDisponibilidad2(
                              widget.hotel.id, selectedNombreHabitacion);
                        } else {
                          Navigator.of(context).pop();
                          mostrarAlerta(
                            funcion: () {
                              Navigator.of(context).pop();
                            },
                            color: const Color.fromARGB(255, 218, 5, 5),
                            icon: Icons.error,
                            context: context,
                            title: "No disponible",
                            mensaje:
                                "La reserva se encuentra fuera del horario del establecimiento",
                          );
                        }
                      }
                      return;
                    }

                    mostrarAlerta(
                      funcion: () {
                        Navigator.of(context).pop();
                      },
                      color: const Color.fromARGB(255, 218, 5, 5),
                      icon: Icons.error,
                      context: context,
                      title: "No disponible",
                      mensaje: "Ya cuentas con 2 reservas activas",
                    );
                  },
                  child: const Text("Comprobar Disponibilidad"))
            ],
          ),
        ),
      ),
    );
  }

  bool isReservationWithinHours(
      {required int horaAbrir,
      required int horaCerrar,
      required int minutoAbrir,
      required int minutoCerrar,
      required int duracionReserva}) {
    DateTime now = DateTime.now();
    DateTime abrirEstablecimiento;
    DateTime cerrarEstablecimiento;

    if (horaAbrir > horaCerrar) {
      abrirEstablecimiento =
          DateTime(now.year, now.month, now.day, horaAbrir, minutoAbrir);

      cerrarEstablecimiento =
          DateTime(now.year, now.month, now.day + 1, horaCerrar, minutoCerrar);

      if (now.hour >= 0 && now.hour <= horaCerrar) {
        abrirEstablecimiento =
            DateTime(now.year, now.month, now.day - 1, horaAbrir, minutoAbrir);
        cerrarEstablecimiento =
            DateTime(now.year, now.month, now.day, horaCerrar, minutoCerrar);
      }
    } else {
      abrirEstablecimiento =
          DateTime(now.year, now.month, now.day, horaAbrir, minutoAbrir);

      cerrarEstablecimiento =
          DateTime(now.year, now.month, now.day, horaCerrar, minutoCerrar);
    }

    DateTime horaInicioReserva = now;
    DateTime reservationEnd =
        horaInicioReserva.add(Duration(hours: duracionReserva + 1));

    // Ajustar horaInicioReserva y reservationEnd si son antes de la hora de apertura
    if (horaInicioReserva.isBefore(abrirEstablecimiento)) {
      horaInicioReserva = abrirEstablecimiento;
      reservationEnd = horaInicioReserva.add(Duration(hours: duracionReserva));
    }

    // Verificar si la reserva está dentro del horario de apertura
    if (horaInicioReserva.isAfter(abrirEstablecimiento) &&
        reservationEnd.isBefore(cerrarEstablecimiento)) {
      return true;
    }

    return false;
  }

  ComprobarDisponibilidad2(String idHotel, String habitacion) async {
    if (await PeticionesReserva.comprobarDisponibilidadReserva2(
            idHotel: idHotel, nombreHabitacion: habitacion) >
        0) {
      Navigator.pop(context);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ReservarHabitacion(
                    minutoReserva: int.parse(selectedMinutosReserva.text),
                    horaReserva: int.parse(selectedHoraReserva.text),
                    hotel: widget.hotel,
                    selectedHabitacion: selectedNombreHabitacion,
                    selectedHorasHabitacion: selectedHorasHabitacion,
                    selectedPrecioHabitacion: selectedPrecioHabitacion,
                  )));
    } else {
      Navigator.pop(context);
      mostrarAlerta(
        funcion: () {
          Navigator.of(context).pop();
        },
        color: Color.fromARGB(255, 218, 5, 5),
        icon: Icons.error,
        context: context,
        title: "No disponible",
        mensaje:
            "No tenemos disponibles habitaciones del tipo que has seleccionado",
      );
    }
  }
}

class HoraMilitarWidget extends StatefulWidget {
  final String typeHora;
  final TextEditingController controllerHora;
  final TextEditingController controllerminuto;

  const HoraMilitarWidget(
      {required this.typeHora,
      required this.controllerHora,
      required this.controllerminuto});
  @override
  _HoraMilitarWidgetState createState() => _HoraMilitarWidgetState();
}

class _HoraMilitarWidgetState extends State<HoraMilitarWidget> {
  TimeOfDay? _selectedTime;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        _selectedTime = TimeOfDay.now();
        final pickedTime = await showTimePicker(
          context: context,
          initialTime: _selectedTime!,
        );

        if (pickedTime != null) {
          setState(() {
            _selectedTime = pickedTime;
            widget.controllerHora.text = "${_selectedTime!.hour}";
            widget.controllerminuto.text = "${_selectedTime!.minute}";
          });
        }
      },
      child: IntrinsicWidth(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(color: const Color.fromARGB(255, 255, 255, 255)),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Container(
                  child: const Icon(
                Icons.access_time,
                color: Colors.white,
              )),
              SizedBox(width: 8),
              Text(
                _selectedTime != null
                    ? '${_selectedTime!.hour.toString().padLeft(2, '0')}:${_selectedTime!.minute.toString().padLeft(2, '0')}'
                    : widget.typeHora,
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void mostrarAlerta(
    {required BuildContext context,
    required Function funcion,
    required String mensaje,
    required IconData icon,
    required Color color,
    required String title}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Container(
          width: MediaQuery.of(context)
              .size
              .width, // Ajusta el ancho según sea necesario
          height: 155,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                height: 90,
                child: Column(
                  children: [
                    Icon(
                      icon,
                      color: color,
                      size: 60,
                    ),
                    Text(
                      title,
                      style:
                          TextStyle(color: color, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                mensaje,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: const Text("Aceptar"),
            onPressed: () {
              funcion();
            },
          ),
        ],
      );
    },
  );
}
