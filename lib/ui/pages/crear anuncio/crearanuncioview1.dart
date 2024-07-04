import 'package:flutter/material.dart';
import 'package:telodigo/ui/pages/crear%20anuncio/crearanuncioview2.dart';

class CrearAnuncioView1 extends StatefulWidget {
  const CrearAnuncioView1({super.key});

  @override
  State<CrearAnuncioView1> createState() => _CrearAnuncioView1State();
}

class _CrearAnuncioView1State extends State<CrearAnuncioView1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 21, 1, 37),
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Paso 1 de 10",
          style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontSize: 15,
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 21, 1, 37),
      body: Container(
        margin: const EdgeInsets.only(top: 50),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  width: 450,
                  child: const Text(
                    "Empezar a utilizar",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  )),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                width: 450,
                child: const Text(
                  "TELOdigo es muy sencillo",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 170, 84, 219)),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const ContainerDescribe(
                title: "1. Desribe tu espacio",
                description:
                    "Comparte algunos datos básicos como la ubicación.",
                urlFoto: "assets/tuEspacio.png",
              ),
              const SizedBox(
                height: 20,
              ),
              const ContainerDescribe(
                title: "2. Haz que destaque",
                description:
                    "Agrega al menos tres fotos y el nombre de tu hostal.",
                urlFoto: "assets/DestaqueIlustracion.png",
              ),
              const SizedBox(
                height: 20,
              ),
              const ContainerDescribe(
                title: "3. Termina y publica",
                description:
                    "Estable tus servicios y un precio. ¡Publica tu anuncio!",
                urlFoto: "assets/publicaIlustracion.png",
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 16, 152, 231)),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CrearAnuncioView2()));
                  },
                  child: Text(
                    "Comenzar",
                    style: TextStyle(color: Colors.white),
                  )),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ContainerDescribe extends StatelessWidget {
  const ContainerDescribe({
    super.key,
    required this.title,
    required this.description,
    required this.urlFoto,
  });

  final String title;
  final String description;
  final String urlFoto;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 450,
      height: 120,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      color: const Color.fromARGB(31, 255, 255, 255),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 250,
            padding: const EdgeInsets.only(top: 30, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.start,
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
                Text(
                  description,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Image.asset(urlFoto),
          )
        ],
      ),
    );
  }
}
