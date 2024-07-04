import 'package:flutter/material.dart';
import 'package:telodigo/data/service/PeticionesReservas.dart';
import 'package:telodigo/domain/models/hoteles.dart';
import 'package:telodigo/ui/pages/negocios%20lista/listCategoria.dart';
import 'package:telodigo/ui/pages/negocios%20lista/listnegocios.dart';

class Principal extends StatefulWidget {
  const Principal({Key? key}) : super(key: key);

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  late Future<List<Hoteles>> bungalow;
  late Future<List<Hoteles>> fichos;
  late Future<List<Hoteles>> tematicos;
  late Future<List<Hoteles>> caletas;
  late Future<List<Hoteles>> economicos;
  late Future<List<Hoteles>> inclusivos;

  @override
  void initState() {
    super.initState();
    PeticionesReserva.cancelarReservas(context);
    PeticionesReserva.calificar(context);
    PeticionesReserva.culminado(context);
  }

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF3B2151),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: ListView(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Color(0xFF1F1F1F),
                  // border: Border.all(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(50)),
              width: 400,
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      onSubmitted: (value) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NegociosCliente(
                                      filtro: controller.text,
                                    )));
                      },
                      controller: controller,
                      style: TextStyle(color: Color(0xFFBFB8E1)),
                      decoration: InputDecoration(
                        hintStyle: TextStyle(
                            color: Color.fromARGB(255, 247, 247, 247),
                            fontWeight: FontWeight.w500),
                        hintText: 'Busca tu TELO',
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
                                builder: (context) => NegociosCliente(
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
            SizedBox(
              height: 10,
            ),
            const CustomCategory(
              filtrocartegory: "FICHOS",
              horas: "3",
              image: "assets/fichos.png",
              porcentaje: "91%",
              valor: "75.50",
              nombreCategoria: "Los más FICHOS",
            ),
            const CustomCategory(
              filtrocartegory: "TEMATICOS",
              horas: "2",
              image: "assets/tematicos.png",
              porcentaje: "95%",
              valor: "55.50",
              nombreCategoria: "Los TEMÁTICOS",
            ),
            const CustomCategory(
              filtrocartegory: "CALETAS",
              horas: "2",
              image: "assets/caletas.png",
              porcentaje: "87%",
              valor: "40.50",
              nombreCategoria: "Los más CALETAS",
            ),
            const CustomCategory(
              filtrocartegory: "INCLUSIVOS (LGBT friendly)",
              horas: "2",
              image: "assets/inclusivos.png",
              porcentaje: "80%",
              valor: "45.50",
              nombreCategoria: "Para TODXS (LGBTIQ+)",
            ),
            const CustomCategory(
              filtrocartegory: "BUNGALOWS",
              horas: "3",
              image: "assets/bungalows.png",
              porcentaje: "88%",
              valor: "50.50",
              nombreCategoria: "Los BUNGALOWS",
            ),
            const CustomCategory(
              filtrocartegory: "ECONOMICOS",
              horas: "2",
              image: "assets/economicos.png",
              porcentaje: "83%",
              valor: "25.50",
              nombreCategoria: "Los más BARATOS",
            )
          ],
        ),
      ),
    );
  }
}

class CustomCategory extends StatelessWidget {
  final String image;
  final String nombreCategoria;
  final String valor;
  final String porcentaje;
  final String horas;
  final String filtrocartegory;

  const CustomCategory({
    super.key,
    required this.image,
    required this.nombreCategoria,
    required this.valor,
    required this.porcentaje,
    required this.horas,
    required this.filtrocartegory,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NegociosCategory(
                      textFiltro: "",
                      categoryFiltro: filtrocartegory,
                    )));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 150,
        child: Stack(
          children: [
            Image.asset(
              image,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
            Positioned(
              bottom: 10,
              right: 10,
              left: 10,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              nombreCategoria,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.thumb_up,
                                color: Colors.white,
                                size: 15,
                              ),
                              Text(porcentaje,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10))
                            ],
                          )
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          "S/$valor",
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        Text(
                          "APROX / ${horas}H",
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
