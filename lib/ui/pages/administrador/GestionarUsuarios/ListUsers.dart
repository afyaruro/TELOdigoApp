import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:telodigo/data/service/peticionesadmin.dart';
import 'package:telodigo/domain/models/hoteles.dart';
import 'package:telodigo/domain/models/usuario.dart';
import 'package:telodigo/ui/pages/administrador/GestionarUsuarios/viewUserDelete.dart';
import 'package:telodigo/ui/pages/administrador/homeAdmin.dart';

class ListUsers extends StatefulWidget {
  final String filtro;
  final int vista;
  const ListUsers({super.key, required this.filtro, this.vista = 0});

  @override
  State<ListUsers> createState() => _ListUsersState();
}

class _ListUsersState extends State<ListUsers> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.filtro);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //     leading: IconButton(
      //       icon: Icon(Icons.arrow_back),
      //       onPressed: () {
      //         Navigator.push(
      //             context,
      //             MaterialPageRoute(
      //                 builder: (context) => const HomeAdmin(
      //                       currentIndex: 1,
      //                     )));
      //       },
      //     ),
      //     foregroundColor: Colors.white,
      //     backgroundColor: Color.fromARGB(255, 29, 7, 48)),
      backgroundColor: const Color.fromARGB(255, 29, 7, 48),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // const SizedBox(
            //   height: 50,
            // ),
            widget.vista == 1
                ? Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(
                      top: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const HomeAdmin(
                                            currentIndex: 1,
                                          )));
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            )),
                      ],
                    ),
                  )
                : Container(
                    padding: EdgeInsets.symmetric(vertical: 30),
                  ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(50)),
              width: 400,
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      onSubmitted: (value) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ListUsers(
                                      vista: 1,
                                      filtro: controller.text,
                                    )));
                      },
                      controller: controller,
                      style:
                          TextStyle(color: Color.fromARGB(255, 247, 247, 247)),
                      decoration: InputDecoration(
                        hintStyle: TextStyle(
                            color: Color.fromARGB(255, 247, 247, 247),
                            fontWeight: FontWeight.w300),
                        hintText: 'Nombre de usuario',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide.none,
                          gapPadding: 10,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 106, 81, 153),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ListUsers(
                                      vista: 1,
                                      filtro: controller
                                          .text, // aca va el controlador que manda el texto del filtro
                                    )));
                      },
                      icon: Icon(Icons.search, color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
            FutureBuilder<List<Usuario>>(
              future: PeticionesAdmin.listUsuariosTodos(widget.filtro),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Text(
                      "Cargando Usuarios...",
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else {
                  final List<Usuario> usuarios = snapshot.data ?? [];

                  return usuarios.isEmpty
                      ? const FirstHotel()
                      : ListUsuariosDeleteCustom(
                          usuariosList: usuarios,
                        );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ListUsuariosDeleteCustom extends StatefulWidget {
  final List<Usuario> usuariosList;

  const ListUsuariosDeleteCustom({
    super.key,
    required this.usuariosList,
  });

  @override
  State<ListUsuariosDeleteCustom> createState() =>
      _ListUsuariosDeleteCustomState();
}

class _ListUsuariosDeleteCustomState extends State<ListUsuariosDeleteCustom> {
  late Hoteles? selectedHotel;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color.fromARGB(255, 29, 7, 48),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            for (Usuario usuario in widget.usuariosList)
              InkWell(
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewUserDelete(
                                user: usuario,
                              )));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(top: 5),
                  color: Color.fromARGB(255, 54, 12, 90),
                  child: Row(
                    children: [
                      ClipOval(
                        child: Image.memory(
                          base64Decode(usuario.foto),
                          fit: BoxFit.cover,
                          width: 50,
                          height: 50,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${usuario.userName}",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromARGB(255, 159, 131, 204)),
                            ),

                            Container(
                              child: Text(
                                "Nombres: ${usuario.nombres}",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Color.fromARGB(255, 255, 255, 255)),
                              ),
                            ),
                            Container(
                              child: Text(
                                "Apellidos: ${usuario.apellidos}",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Color.fromARGB(255, 255, 255, 255)),
                              ),
                            ),
                            Container(
                                child: Text(
                              "Saldo: S/${usuario.saldoCuenta.toStringAsFixed(2)}",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromARGB(255, 255, 255, 255)),
                            )),

                            // Container(
                            //     child: hotel.horaAbrir == "24 Horas"
                            //         ? Text(
                            //             "Servicio: ${hotel.horaAbrir}",
                            //             style: TextStyle(
                            //                 fontSize: 12,
                            //                 fontWeight: FontWeight.w500,
                            //                 color: Color.fromARGB(
                            //                     255, 255, 255, 255)),
                            //           )
                            //         : Text(
                            //             "Servicio: ${hotel.horaAbrir} - ${hotel.horaCerrar} Horas",
                            //             style: TextStyle(
                            //                 fontSize: 12,
                            //                 fontWeight: FontWeight.w500,
                            //                 color: Color.fromARGB(
                            //                     255, 255, 255, 255)),
                            //           )),
                            // Container(
                            //   child: Text(
                            //     "Direccion: ${hotel.direccion}",
                            //     style: TextStyle(
                            //         fontSize: 12,
                            //         color: Color.fromARGB(255, 255, 255, 255)),
                            //   ),
                            // )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
          ],
        ));
  }
}

class FirstHotel extends StatelessWidget {
  const FirstHotel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Aun no existen registros",
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(
            height: 150,
          )
        ],
      ),
    );
  }
}
//