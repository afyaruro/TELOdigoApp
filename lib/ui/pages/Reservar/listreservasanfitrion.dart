import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:telodigo/data/service/PeticionesReservas.dart';
import 'package:telodigo/domain/models/reserva.dart';
import 'package:telodigo/ui/pages/Reservar/verificarcodigo.dart';

class ListReservasUserAnfitrion extends StatefulWidget {
  const ListReservasUserAnfitrion({super.key});

  @override
  State<ListReservasUserAnfitrion> createState() =>
      _ListReservasUserAnfitrionState();
}

class _ListReservasUserAnfitrionState extends State<ListReservasUserAnfitrion> {
  List<Reserva> reservas = [];
  String _searchText = "";
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 29, 7, 48),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Color.fromARGB(255, 29, 7, 48),
                padding:
                    EdgeInsets.only(right: 20, left: 20, top: 50, bottom: 20),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        _searchText = value;
                      });
                    },
                    controller: controller,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon: Icon(Icons.search),
                      hintText: "Buscar por nombre de usuario...",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide.none),
                    ),
                  ),
                ),
              ),
              FutureBuilder<List<Reserva>>(
                future: PeticionesReserva.listReservasAnfitrion(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      child: Center(
                        child: Text(
                          "Cargando Reservas...",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else {
                    reservas = snapshot.data ?? [];
                    List<Reserva> filteredReservas = reservas
                        .where((reserva) => reserva.idUser
                            .toLowerCase()
                            .contains(_searchText.toLowerCase()))
                        .toList();

                    return Container(
                        color: Color.fromARGB(255, 29, 7, 48),
                        child: filteredReservas.isEmpty
                            ? Container(
                                padding: EdgeInsets.all(20),
                                child: Center(
                                  child: Text(
                                    "No se encontraron reservas con el criterio de búsqueda",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              )
                            : ListHotel(context, filteredReservas));
                  }
                },
              ),
            ],
          ),
        ));
  }
}

Widget ListHotel(BuildContext context, List<Reserva> reservaList) {
  return Container(
      color: Color.fromARGB(255, 29, 7, 48),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          for (Reserva reserva in reservaList)
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VerificarCodigo(
                              reserva: reserva,
                            )));
              },
              child: Container(
                margin: EdgeInsets.only(right: 30, left: 30, top: 10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.white),
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                  color: reserva.metodoPago != "Efectivo"
                                      ? Color(0xFF00FF0A)
                                      : const Color.fromARGB(255, 255, 7, 7),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6))),
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            Text(
                              reserva.metodoPago != "Efectivo"
                                  ? "Pago"
                                  : "No ha Pagado",
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 2),
                            borderRadius: BorderRadius.circular(75),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(75),
                            child: Image.network(
                              reserva.fotoPrincipal,
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          children: [
                            Container(
                                width: 170,
                                child: Text(
                                  "${reserva.nombreNegocio}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                                width: 170,
                                child: Text(
                                  "Reservado por:",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                )),
                            Container(
                              width: 170,
                              child: Text(
                                "${reserva.nombreCliente}",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
        ],
      ));
}
