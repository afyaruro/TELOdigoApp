import 'package:flutter/material.dart';
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

  String calcularHoraActual(int espera) {
    int hour = DateTime.now().hour + espera;
    int minute = DateTime.now().minute;

    hour = hour % 24;

    if (espera == 0) {
      selectedHoraReserva.text = hour.toString();
      selectedMinutosReserva.text = minute.toString();
    }

    // Determine AM or PM based on hour
    // String amPm = hour > 12 ? "PM" : "AM";
    String amPm = hour >= 12 ? "PM" : "AM";

    // Adjust hour for 12-hour format
    if (hour >= 12) {
      hour -= 12;
    }

    // Format hour and minute with leading zeros
    String formattedHour = hour.toString().padLeft(2, '0');
    String formattedMinute = minute.toString().padLeft(2, '0');

    // Construct and return the non-military time string
    return "${formattedHour}:${formattedMinute} $amPm";
  }

  // String calcularHoraActual2(int espera) {
  //   DateTime now = DateTime.now();
  //   int hour = now.hour + espera;
  //   int minute = now.minute;

  //   // Adjust hour to ensure it's within 0-23 range
  //   hour = hour % 24;

  //   // Determine AM or PM based on hour
  //   String amPm = hour >= 12 ? "PM" : "AM";

  //   // Adjust hour for 12-hour format
  //   if (hour == 0) {
  //     hour = 12; // Midnight edge case
  //   } else if (hour > 12) {
  //     hour -= 12;
  //   }

  //   // Format hour and minute with leading zeros
  //   String formattedHour = hour.toString().padLeft(2, '0');
  //   String formattedMinute = minute.toString().padLeft(2, '0');

  //   // Construct and return the non-military time string
  //   return "${formattedHour}:${formattedMinute} $amPm";
  // }

  @override
  void initState() {
    // PeticionesReserva.actualizarCulminado(context, "user");

    setState(() {
      selectedNombreHabitacion = widget.hotel.habitaciones[0].nombre;
      selectedHorasHabitacion = widget.hotel.habitaciones[0].precios[0].hora;
      selectedPrecioHabitacion = widget.hotel.habitaciones[0].precios[0].precio;
      selectedNumeroHabitaciones = widget.hotel.habitaciones[0].cantidad;
      listaPrecios = widget.hotel.habitaciones[0].precios;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 29, 7, 48),
        foregroundColor: Colors.white,
      ),
      backgroundColor: Color.fromARGB(255, 29, 7, 48),
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
                margin: EdgeInsets.only(top: 20, left: 30, right: 30),
                child: Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    "${widget.hotel.nombre}",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                  ),
                ),
              ),
              Container(
                width: 400,
                margin: EdgeInsets.only(top: 20, left: 30, right: 30),
                child: Center(
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
                margin: EdgeInsets.only(top: 0, left: 30, right: 30),
                child: Center(
                  child: Text(
                    "S/ $selectedPrecioHabitacion",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 25),
                  ),
                ),
              ),
              Container(
                width: 400,
                margin: EdgeInsets.only(top: 0, left: 30, right: 30),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          "$selectedNombreHabitacion",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 18),
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        selectedHorasHabitacion == 1
                            ? "$selectedHorasHabitacion Hora"
                            : "$selectedHorasHabitacion Horas",
                        style: TextStyle(
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
                margin: EdgeInsets.only(top: 0, left: 30, right: 30),
                child: Center(
                  child: Text(
                    "Incluye IGV y comisión de la App",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        fontSize: 13),
                  ),
                ),
              ),
              SizedBox(
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
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          iconEnabledColor:
                              const Color.fromARGB(255, 255, 255, 255),
                          style: TextStyle(color: Colors.white),
                          value: selectedNombreHabitacion,
                          dropdownColor: Color.fromARGB(255, 108, 108, 150),
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
                                  // print("Hola");
                                  listaPrecios = habitacion.precios;
                                  selectedPrecioHabitacion =
                                      habitacion.precios[0].precio;
                                  selectedHorasHabitacion =
                                      habitacion.precios[0].hora;
                                  selectedNumeroHabitaciones =
                                      habitacion.cantidad; //esto es nuevo
                                }
                              }
                              //  = selectedHabitacion!.;
                            });
                          },
                          underline: Container(
                            height: 0,
                            color: Colors.transparent,
                          ),
                        ),
                      ),
                      SizedBox(
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
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          iconEnabledColor:
                              const Color.fromARGB(255, 255, 255, 255),
                          style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255)),
                          dropdownColor: Color.fromARGB(255, 108, 108, 150),
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
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Container(
                  width: 400,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          const Text(
                            "Hora de reserva:",
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: 12),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: 120,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255)),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                calcularHoraActual(0),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
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
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255)),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                calcularHoraActual(1),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () async {
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
                          color: Color.fromARGB(255, 218, 5, 5),
                          icon: Icons.error,
                          context: context,
                          title: "No disponible",
                          mensaje:
                              "La reserva se encuentra fuera del horario del establecimiento",
                        );
                      }
                    }
                  },
                  child: Text("Consultar"))
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
        //falta validar el minuto

        abrirEstablecimiento =
            DateTime(now.year, now.month, now.day - 1, horaAbrir, minutoAbrir);
        cerrarEstablecimiento =
            DateTime(now.year, now.month, now.day, horaCerrar, minutoCerrar);
      }

      print(abrirEstablecimiento);
      print(cerrarEstablecimiento);
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
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(color: const Color.fromARGB(255, 255, 255, 255)),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Container(
                  child: Icon(
                Icons.access_time,
                color: Colors.white,
              )),
              SizedBox(width: 8),
              Text(
                _selectedTime != null
                    ? '${_selectedTime!.hour.toString().padLeft(2, '0')}:${_selectedTime!.minute.toString().padLeft(2, '0')}'
                    : widget.typeHora,
                style: TextStyle(fontSize: 16, color: Colors.white),
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
              SizedBox(height: 10),
              Text(
                mensaje,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: Text("Aceptar"),
            onPressed: () {
              funcion();
            },
          ),
        ],
      );
    },
  );
}
