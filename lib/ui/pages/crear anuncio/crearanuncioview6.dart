import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telodigo/data/controllers/negociocontroller.dart';
import 'package:telodigo/domain/models/habitaciones.dart';
import 'package:telodigo/ui/components/customcomponents/customalert.dart';
import 'package:telodigo/ui/pages/crear%20anuncio/crearanuncioview7.dart';

class CrearAnuncioView6 extends StatefulWidget {
  const CrearAnuncioView6({super.key});

  @override
  State<CrearAnuncioView6> createState() => _CrearAnuncioView6State();
}

class _CrearAnuncioView6State extends State<CrearAnuncioView6> {
  static final NegocioController controllerhotel = Get.find();
  List<Precios> precios = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 21, 1, 37),
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Paso 7 de 10",
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
              child: Column(children: [
            const SizedBox(height: 50),
            Container(
              width: 400,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  "Añade tus precios",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ),
            ),
            Container(
              width: 400,
              margin: EdgeInsets.only(top: 10),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  "Añade los precios según los tipos de habitación y las horas",
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
            ),
            Container(
              width: 400,
              margin: EdgeInsets.only(top: 30),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  "Seleccione el tipo de habitación para editar",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            for (var habitacion in controllerhotel.habitaciones!)
              Container(
                  width: 400,
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          width: 1)),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(habitacion.nombre,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromARGB(255, 193, 100, 216))),
                          ),
                          Row(
                            children: [
                              habitacion.precios.length == 0
                                  ? Container(
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.red,
                                      ),
                                      child: const Icon(
                                        Icons.close,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                      ))
                                  : const Icon(
                                      Icons.check_circle,
                                      color: Color.fromARGB(255, 53, 163, 1),
                                    )
                            ],
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 50,
                            child: const Text(
                              "Hora",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                          ),
                          Container(
                            width: 80,
                            child: const Text("Precio",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white)),
                          ),
                          Container(
                            width: 100,
                          )
                        ],
                      ),
                      for (var precio in habitacion.precios)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 50,
                              child: Text(
                                "${precio.hora}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                            ),
                            Container(
                              width: 80,
                              child: Text("S/${precio.precio}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white)),
                            ),
                            Container(
                              width: 100,
                              child: Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        habitacion.precios.remove(precio);
                                        setState(() {});
                                      },
                                      icon: const Icon(
                                        Icons.delete_forever,
                                        color: Colors.white,
                                      )),
                                  IconButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertEdit(
                                              precios: habitacion.precios,
                                              title: "Editar Precio",
                                              precio: precio,
                                              updatePrecio: (precio2) {
                                                int index = habitacion.precios
                                                    .indexOf(precio);

                                                habitacion.precios[index] =
                                                    precio2;

                                                setState(() {});
                                              },
                                            );
                                          },
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                      ))
                                ],
                              ),
                            )
                          ],
                        ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertAgregar(
                                  precios: habitacion.precios,
                                  title: "Nuevo Precio",
                                  updatePrecio: (precio2) {
                                    setState(() {
                                      habitacion.precios.add(precio2);
                                    });
                                  },
                                );
                              },
                            );
                          },
                          child: const Text("Nuevo Precio"))
                    ],
                  )),
          ]))),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                backgroundColor: const Color(0xFF1098E7)),
            onPressed: () {
              int numero = 0;

              for (var habitacion in controllerhotel.habitaciones!) {
                if (habitacion.precios.isEmpty) {
                  numero = numero + 1;
                }
              }

              if (numero > 0) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const CustomAlert(
                      title: "Valida tus Precios",
                      text:
                          "Por favor verifica tus habitaciones parece ser que hay habitaciones sin establecer precios",
                    );
                  },
                );
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CrearAnuncioView7()));
              }
            },
            child: const Text(
              "Siguiente",
              style: TextStyle(color: Colors.white),
            )),
      ),
    );
  }
}

class AlertEdit extends StatefulWidget {
  final Precios precio;
  final Function(Precios) updatePrecio;
  final String title;
  final List<Precios> precios;

  const AlertEdit(
      {super.key,
      required this.precio,
      required this.updatePrecio,
      required this.title,
      required this.precios});

  @override
  State<AlertEdit> createState() => _AlertEditState();
}

class _AlertEditState extends State<AlertEdit> {
  int selectedNumber = 1;
  TextEditingController controller = TextEditingController(text: "");

  @override
  void initState() {
    super.initState();
    selectedNumber = widget.precio.hora;
    controller.text = widget.precio.precio.toString();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
          child: Text(
        widget.title,
        style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Color.fromARGB(255, 66, 35, 116)),
      )),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 400,
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text("Horas:  "),
                    Container(
                      alignment: Alignment.center,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            width: 1,
                            color: Colors.black38,
                          )),
                      child: DropdownButton<int>(
                        value: selectedNumber,
                        items: List.generate(23, (index) {
                          return DropdownMenuItem<int>(
                            value: index + 1,
                            child: Text((index + 1).toString()),
                          );
                        }),
                        onChanged: (value) {
                          setState(() {
                            selectedNumber = value!;
                          });
                        },
                        underline: Container(
                          height: 0,
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const Text("Precio:  "),
                    Container(
                      width: 100,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            width: 1,
                            color: Colors.black38,
                          )),
                      child: TextField(
                        decoration: const InputDecoration(
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                        ),
                        keyboardType: TextInputType.number,
                        controller: controller,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Cancelar"),
        ),
        TextButton(
          onPressed: () {
            if (controller.text.isEmpty) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const CustomAlert(
                    title: "Agrega un precio",
                    text: "Por favor agrega un precio para continuar",
                  );
                },
              );
            } else if (double.tryParse(controller.text) == null) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const CustomAlert(
                    title: "Valor Inválido",
                    text: "El valor ingresado es inválido.",
                  );
                },
              );
            } else if (double.parse(controller.text) <= 0) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const CustomAlert(
                    title: "Valor Inválido",
                    text: "El valor ingresado debe ser mayor a 0.",
                  );
                },
              );
            } else {
              Precios precios = Precios(
                  precio: double.parse(controller.text), hora: selectedNumber);

              for (Precios p in widget.precios) {
                if (p.hora == selectedNumber && p.hora != widget.precio.hora) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const CustomAlert(
                        title: "Valor Inválido",
                        text: "Ya existe un precio registrado para esta hora.",
                      );
                    },
                  );
                  return;
                }
              }

              setState(() {
                widget.updatePrecio(precios);
              });

              Navigator.of(context).pop();
            }
          },
          child: const Text("Guardar"),
        ),
      ],
    );
  }
}

class AlertAgregar extends StatefulWidget {
  final Function(Precios) updatePrecio;
  final String title;
  final List<Precios> precios;

  const AlertAgregar({
    super.key,
    required this.updatePrecio,
    required this.title,
    required this.precios,
  });

  @override
  State<AlertAgregar> createState() => _AlertAgregarState();
}

class _AlertAgregarState extends State<AlertAgregar> {
  int selectedNumber = 1;
  TextEditingController controller = TextEditingController(text: "");

  @override
  void initState() {
    super.initState();
    selectedNumber = 1;
    controller.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
          child: Text(
        widget.title,
        style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Color.fromARGB(255, 66, 35, 116)),
      )),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 400,
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text("Horas:  "),
                    Container(
                      alignment: Alignment.center,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            width: 1,
                            color: Colors.black38,
                          )),
                      child: DropdownButton<int>(
                        value: selectedNumber,
                        items: List.generate(23, (index) {
                          return DropdownMenuItem<int>(
                            value: index + 1,
                            child: Text((index + 1).toString()),
                          );
                        }),
                        onChanged: (value) {
                          setState(() {
                            selectedNumber = value!;
                          });
                        },
                        underline: Container(
                          height: 0,
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const Text("Precio:  "),
                    Container(
                      width: 100,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            width: 1,
                            color: Colors.black38,
                          )),
                      child: TextField(
                        decoration: const InputDecoration(
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                        ),
                        keyboardType: TextInputType.number,
                        controller: controller,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Cancelar"),
        ),
        TextButton(
          onPressed: () {
            if (controller.text.isEmpty) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const CustomAlert(
                    title: "Agrega un precio",
                    text: "Por favor agrega un precio para continuar",
                  );
                },
              );
            } else if (double.tryParse(controller.text) == null) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const CustomAlert(
                    title: "Valor Inválido",
                    text: "El valor ingresado es inválido.",
                  );
                },
              );
            } else if (double.parse(controller.text) <= 0) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const CustomAlert(
                    title: "Valor Inválido",
                    text: "El valor ingresado debe ser mayor a 0.",
                  );
                },
              );
            } else {
              Precios precios = Precios(
                  precio: double.parse(controller.text), hora: selectedNumber);

              for (Precios p in widget.precios) {
                if (p.hora == selectedNumber) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const CustomAlert(
                        title: "Valor Inválido",
                        text: "Ya existe un precio registrado para esta hora.",
                      );
                    },
                  );
                  return;
                }
              }

              setState(() {
                widget.updatePrecio(precios);
              });
              Navigator.of(context).pop();
            }
          },
          child: const Text("Guardar"),
        ),
      ],
    );
  }
}
