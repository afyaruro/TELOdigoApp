import 'package:flutter/material.dart';
import 'package:telodigo/data/service/peticionesadmin.dart';
import 'package:telodigo/domain/models/hoteles.dart';
import 'package:telodigo/ui/pages/administrador/GestionarNegocios/viewNegocioDelete.dart';
import 'package:telodigo/ui/pages/administrador/homeAdmin.dart';

class ListNegociosDelete extends StatefulWidget {
  final String filtro;
  final int vista;
  const ListNegociosDelete({super.key, required this.filtro, this.vista = 0});

  @override
  State<ListNegociosDelete> createState() => _ListNegociosDeleteState();
}

class _ListNegociosDeleteState extends State<ListNegociosDelete> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.filtro);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: widget.vista == 0
      //     ? AppBar(backgroundColor: Color.fromARGB(255, 29, 7, 48))
      //     : AppBar(
      //         leading: IconButton(
      //           icon: Icon(Icons.arrow_back),
      //           onPressed: () {
      //             Navigator.push(
      //                 context,
      //                 MaterialPageRoute(
      //                     builder: (context) => const HomeAdmin(
      //                           currentIndex: 2,
      //                         )));
      //           },
      //         ),
      //         foregroundColor: Colors.white,
      //         backgroundColor: Color.fromARGB(255, 29, 7, 48)),
      backgroundColor: const Color.fromARGB(255, 29, 7, 48),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                                            currentIndex: 2,
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
                                builder: (context) => ListNegociosDelete(
                                      filtro: controller.text,
                                      vista: 1,
                                    )));
                      },
                      controller: controller,
                      style:
                          TextStyle(color: Color.fromARGB(255, 247, 247, 247)),
                      decoration: InputDecoration(
                        hintStyle: TextStyle(
                            color: Color.fromARGB(255, 247, 247, 247),
                            fontWeight: FontWeight.w300),
                        hintText: 'Buscar hotel',
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
                                builder: (context) => ListNegociosDelete(
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
            FutureBuilder<List<Hoteles>>(
              future: PeticionesAdmin.listNegociosTodos(widget.filtro),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    // child: CircularProgressIndicator(), // Muestra la barra de carga
                    child: Text(
                      "Cargando Establecimientos...",
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else {
                  final List<Hoteles> hoteles = snapshot.data ?? [];

                  return hoteles.isEmpty
                      ? const FirstHotel()
                      : ListNegociosDeleteCustom(
                          hotelList: hoteles,
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

class ListNegociosDeleteCustom extends StatefulWidget {
  final List<Hoteles> hotelList;

  const ListNegociosDeleteCustom({
    super.key,
    required this.hotelList,
  });

  @override
  State<ListNegociosDeleteCustom> createState() =>
      _ListNegociosDeleteCustomState();
}

class _ListNegociosDeleteCustomState extends State<ListNegociosDeleteCustom> {
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
            for (Hoteles hotel in widget.hotelList)
              InkWell(
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewNegocioDelete(
                                hotel: hotel,
                              )));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(top: 5),
                  color: Color.fromARGB(255, 54, 12, 90),
                  child: Row(
                    children: [
                      Image.network(
                        hotel.fotos[0].image,
                        fit: BoxFit.cover,
                        width: 150,
                        height: 100,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width - 170,
                              child: Text(
                                overflow: TextOverflow.ellipsis,
                                "${hotel.nombre}",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromARGB(255, 159, 131, 204)),
                              ),
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width - 170,
                                child: Text(
                                  overflow: TextOverflow.ellipsis,
                                  "Saldo: S/${hotel.saldo.toStringAsFixed(2)}",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color:
                                          Color.fromARGB(255, 255, 255, 255)),
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

                            Container(
                              width: MediaQuery.of(context).size.width - 170,
                              child: Text(
                                overflow: TextOverflow.ellipsis,
                                "Creador: ${hotel.user}",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Color.fromARGB(255, 255, 255, 255)),
                              ),
                            ),

                            Container(
                              width: MediaQuery.of(context).size.width - 170,
                              child: Text(
                                overflow: TextOverflow.ellipsis,
                                "Direccion: ${hotel.direccion}",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Color.fromARGB(255, 255, 255, 255)),
                              ),
                            ),
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