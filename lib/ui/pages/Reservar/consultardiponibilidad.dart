import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();

    setState(() {
      selectedNombreHabitacion = widget.hotel.habitaciones[0].nombre;
      selectedHorasHabitacion = widget.hotel.habitaciones[0].precios[0].hora;
      selectedPrecioHabitacion = widget.hotel.habitaciones[0].precios[0].precio;
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
                      Text(
                        "$selectedNombreHabitacion",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 18),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        selectedHorasHabitacion == 1
                            ? "$selectedHorasHabitacion Hora"
                            : "$selectedHorasHabitacion horas",
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 1),
                        borderRadius: BorderRadius.circular(20)),
                    child: DropdownButton<String>(
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

                          for (var habitacion in widget.hotel.habitaciones) {
                            if (habitacion.nombre == selectedNombreHabitacion) {
                              // print("Hola");
                              listaPrecios = habitacion.precios;
                              selectedPrecioHabitacion =
                                  habitacion.precios[0].precio;
                              selectedHorasHabitacion =
                                  habitacion.precios[0].hora;
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
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 1),
                        borderRadius: BorderRadius.circular(20)),
                    child: DropdownButton<int>(
                      borderRadius: BorderRadius.circular(20),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      iconEnabledColor:
                          const Color.fromARGB(255, 255, 255, 255),
                      style:
                          TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
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
              SizedBox(
                height: 20,
              ),
              HoraMilitarWidget(
                typeHora: "--:--",
                controllerHora: selectedHoraReserva,
                controllerminuto: selectedMinutosReserva,
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ReservarHabitacion(
                                  minutoReserva:
                                      int.parse(selectedMinutosReserva.text),
                                  horaReserva:
                                      int.parse(selectedHoraReserva.text),
                                  hotel: widget.hotel,
                                  selectedHabitacion: selectedNombreHabitacion,
                                  selectedHorasHabitacion:
                                      selectedHorasHabitacion,
                                  selectedPrecioHabitacion:
                                      selectedPrecioHabitacion,
                                )));
                  },
                  child: Text("Consultar"))
            ],
          ),
        ),
      ),
    );
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
