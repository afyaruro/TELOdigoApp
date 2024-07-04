import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telodigo/data/controllers/usercontroller.dart';
import 'package:telodigo/data/service/peticionesadmin.dart';
import 'package:telodigo/domain/models/habitaciones.dart';
import 'package:telodigo/domain/models/hoteles.dart';
import 'package:telodigo/ui/components/customcomponents/customcarrusel.dart';

class ViewNegocioDelete extends StatefulWidget {
  final Hoteles hotel;
  const ViewNegocioDelete({super.key, required this.hotel});

  @override
  State<ViewNegocioDelete> createState() => _ViewNegocioDeleteState();
}

class _ViewNegocioDeleteState extends State<ViewNegocioDelete> {
  late double estrellas = 0;
  late Hoteles favoritoa;
  List<Hoteles> favoritos = [];

  @override
  void initState() {
    super.initState();

    setState(() {
      estrellas = widget.hotel.calificacion;
    });
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
        // return Container(width: 23, child: Image.asset("assets/garage.png"));
        return Icon(
          Icons.garage,
          color: Color.fromARGB(255, 105, 47, 170),
        );
      }
      return Container();
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: Color.fromARGB(255, 29, 7, 48),
        title: Container(
          width: 200,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "TELO",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              ),
              Text(
                "digo",
                style: TextStyle(
                    color: Color.fromARGB(255, 129, 133, 190),
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(color: Color.fromARGB(255, 29, 7, 48)),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Container(
            width: 400,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                //galeria
                ImageCarousel(
                  imageUrls: widget.hotel.fotos,
                ),

                //calificacion fija por ahora debo cambiar la calificacion en la variable
                Container(
                    width: 400,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 100,
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
                        ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context2) {
                                return AlertDialog(
                                  title: const Text("Eliminar Negocio"),
                                  content: const Text(
                                      "¿Estas seguro de eliminar este negocio? recuerde que esta accion no se puede deshacer"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context2)
                                            .pop(); // Cerrar el diálogo
                                      },
                                      child: Text("Cancelar"),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context2).pop();

                                        showPasswordDialog(context, () async {
                                          await PeticionesAdmin.eliminarNegocio(
                                              widget.hotel.id, context);
                                        });
                                      },
                                      child: Text("Aceptar"),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Text(
                            "Eliminar",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red, // Color de fondo
                          ),
                        )
                      ],
                    )),
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
                  width: 400,
                  child: Text(
                    "Propietario: ${widget.hotel.user}",
                    style: const TextStyle(
                        color: Color.fromARGB(255, 121, 255, 94),
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
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
                              color: Color.fromARGB(255, 255, 255, 255))),
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
                          : Text(
                              "${widget.hotel.horaAbrir.toString().padLeft(2, '0')}:${widget.hotel.minutoAbrir.toString().padLeft(2, '0')} - ${widget.hotel.horaCerrar.toString().padLeft(2, '0')}:${widget.hotel.minutoCerrar.toString().padLeft(2, '0')}",
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
                                  style: const TextStyle(
                                      color:
                                          Color.fromARGB(255, 255, 255, 255)))),
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

                Row(
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
                ),

                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 20),
                  width: 400,
                  child: Center(
                    child: Text(
                      "Saldo: S/${widget.hotel.saldo.toStringAsFixed(2)}",
                      style: const TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 20),
                  width: 400,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Estado: ",
                          style: const TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.hotel.saldo > 5.0
                              ? "Publicado"
                              : "No Publicado",
                          style: TextStyle(
                              color: widget.hotel.saldo > 5.0
                                  ? Colors.green
                                  : Colors.amber,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),

                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void showPasswordDialog(BuildContext context, Function funcion) {
  TextEditingController passwordController = TextEditingController();
  final UserController controlleruser = Get.find();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Ingrese su contraseña'),
        content: TextField(
          controller: passwordController,
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Contraseña',
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Cancelar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Aceptar'),
            onPressed: () {
              if (passwordController.text == controlleruser.usuario!.password) {
                Navigator.of(context).pop();
                funcion();
              } else {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Contraseña Incorrecta"),
                      content: const Text(
                          "Sus credenciales no son validas para realizar esta accion"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("Aceptar"),
                        ),
                      ],
                    );
                  },
                );
              }
            },
          ),
        ],
      );
    },
  );
}
