import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:telodigo/data/service/peticionesadmin.dart';
import 'package:telodigo/domain/models/hoteles.dart';
import 'package:telodigo/domain/models/usuario.dart';
import 'package:telodigo/ui/pages/administrador/GestionarNegocios/viewNegocioDelete.dart';

class ViewUserDelete extends StatefulWidget {
  final Usuario user;
  const ViewUserDelete({super.key, required this.user});

  @override
  State<ViewUserDelete> createState() => _ViewUserDeleteState();
}

class _ViewUserDeleteState extends State<ViewUserDelete> {
  late double estrellas = 0;
  late Hoteles favoritoa;
  List<Hoteles> favoritos = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                ClipOval(
                  child: Image.memory(
                    base64Decode(widget.user.foto),
                    fit: BoxFit.cover,
                    width: 150,
                    height: 150,
                  ),
                ),

                Container(
                    width: 400,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context2) {
                                return AlertDialog(
                                  title: const Text("Eliminar Usuario"),
                                  content: const Text(
                                      "¿Estas seguro de eliminar este usuario? recuerde que esta accion no se puede deshacer"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context2)
                                            .pop(); // Cerrar el diálogo
                                      },
                                      child: Text("Cancelar"),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        Navigator.of(context2).pop();

                                        showPasswordDialog(context, () async {
                                          await PeticionesAdmin.eliminarUsuario(
                                              widget.user.userName, context);
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
                Center(
                  child: Text(
                    "Usuario: ",
                    style: const TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                ),

                Text(
                  widget.user.userName,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 11, 185, 55),
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),

                SizedBox(
                  height: 10,
                ),

                Center(
                  child: Text(
                    "Nombres:",
                    style: const TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),

                Center(
                  child: Text(
                    widget.user.nombres,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    "Apellidos:",
                    style: const TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),

                Center(
                  child: Text(
                    widget.user.apellidos,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    "Fecha de Nacimiento:",
                    style: const TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),

                Center(
                  child: Text(
                    widget.user.fechaNacimiento,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    "Edad: ${calcularEdad(widget.user.fechaNacimiento)} Años",
                    style: const TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 20),
                  width: 400,
                  child: Center(
                    child: Text(
                      "Saldo: S/${widget.user.saldoCuenta.toStringAsFixed(2)}",
                      style: const TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
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

  int calcularEdad(String fechaNacimiento) {
    DateTime birthDate = DateTime.parse(fechaNacimiento);
    DateTime today = DateTime.now();
    int age = today.year - birthDate.year;
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    return age;
  }
}
