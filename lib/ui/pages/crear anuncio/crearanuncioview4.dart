import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telodigo/data/controllers/negociocontroller.dart';
import 'package:telodigo/domain/models/habitaciones.dart';
import 'package:telodigo/ui/components/customcomponents/customalert.dart';
import 'package:telodigo/ui/pages/crear%20anuncio/crearanuncioview5.dart';

class CrearAnuncioView4 extends StatefulWidget {
  const CrearAnuncioView4({super.key});

  @override
  State<CrearAnuncioView4> createState() => _CrearAnuncioView4State();
}

class _CrearAnuncioView4State extends State<CrearAnuncioView4> {
  List<Habitaciones> habitaciones = [];
  final TextEditingController controller_habitacion =
      TextEditingController(text: "");
  final TextEditingController controller_nombreNegocio =
      TextEditingController(text: "");
  final TextEditingController controller_horaInicio =
      TextEditingController(text: "");
  final TextEditingController controller_horaCerrar =
      TextEditingController(text: "");

  bool isChecked = false;
  static final NegocioController controllerhotel = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 21, 1, 37),
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Paso 4 de 9",
          style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontSize: 15,
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 50),
              Container(
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    "Muestra información a tus futuros clientes",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              Container(
                  width: 400,
                  margin:
                      EdgeInsets.only(top: 20, left: 30, right: 30, bottom: 10),
                  child: Text(
                    "Introduce el nombre de tu negocio",
                    textAlign: TextAlign.start,
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: CustomTextField1(
                    nombre: "Ejem. Los Girasoles",
                    controller: controller_nombreNegocio),
              ),
              Container(
                  width: 400,
                  margin:
                      EdgeInsets.only(top: 20, left: 30, right: 30, bottom: 10),
                  child: Text(
                    "Especifica el horario de atención",
                    textAlign: TextAlign.start,
                  )),
              Visibility(
                visible: !isChecked,
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    HoraMilitarWidget(
                      typeHora: "Hora Inicio",
                      controller: controller_horaInicio,
                    ),
                    HoraMilitarWidget(
                      typeHora: "Hora Cierre",
                      controller: controller_horaCerrar,
                    ),
                  ],
                ),
              ),
              Container(
                width: 400,
                padding: EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    Checkbox(
                      value: isChecked,
                      onChanged: (newbool) {
                        setState(() {
                          isChecked = newbool!;
                        });
                      },
                      activeColor: Color.fromARGB(255, 76, 150, 211),
                      checkColor: Colors.white,
                      hoverColor: Color.fromARGB(255, 76, 150, 211),
                    ),
                    const Text(
                      "Horario de atencion 24 horas",
                      style: TextStyle(color: Color.fromARGB(246, 37, 37, 37)),
                    ),
                  ],
                ),
              ),
              Container(
                  width: 400,
                  margin:
                      EdgeInsets.only(top: 20, left: 30, right: 30, bottom: 0),
                  child: Text(
                    "¿Tienes tipos de habitaciones?",
                    textAlign: TextAlign.start,
                  )),
              Container(
                  width: 400,
                  margin:
                      EdgeInsets.only(top: 0, left: 30, right: 30, bottom: 10),
                  child: Text(
                    "Añade tus opciones",
                    textAlign: TextAlign.start,
                  )),
              Container(
                width: 400,
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomTextField1(
                        nombre: "",
                        controller: controller_habitacion,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 40,
                      decoration: ShapeDecoration(
                        color: const Color.fromARGB(255, 1, 8, 20),
                        shape: CircleBorder(),
                      ),
                      child: IconButton(
                        onPressed: () {
                          if (!controller_habitacion.text.isEmpty) {
                            Habitaciones habitacion = Habitaciones(
                                nombre: controller_habitacion.text);
                            habitaciones.add(habitacion);

                            

                            FocusScope.of(context).unfocus();

                            controller_habitacion.text = "";

                            setState(() {});
                          }
                        },
                        icon: Icon(Icons.add),
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (var habitacion in habitaciones)
                    IntrinsicWidth(
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Color.fromARGB(255, 202, 202, 202)),
                            borderRadius: BorderRadius.circular(50)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(child: Text(habitacion.nombre)),
                            SizedBox(
                              width: 5,
                            ),
                            Container(
                              width: 25,
                              height: 30,
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  habitaciones.remove(habitacion);
                                  setState(() {});
                                },
                                icon: Icon(Icons.close),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15),
                backgroundColor: Color.fromARGB(255, 16, 152, 231)),
            onPressed: () async {
              if (controller_nombreNegocio.text.isEmpty) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const CustomAlert(
                      title: "Validar Informacion",
                      text: "Por favor ingresar un nombre de hotel",
                    );
                  },
                );
              } else if (habitaciones.isEmpty) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const CustomAlert(
                      title: "Validar Habitaciones",
                      text: "Aun no has registrado ninguna habitación",
                    );
                  },
                );
              } else {
                if (!isChecked) {
                  if (controller_horaInicio.text.isEmpty) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const CustomAlert(
                          title: "Verifica tu Horario de Atencion",
                          text:
                              "Por favor selecciona una hora para abrir tu negocio",
                        );
                      },
                    );
                  } else if (controller_horaCerrar.text.isEmpty) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const CustomAlert(
                          title: "Verifica tu Horario de Atencion",
                          text:
                              "Por favor selecciona una hora para cerrar tu negocio",
                        );
                      },
                    );
                  } else {
                    controllerhotel.informacionBasica(
                        nombreNegocio: controller_nombreNegocio.text,
                        horaAbrir: controller_horaInicio.text,
                        horaCerrar: controller_horaCerrar.text,
                        habitaciones: habitaciones);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CrearAnuncioView5()));
                  }
                } else {
                  await controllerhotel.informacionBasica(
                      nombreNegocio: controller_nombreNegocio.text,
                      horaAbrir: "24 Horas",
                      horaCerrar: "24 Horas",
                      habitaciones: habitaciones);

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CrearAnuncioView5()));
                }
              }
            },
            child: Text(
              "Siguiente",
              style: TextStyle(color: Colors.white),
            )),
      ),
    );
  }
}

class HoraMilitarWidget extends StatefulWidget {
  final String typeHora;
  final TextEditingController controller;

  const HoraMilitarWidget({required this.typeHora, required this.controller});
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
            widget.controller.text = '${_selectedTime!.hour}:${_selectedTime!.minute}';
          });
        }
      },
      child: IntrinsicWidth(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Container(child: Icon(Icons.access_time)),
              SizedBox(width: 8),
              Text(
                _selectedTime != null
                    ? '${_selectedTime!.hour}:${_selectedTime!.minute}'
                    : widget.typeHora,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextField1 extends StatefulWidget {
  final String nombre;
  final TextEditingController controller;

  const CustomTextField1({
    required this.nombre,
    required this.controller,
  });

  @override
  _CustomTextField1State createState() => _CustomTextField1State();
}

class _CustomTextField1State extends State<CustomTextField1> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      height: 50,
      width: 400,
      child: TextField(
        controller: widget.controller,
        textAlignVertical: TextAlignVertical.top,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(color: Color.fromARGB(255, 19, 18, 18)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(color: Color.fromARGB(255, 19, 18, 18)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide:
                BorderSide(color: const Color.fromARGB(255, 19, 18, 18)),
          ),
          labelText: widget.nombre,
          labelStyle: TextStyle(
              color: const Color.fromARGB(255, 19, 18, 18), fontSize: 13),
        ),
        style: TextStyle(
          color: const Color.fromARGB(255, 0, 0, 0),
        ),
      ),
    );
  }
}
