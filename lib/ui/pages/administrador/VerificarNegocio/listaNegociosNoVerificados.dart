import 'package:flutter/material.dart';
import 'package:telodigo/data/service/peticionesadmin.dart';
import 'package:telodigo/domain/models/hoteles.dart';
import 'package:telodigo/ui/pages/administrador/VerificarNegocio/viewnegocioporverificar.dart';
import 'package:telodigo/ui/pages/administrador/homeAdmin.dart';

class ListNegociosNoVerificados extends StatefulWidget {
  final int vista;
  const ListNegociosNoVerificados({super.key, this.vista = 0});

  @override
  State<ListNegociosNoVerificados> createState() =>
      _ListNegociosNoVerificadosState();
}

class _ListNegociosNoVerificadosState extends State<ListNegociosNoVerificados> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Por Verificar",
            style: TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HomeAdmin(
                            currentIndex: 4,
                          )));
            },
          ),
          foregroundColor: Colors.white,
          backgroundColor: Color.fromARGB(255, 29, 7, 48)),
      backgroundColor: const Color.fromARGB(255, 29, 7, 48),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<List<Hoteles>>(
              future:
                  PeticionesAdmin.listPorVerificar(), // aca va la lista real
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    // child: CircularProgressIndicator(), // Muestra la barra de carga
                    child: Text(
                      "Cargando establecimientos por verificar...",
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
                      : ListNegociosNoVerificadosCustom(
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

class ListNegociosNoVerificadosCustom extends StatefulWidget {
  final List<Hoteles> hotelList;

  const ListNegociosNoVerificadosCustom({
    super.key,
    required this.hotelList,
  });

  @override
  State<ListNegociosNoVerificadosCustom> createState() =>
      _ListNegociosNoVerificadosCustomState();
}

class _ListNegociosNoVerificadosCustomState
    extends State<ListNegociosNoVerificadosCustom> {
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
                          builder: (context) => ViewNegocioPorVerificar(
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
                                  hotel.nombre,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color:
                                          Color.fromARGB(255, 159, 131, 204)),
                                )),
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
            "No hay establecimientos por verificar",
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