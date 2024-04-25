import 'package:flutter/material.dart';
import 'package:telodigo/domain/models/hoteles.dart';
import 'package:telodigo/ui/components/customcomponents/custombuttonborderradius.dart';
import 'package:telodigo/ui/pages/crear%20anuncio/crearanuncioview1.dart';

class AnunciosAnfitrion extends StatefulWidget {
  const AnunciosAnfitrion({super.key});

  @override
  State<AnunciosAnfitrion> createState() => _AnunciosAnfitrionState();
}

class _AnunciosAnfitrionState extends State<AnunciosAnfitrion> {
  final List<Hoteles> hoteles =
      []; //[Hoteles(nombre: "Unico", tipoEspacio: "Habitacion")];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: hoteles.isEmpty ? FirstHotel() : ListHotel());
  }
}

class ListHotel extends StatelessWidget {
  const ListHotel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Tengo hoteles"),
    );
  }
}

class FirstHotel extends StatelessWidget {
  const FirstHotel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("¿No Has registrado aun tu negocio?"),
          Container(
              width: 200,
              margin: EdgeInsets.only(top: 15),
              child: CustomButtonsRadius(Colors.black, Colors.white,
                  "¡Registralo Aquí!", false, () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CrearAnuncioView1()));
                  }))
        ],
      ),
    );
  }
}
