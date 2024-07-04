import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:telodigo/data/service/peticionesImagenes.dart';
import 'package:telodigo/domain/models/habitaciones.dart';
import 'package:telodigo/domain/models/hoteles.dart';
import 'package:telodigo/domain/models/images.dart';
import 'package:telodigo/ui/components/customcomponents/customalert.dart';
import 'package:telodigo/ui/components/customcomponents/customtextfield.dart';
import 'package:telodigo/ui/pages/Editar%20Establecimiento/editarFotos.dart';
import 'package:telodigo/ui/pages/crear%20anuncio/crearanuncioview4.dart';
import 'package:telodigo/ui/pages/crear%20anuncio/crearanuncioview6.dart';
import 'package:telodigo/ui/pages/crear%20anuncio/crearanuncioview9.dart';
import 'package:telodigo/ui/pages/home%20anfitrion/homeanfitrion.dart';
import 'package:telodigo/ui/pages/view%20hotel/viewhotel.dart';

class EditarEstablecimiento extends StatefulWidget {
  final double estrellas;
  final Hoteles hotel;
  const EditarEstablecimiento(
      {super.key, required this.estrellas, required this.hotel});

  @override
  State<EditarEstablecimiento> createState() => _EditarEstablecimientoState();
}

class _EditarEstablecimientoState extends State<EditarEstablecimiento> {
  TextEditingController controllerNombre = TextEditingController();
  TextEditingController controllerDireccion = TextEditingController();
  TextEditingController controllerHabitacion = TextEditingController(text: "");

  final TextEditingController horaInicio = TextEditingController(text: "");

  final TextEditingController horaCerrar = TextEditingController(text: "");

  final TextEditingController minutoAbrir = TextEditingController(text: "");

  final TextEditingController minutoCerrar = TextEditingController(text: "");

  bool isChecked = false;

  bool btnWifi = false;
  bool btnTv = false;
  bool btnSillonTantrico = false;
  bool btnAguaCaliente = false;
  bool btnCochera = false;
  bool btnNetflix = false;

  List<String> servicios = [];

  List<Imagens> nuevasImagenes = [];

  List<Imagens> eliminadasImagenes = [];

  List<Imagens> todasImagenes = [];

  List<Habitaciones> habitaciones = [];

  var tipoHorario;

  @override
  void initState() {
    super.initState();

    horaInicio.text = widget.hotel.horaAbrir.toString();
    horaCerrar.text = widget.hotel.horaCerrar.toString();
    minutoAbrir.text = widget.hotel.minutoAbrir.toString();
    minutoCerrar.text = widget.hotel.minutoCerrar.toString();

    tipoHorario = widget.hotel.tipoHorario;

    controllerNombre.text = widget.hotel.nombre;
    controllerDireccion.text = widget.hotel.direccion;

    if (tipoHorario == "24 Horas") {
      isChecked = true;
    }

    for (var habitacion in widget.hotel.habitaciones) {
      habitaciones.add(Habitaciones(
        nombre: habitacion.nombre,
        cantidad: habitacion.cantidad,
        precios: List.from(habitacion.precios),
      ));
    }

    for (var imagen in widget.hotel.fotos) {
      todasImagenes.add(imagen);
    }

    for (var servicio in widget.hotel.servicios) {
      // servicios.add(servicio);
      if (servicio == "WIFI") {
        btnWifi = true;
      } else if (servicio == "TV") {
        btnTv = true;
      } else if (servicio == "Sillon Tántrico") {
        btnSillonTantrico = true;
      } else if (servicio == "Agua Caliente") {
        btnAguaCaliente = true;
      } else if (servicio == "Cochera") {
        btnCochera = true;
      } else if (servicio == "Netflix") {
        btnNetflix = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Color.fromARGB(255, 255, 255, 255),
        backgroundColor: Color.fromARGB(255, 29, 7, 48),
        title: Text(
          "Editar Establecimiento",
          style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500,
              color: Color.fromARGB(255, 255, 255, 255)),
        ),
        centerTitle: true,
      ),
      backgroundColor: const Color.fromARGB(255, 29, 7, 48),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              ImageCarouselEdit(
                imagenesEliminadas: eliminadasImagenes,
                imagenesNuevas: nuevasImagenes,
                imageUrls: todasImagenes,
              ),

              SizedBox(
                height: 20,
              ),

              //estrellas

              Container(
                width: 400,
                child: Row(
                  children: [
                    Text(
                      widget.estrellas.toStringAsFixed(1),
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
              SizedBox(
                height: 10,
              ),
              Container(
                width: 400,
                child: CustomTextField5(
                  nombre: "Nombre Establecimiento:",
                  isPassword: false,
                  controller: controllerNombre,
                  height: 70,
                  width: MediaQuery.of(context).size.width * .42,
                  textFontSize: 12,
                  placeholder: "Nombre Establecimiento",
                  funtion: () {},
                  keyboard: TextInputType.name,
                  inputFormater: const [],
                ),
              ),
              Container(
                width: 400,
                child: CustomTextField5(
                  nombre: "Dirección:",
                  isPassword: false,
                  controller: controllerDireccion,
                  height: 70,
                  width: MediaQuery.of(context).size.width * .42,
                  textFontSize: 12,
                  placeholder: "Dirección",
                  funtion: () {},
                  keyboard: TextInputType.name,
                  inputFormater: const [],
                ),
              ),

              // servicios
              Container(
                  width: 400,
                  margin: EdgeInsets.only(bottom: 10, top: 10),
                  child: const Text(
                    "Servicios:",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  )),
              Container(
                width: 400,
                margin: EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                        width: 130,
                        height: 60,
                        child: btnServicios(
                          nombre: "Wifi",
                          btn: btnWifi,
                          function: () {
                            btnWifi = !btnWifi;
                            setState(() {});
                          },
                        )),
                    Container(
                        width: 130,
                        height: 60,
                        child: btnServicios(
                          nombre: "TV",
                          btn: btnTv,
                          function: () {
                            btnTv = !btnTv;
                            setState(() {});
                          },
                        ))
                  ],
                ),
              ),
              Container(
                width: 400,
                margin: EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                        width: 130,
                        height: 60,
                        child: btnServicios(
                          nombre: "Sillon Tántrico",
                          btn: btnSillonTantrico,
                          function: () {
                            btnSillonTantrico = !btnSillonTantrico;
                            setState(() {});
                          },
                        )),
                    Container(
                        width: 130,
                        height: 60,
                        child: btnServicios(
                          nombre: "Agua Caliente",
                          btn: btnAguaCaliente,
                          function: () {
                            btnAguaCaliente = !btnAguaCaliente;
                            setState(() {});
                          },
                        ))
                  ],
                ),
              ),
              Container(
                width: 400,
                margin: EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                        width: 130,
                        height: 60,
                        child: btnServicios(
                          nombre: "Cochera",
                          btn: btnCochera,
                          function: () {
                            btnCochera = !btnCochera;
                            setState(() {});
                          },
                        )),
                    Container(
                        width: 130,
                        height: 60,
                        child: btnServicios(
                          nombre: "Netflix",
                          btn: btnNetflix,
                          function: () {
                            btnNetflix = !btnNetflix;
                            setState(() {});
                          },
                        ))
                  ],
                ),
              ),

              //Horario de atencion

              Container(
                  width: 400,
                  margin: const EdgeInsets.only(top: 20, bottom: 10),
                  child: const Text(
                    "Horario de Atención",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  )),
              Visibility(
                visible: !isChecked,
                child: Column(
                  children: [
                    Text(
                      "¿A que hora abres tu negocio?",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    HoraMilitarWidget(
                      typeHora: "Hora Inicio",
                      horaInicio: horaInicio,
                      horaCerrar: horaCerrar,
                      minutoCerrar: minutoCerrar,
                      minutoInicio: minutoAbrir,
                      editar: true,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "¿A que hora cierras tu negocio?",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    HoraMilitarWidget(
                      editar: true,
                      typeHora: "Hora Cierre",
                      horaInicio: horaInicio,
                      horaCerrar: horaCerrar,
                      minutoCerrar: minutoCerrar,
                      minutoInicio: minutoAbrir,
                    ),
                  ],
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
                    style: TextStyle(color: Color.fromARGB(246, 255, 255, 255)),
                  ),
                ],
              ),

              //habitaciones

              SizedBox(
                height: 20,
              ),

              Container(
                  width: 400,
                  margin: EdgeInsets.only(bottom: 10),
                  child: const Text(
                    "Tipo de Habitaciones",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  )),
              Container(
                width: 400,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: CustomTextFieldX(
                        dimension: 25,
                        nombre: "",
                        controller: controllerHabitacion,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: [
                        Container(
                          width: 40,
                          decoration: const ShapeDecoration(
                            color: Color.fromARGB(255, 117, 76, 172),
                            shape: CircleBorder(),
                          ),
                          child: IconButton(
                            onPressed: () {
                              if (!controllerHabitacion.text.isEmpty) {
                                Habitaciones habitacion = Habitaciones(
                                  precios: [],
                                  cantidad: 0,
                                  nombre: controllerHabitacion.text,
                                );
                                habitaciones.add(habitacion);

                                FocusScope.of(context).unfocus();

                                controllerHabitacion.text = "";

                                setState(() {});
                              }
                            },
                            icon: Icon(Icons.add),
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        )
                      ],
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
              ),

              // cantidad de habitaciones
              const SizedBox(
                height: 20,
              ),

              Container(
                width: 400,
                child: Text(
                  "Cant. Habitaciones",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              for (var habitacion in habitaciones)
                Container(
                  width: 400,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(151, 102, 42, 121)),
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          overflow: TextOverflow.ellipsis,
                          habitacion.nombre,
                          style: const TextStyle(
                              fontSize: 15, color: Colors.white),
                        ),
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      Row(
                        children: [
                          Container(
                              width: 30,
                              decoration: const ShapeDecoration(
                                color: Color.fromARGB(255, 121, 78, 201),
                                shape: CircleBorder(),
                              ),
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (habitacion.cantidad > 0) {
                                      habitacion.cantidad =
                                          habitacion.cantidad - 1;
                                    }
                                  });
                                },
                                icon: const Icon(Icons.remove),
                                color: Colors.white,
                                iconSize: 15,
                              )),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "${habitacion.cantidad}",
                            style: const TextStyle(color: Colors.white),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                              width: 30,
                              decoration: const ShapeDecoration(
                                color: Color.fromARGB(255, 121, 78, 201),
                                shape: CircleBorder(),
                              ),
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    habitacion.cantidad =
                                        habitacion.cantidad + 1;
                                  });
                                },
                                icon: const Icon(Icons.add),
                                color: Colors.white,
                                iconSize: 15,
                              ))
                        ],
                      ),
                    ],
                  ),
                ),

              //edita precios

              Container(
                width: 400,
                child: Text(
                  "Tus Precios",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              for (var habitacion in habitaciones)
                Container(
                    width: 400,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
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
                                      color: Colors.white)),
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
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
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

              //botones opciones a realizar

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50.0),
                child: Wrap(
                  runSpacing: 20,
                  spacing: 20,
                  children: [
                    Container(
                      width: 120,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 255, 255, 255),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ViewHotel(
                                          hotel: widget.hotel,
                                        )));
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "Descartar cambios",
                              textAlign: TextAlign.center,
                            ),
                          )),
                    ),
                    Container(
                      width: 120,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                          ),
                          onPressed: () async {
                            servicios = [];

                            if (btnWifi) {
                              servicios.add("WIFI");
                            }

                            if (btnTv) {
                              servicios.add("TV");
                            }

                            if (btnSillonTantrico) {
                              servicios.add("Sillon Tántrico");
                            }

                            if (btnAguaCaliente) {
                              servicios.add("Agua Caliente");
                            }

                            if (btnCochera) {
                              servicios.add("Cochera");
                            }

                            if (btnNetflix) {
                              servicios.add("Netflix");
                            }

                            int numero = 0;

                            for (var habitacion in habitaciones) {
                              if (habitacion.precios.length == 0) {
                                numero = numero + 1;
                              }
                            }

                            if (controllerNombre.text.isEmpty) {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return CustomAlert(
                                      title: "Validar Nombre",
                                      text:
                                          "Por favor digita un nombre para tu establecimiento");
                                },
                              );
                            } else if (controllerDireccion.text.isEmpty) {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return CustomAlert(
                                      title: "Validar Dirección",
                                      text:
                                          "Por favor proporciona una dirección a tus clientes");
                                },
                              );
                            } else if (habitaciones.isEmpty) {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return CustomAlert(
                                      title: "Agrega Habitaciones",
                                      text:
                                          "Por favor agrega por lo menos un tipo de habitación");
                                },
                              );
                            } else if (numero > 0) {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return CustomAlert(
                                      title: "Agrega Precios",
                                      text:
                                          "Por favor agrega por lo menos un precio a cada uno de tus tipos de habitaciones");
                                },
                              );
                            } else {
                              String tipoHorario = "Horario";

                              if (isChecked) {
                                tipoHorario = "24 Horas";
                              }

                              await EditarEstablecimiento(
                                  direccion: controllerDireccion.text,
                                  id: widget.hotel.id,
                                  habitaciones: habitaciones,
                                  nombreNuevo: controllerNombre.text,
                                  servicios: servicios,
                                  horaAbrir: int.parse(horaInicio.text),
                                  horaCerrar: int.parse(horaCerrar.text),
                                  minutoAbrir: int.parse(minutoAbrir.text),
                                  minutoCerrar: int.parse(minutoCerrar.text),
                                  tipoHorario: tipoHorario);
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "Guardar cambios",
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          )),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> EditarEstablecimiento(
      {required String id,
      required String nombreNuevo,
      required String direccion,
      required int horaAbrir,
      required int horaCerrar,
      required int minutoAbrir,
      required int minutoCerrar,
      required String tipoHorario,
      required List<Habitaciones> habitaciones,
      required List<String> servicios}) async {
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
              SizedBox(
                width: 30,
              ),
              Text("Actualizando Negocio..."),
            ],
          ),
        );
      },
    );

    try {
      final collection = FirebaseFirestore.instance.collection('Negocios');
      final QuerySnapshot querySnapshot =
          await collection.where('id', isEqualTo: id).get();

      if (querySnapshot.docs.isNotEmpty) {
        final DocumentSnapshot data = querySnapshot.docs.first;

//agrega nuevas imagenes
        var url = "";
        Imagens img;
        for (var image in nuevasImagenes) {
          try {
            String uniqueFileName = FirebaseFirestore.instance
                .collection('dummyCollection')
                .doc()
                .id;
            String url = await PeticionesImagenes.cargarfoto(
              File(image.image),
              "User${widget.hotel.user}Id${widget.hotel.id}Nombre${widget.hotel.nombre}Image$uniqueFileName",
            );

            Imagens img = Imagens(image: url);

            todasImagenes.add(img);
          } catch (e) {
            print("Error al cargar la nueva imagen: $e");
          }
        }

        // Actualizar datos del establecimiento
        await data.reference.update({
          'nombre': nombreNuevo,
          'direccion': direccion,
          'servicios': servicios,
          'horaAbrir': horaAbrir,
          'horaCerrar': horaCerrar,
          'minutoAbrir': minutoAbrir,
          'minutoCerrar': minutoCerrar,
          'tipoHorario': tipoHorario,
          'habitaciones':
              habitaciones.map((habitacion) => habitacion.toJson()).toList(),
          'fotos': todasImagenes.map((imagen) => imagen.toJson()).toList(),
        });

        Navigator.of(context).pop();

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomeAnfitrion(
                      currentIndex: 0,
                    )));
      } else {
        throw Exception("No se encontró el negocio con el ID proporcionado.");
      }
    } catch (e) {
      Navigator.of(context).pop();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("Ocurrió un error al actualizar el negocio: $e"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }
}

class CustomTextFieldX extends StatefulWidget {
  final String nombre;
  final TextEditingController controller;
  final int dimension;

  const CustomTextFieldX({
    required this.nombre,
    required this.controller,
    required this.dimension,
  });

  @override
  _CustomTextFieldXState createState() => _CustomTextFieldXState();
}

class _CustomTextFieldXState extends State<CustomTextFieldX> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      // padding: EdgeInsets.symmetric(vertical: 2),
      width: 400,
      // height: 70,
      child: TextField(
        maxLength: widget.dimension,
        controller: widget.controller,
        textAlignVertical: TextAlignVertical.top,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide:
                const BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide:
                const BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide:
                const BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
          ),
          labelText: widget.nombre,
          labelStyle: const TextStyle(
              color: Color.fromARGB(255, 255, 255, 255), fontSize: 13),
          counterStyle: const TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        style: const TextStyle(
          color: Color.fromARGB(255, 255, 255, 255),
        ),
      ),
    );
  }
}
