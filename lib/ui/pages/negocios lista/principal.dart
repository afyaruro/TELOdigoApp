import 'package:flutter/material.dart';
import 'package:telodigo/data/service/peticionnegocio.dart';
import 'package:telodigo/domain/models/hoteles.dart';
import 'package:telodigo/ui/pages/view%20hotel/viewhotelclientes.dart';

class Principal extends StatefulWidget {
  const Principal({Key? key}) : super(key: key);

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  late Future<List<Hoteles>> hotelesFuture;
  late Future<List<Hoteles>> hostalFuture;
  late Future<List<Hoteles>> habitacionFuture;
  late Future<List<Hoteles>> departamentoFuture;
  late Future<List<Hoteles>> bungalowFuture;

  @override
  void initState() {
    super.initState();
    // Inicia todas las solicitudes de datos al mismo tiempo
    hotelesFuture = PeticionesNegocio.listNegociosPrincipal("Hotel");
    hostalFuture = PeticionesNegocio.listNegociosPrincipal("Hostal");
    habitacionFuture = PeticionesNegocio.listNegociosPrincipal("Habitacion");
    departamentoFuture = PeticionesNegocio.listNegociosPrincipal("Departamento");
    bungalowFuture = PeticionesNegocio.listNegociosPrincipal("Bungalow");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Color.fromARGB(255, 29, 7, 48), 
      body: FutureBuilder(
        future: Future.wait([
          hotelesFuture,
          hostalFuture,
          habitacionFuture,
          departamentoFuture,
          bungalowFuture,
        ]),
        builder: (context, AsyncSnapshot<List<List<Hoteles>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              // child: CircularProgressIndicator(), // Muestra la barra de carga
                child: Text("Cargando Establecimientos...", style: TextStyle(color: Colors.white),),

            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            // Los datos están cargados, renderiza la pantalla principal
            return _buildContent(snapshot.data!);
          }
        },
      ),
    );
  }

  Widget _buildContent(List<List<Hoteles>> data) {
    // Extrae los datos de cada tipo de hotel
    List<Hoteles> hoteles = data[0];
    List<Hoteles> hostal = data[1];
    List<Hoteles> habitacion = data[2];
    List<Hoteles> departamento = data[3];
    List<Hoteles> bungalow = data[4];

    return Container(
      color: Color.fromARGB(255, 29, 7, 48),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Column(
            children: [

              Container(
                    width: 400,
                    padding: EdgeInsets.only(top: 50, left: 30),
                    child: Row(
                      children: [
                        Text(
                          "TELO",
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "digo",
                          style: TextStyle(
                              fontSize: 25,
                              color: Color.fromARGB(255, 129, 133, 190),
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    )),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 1),
                      borderRadius: BorderRadius.circular(50)),
                  width: 400,
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          style: TextStyle(
                              color: Color.fromARGB(255, 247, 247, 247)),
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
                          onPressed: () {},
                          icon: Icon(Icons.search, color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
              // Tu código aquí...
              ItemHotelCustom(
                tipoEspacio: "Hoteles",
                tipoHotel: hoteles,
                width: 180,
              ),
              ItemHotelCustom(
                tipoEspacio: "Hostales",
                tipoHotel: hostal,
                width: 250,
              ),
              ItemHotelCustom(
                tipoEspacio: "Habitaciones",
                tipoHotel: habitacion,
                width: 200,
              ),
              ItemHotelCustom(
                tipoEspacio: "Bungalows",
                tipoHotel: bungalow,
                width: 150,
              ),
              ItemHotelCustom(
                tipoEspacio: "Departamentos",
                tipoHotel: departamento,
                width: 250,
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class ItemHotelCustom extends StatefulWidget {
  final String tipoEspacio;
  final List<Hoteles> tipoHotel;
  final double width;

  const ItemHotelCustom(
      {super.key,
      required this.tipoEspacio,
      required this.tipoHotel,
      required this.width});

  @override
  State<ItemHotelCustom> createState() => _ItemHotelCustomState();
}

class _ItemHotelCustomState extends State<ItemHotelCustom> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            padding: EdgeInsets.only(left: 30),
            width: 400,
            child: Text(
              widget.tipoEspacio,
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
            )),
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 10),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              // width: MediaQuery.of(context).size.width,

              alignment: Alignment.bottomLeft,
              child: Row(
                children: [
                  for (var hotel in widget.tipoHotel)
                    InkWell(
                      onTap: () {

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewHotelCliente(
                                      hotel: hotel,
                                    )));
                      },
                      child: Stack(
                        children: [
                          Container(
                            width: widget.width,
                            height: 180,
                            margin: EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color.fromARGB(213, 56, 42, 78),
                            ),
                            child: ClipRRect(
                              child: Image.network(
                                hotel.fotos[0].image,
                                width: 160,
                                height: 180,
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          Positioned(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  hotel.nombre,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white),
                                ),
                                EstrellasPoint(hotel.calificacion),
                              ],
                            ),
                            bottom: 20,
                            left: 20,
                          )
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

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
}
