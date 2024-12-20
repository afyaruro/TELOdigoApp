import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telodigo/data/controllers/negociocontroller.dart';
import 'package:telodigo/domain/models/habitaciones.dart';
import 'package:telodigo/ui/components/customcomponents/customTextfielNegocio.dart';
import 'package:telodigo/ui/components/customcomponents/customalert.dart';
import 'package:telodigo/ui/pages/crear%20anuncio/crearanuncioview5.dart';

//hay cosas por arreglar aca con la hora y la cantidad de caracteres minimo 3

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
  final TextEditingController horaInicio = TextEditingController(text: "");
  final TextEditingController horaCerrar = TextEditingController(text: "");

  bool isChecked = false;
  static final NegocioController controllerhotel = Get.find();

  final TextEditingController minutoAbrir = TextEditingController(text: "");

  final TextEditingController minutoCerrar = TextEditingController(text: "");

  @override
  void initState() {
    super.initState();

    horaInicio.text = controllerhotel.horaAbrir.toString();
    horaCerrar.text = controllerhotel.horaCerrar.toString();
    minutoAbrir.text = controllerhotel.minutoAbrir.toString();
    minutoCerrar.text = controllerhotel.minutoCerrar.toString();

    if (controllerhotel.tipoHorario == "24 Horas") {
      isChecked = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 21, 1, 37),
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Paso 5 de 10",
          style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontSize: 15,
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 21, 1, 37),
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
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ),
              ),
              Container(
                  width: 400,
                  margin: const EdgeInsets.only(
                      top: 20, left: 30, right: 30, bottom: 10),
                  child: const Text(
                    "Introduce el nombre de tu negocio",
                    textAlign: TextAlign.start,
                    style: TextStyle(color: Colors.white),
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: CustomTextFieldNegocio(
                    negocioController: controllerhotel,
                    dimension: 40,
                    nombre: "Ejem. Los Girasoles",
                    controller: controller_nombreNegocio),
              ),
              Container(
                  width: 400,
                  margin: const EdgeInsets.only(
                      top: 20, left: 30, right: 30, bottom: 10),
                  child: const Text(
                    "Especifica el horario de atención",
                    textAlign: TextAlign.start,
                    style: TextStyle(color: Colors.white),
                  )),
              Visibility(
                visible: !isChecked,
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    HoraMilitarWidget(
                      typeHora: "Hora Inicio",
                      horaInicio: horaInicio,
                      horaCerrar: horaCerrar,
                      minutoCerrar: minutoCerrar,
                      minutoInicio: minutoAbrir,
                      editar: false,
                    ),
                    HoraMilitarWidget(
                      typeHora: "Hora Cierre",
                      horaInicio: horaInicio,
                      horaCerrar: horaCerrar,
                      minutoCerrar: minutoCerrar,
                      minutoInicio: minutoAbrir,
                      editar: false,
                    ),
                  ],
                ),
              ),
              Container(
                width: 400,
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    Checkbox(
                      value: isChecked,
                      onChanged: (newbool) {
                        setState(() {
                          isChecked = newbool!;
                          if (isChecked) {
                            horaInicio.text = "";
                            horaCerrar.text = "";
                            minutoAbrir.text = "";
                            minutoCerrar.text = "";
                          }
                        });
                      },
                      activeColor: const Color.fromARGB(255, 76, 150, 211),
                      checkColor: Colors.white,
                      hoverColor: const Color.fromARGB(255, 76, 150, 211),
                    ),
                    const Text(
                      "Horario de atencion 24 horas",
                      style:
                          TextStyle(color: Color.fromARGB(246, 255, 255, 255)),
                    ),
                  ],
                ),
              ),
              Container(
                  width: 400,
                  margin: const EdgeInsets.only(
                      top: 20, left: 30, right: 30, bottom: 0),
                  child: const Text(
                    "¿Tienes tipos de habitaciones?",
                    textAlign: TextAlign.start,
                    style: TextStyle(color: Colors.white),
                  )),
              Container(
                  width: 400,
                  margin: const EdgeInsets.only(
                      top: 0, left: 30, right: 30, bottom: 10),
                  child: const Text(
                    "Añade tus opciones",
                    textAlign: TextAlign.start,
                    style: TextStyle(color: Colors.white),
                  )),
              Container(
                width: 400,
                margin: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomTextFieldNegocio(
                        negocioController: controllerhotel,
                        dimension: 25,
                        nombre: "Habitación",
                        controller: controller_habitacion,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 40,
                      decoration: const ShapeDecoration(
                        color: Color.fromARGB(255, 117, 76, 172),
                        shape: CircleBorder(),
                      ),
                      child: IconButton(
                        onPressed: () {
                          if (controller_habitacion.text.trim().isNotEmpty) {
                            if (!RegExp(r"^[a-zA-Z0-9\s]+$")
                                .hasMatch(controller_habitacion.text)) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return const CustomAlert(
                                    title: "Verifica tu Información",
                                    text:
                                        "El nombre de la habitación solo puede contener letras, números y espacios.",
                                  );
                                },
                              );
                              setState(() {});
                              return;
                            }

                            if (controller_habitacion.text.trim().length < 3) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return const CustomAlert(
                                    title: "Verifica tu Información",
                                    text:
                                        "El nombre de la habitación debe tener al menos 3 caracteres.",
                                  );
                                },
                              );
                              setState(() {});
                              return;
                            }

                            Habitaciones habitacion = Habitaciones(
                              precios: [],
                              cantidad: 0,
                              nombre: controller_habitacion.text.trim(),
                            );
                            habitaciones.add(habitacion);

                            FocusScope.of(context).unfocus();

                            controller_habitacion.text = "";

                            setState(() {});
                            return;
                          }

                          controller_habitacion.text = "";

                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const CustomAlert(
                                title: "Verifica tu Habitación",
                                text:
                                    "El nombre de la habitación no puede ser vacio",
                              );
                            },
                          );
                          setState(() {});
                          return;
                        },
                        icon: const Icon(Icons.add),
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 2),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color:
                                    const Color.fromARGB(255, 202, 202, 202)),
                            borderRadius: BorderRadius.circular(50)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                child: Text(
                              habitacion.nombre,
                              style: const TextStyle(color: Colors.white),
                            )),
                            const SizedBox(
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
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                ),
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
                padding: const EdgeInsets.symmetric(vertical: 15),
                backgroundColor: const Color.fromARGB(255, 16, 152, 231)),
            onPressed: () async {
              if (controller_nombreNegocio.text.trim().isEmpty) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const CustomAlert(
                      title: "Validar Informacion",
                      text: "Por favor ingresar un nombre de hotel",
                    );
                  },
                );
                setState(() {});

                return;
              }

              if (!RegExp(r"^[a-zA-Z0-9\s]+$")
                  .hasMatch(controller_nombreNegocio.text)) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const CustomAlert(
                      title: "Verifica tu Información",
                      text:
                          "El nombre del negocio solo puede contener letras, números y espacios.",
                    );
                  },
                );
                setState(() {});

                return;
              }

              if (controller_nombreNegocio.text.length < 3) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const CustomAlert(
                      title: "Verifica tu Información",
                      text:
                          "El nombre del negocio debe tener al menos 3 caracteres.",
                    );
                  },
                );
                setState(() {});
                return;
              }

              if (!isChecked) {
                if (horaInicio.text.isEmpty || minutoAbrir.text.isEmpty) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const CustomAlert(
                        title: "Verifica tu Horario de Atención",
                        text:
                            "Por favor selecciona una hora para abrir tu negocio",
                      );
                    },
                  );
                  setState(() {});
                  return;
                }
                if (horaCerrar.text.isEmpty || minutoCerrar.text.isEmpty) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const CustomAlert(
                        title: "Verifica tu Horario de Atención",
                        text:
                            "Por favor selecciona una hora para cerrar tu negocio",
                      );
                    },
                  );
                  setState(() {});
                  return;
                }

                if (habitaciones.isEmpty) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const CustomAlert(
                        title: "Verifica Habitaciones",
                        text: "El número de habitaciones minimas es de uno",
                      );
                    },
                  );
                  setState(() {});
                  return;
                }

                await controllerhotel.informacionBasica(
                    nombreNegocio: controller_nombreNegocio.text.trim(),
                    horaAbrir: int.parse(horaInicio.text),
                    horaCerrar: int.parse(horaCerrar.text),
                    minutoAbrir: int.parse(minutoAbrir.text),
                    minutoCerrar: int.parse(minutoCerrar.text),
                    tipoHorario: "Horario",
                    habitaciones: habitaciones);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CrearAnuncioView5()));
                setState(() {});
                return;
              }

              if (habitaciones.isEmpty) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const CustomAlert(
                      title: "Verifica Habitaciones",
                      text: "El número de habitaciones minimas es de uno",
                    );
                  },
                );
                setState(() {});
                return;
              }

              await controllerhotel.informacionBasica(
                  nombreNegocio: controller_nombreNegocio.text.trim(),
                  horaAbrir: 0,
                  horaCerrar: 0,
                  minutoAbrir: 0,
                  minutoCerrar: 0,
                  tipoHorario: "24 Horas",
                  habitaciones: habitaciones);

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CrearAnuncioView5()));
              return;
            },
            child: const Text(
              "Siguiente",
              style: TextStyle(color: Colors.white),
            )),
      ),
    );
  }
}

class HoraMilitarWidget extends StatefulWidget {
  final String typeHora;
  final TextEditingController horaInicio;
  final TextEditingController horaCerrar;
  final TextEditingController minutoInicio;
  final TextEditingController minutoCerrar;
  final bool editar;
  // final TextEditingController controller;

  HoraMilitarWidget({
    required this.typeHora,
    required this.horaInicio,
    required this.horaCerrar,
    required this.minutoInicio,
    required this.minutoCerrar,
    required this.editar,
  });

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
            if (widget.typeHora == "Hora Inicio") {
              widget.horaInicio.text = _selectedTime!.hour.toString();
              widget.minutoInicio.text = _selectedTime!.minute.toString();
            } else {
              widget.horaCerrar.text = _selectedTime!.hour.toString();
              widget.minutoCerrar.text = _selectedTime!.minute.toString();
            }
            // widget.controller.text =
            //     '${_selectedTime!.hour}:${_selectedTime!.minute}';
          });
        }
      },
      child: IntrinsicWidth(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Container(
                  child: const Icon(
                Icons.access_time,
                color: Colors.white,
              )),
              const SizedBox(width: 8),
              widget.editar
                  ? Text(
                      widget.typeHora == "Hora Inicio"
                          ? '${widget.horaInicio.text.toString().padLeft(2, '0')}:${widget.minutoInicio.text.toString().padLeft(2, '0')}'
                          : '${widget.horaCerrar.text.toString().padLeft(2, '0')}:${widget.minutoCerrar.text.toString().padLeft(2, '0')}',
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    )
                  : Text(
                      _selectedTime != null
                          ? widget.typeHora == "Hora Inicio"
                              ? '${widget.horaInicio.text.toString().padLeft(2, '0')}:${widget.minutoInicio.text.toString().padLeft(2, '0')}'
                              : '${widget.horaCerrar.text.toString().padLeft(2, '0')}:${widget.minutoCerrar.text.toString().padLeft(2, '0')}'
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
