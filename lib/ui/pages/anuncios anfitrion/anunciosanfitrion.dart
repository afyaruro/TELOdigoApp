// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:telodigo/domain/models/hoteles.dart';
import 'package:telodigo/ui/components/customcomponents/custombuttonborderradius.dart';
import 'package:telodigo/ui/pages/crear%20anuncio/crearanuncioview1.dart';

import '../../components/customcomponents/customaditem.dart';

class AnunciosAnfitrion extends StatefulWidget {
  const AnunciosAnfitrion({super.key});

  @override
  State<AnunciosAnfitrion> createState() => _AnunciosAnfitrionState();
}

class _AnunciosAnfitrionState extends State<AnunciosAnfitrion> {
  final List<Hoteles> hoteles =
      [
        Hoteles(nombre: "Unico", tipoEspacio: "Habitacion", direccion: '', habitaciones: [], latitud: '', longitud: '', horaAbrir: '', horaCerrar: '',),
        Hoteles(nombre: "Unico", tipoEspacio: "Habitacion", direccion: '', habitaciones: [], latitud: '', longitud: '', horaAbrir: '', horaCerrar: '',),
        Hoteles(nombre: "Unico", tipoEspacio: "Habitacion", direccion: '', habitaciones: [], latitud: '', longitud: '', horaAbrir: '', horaCerrar: '',),
        Hoteles(nombre: "Unico", tipoEspacio: "Habitacion", direccion: '', habitaciones: [], latitud: '', longitud: '', horaAbrir: '', horaCerrar: '',),
        Hoteles(nombre: "Unico", tipoEspacio: "Habitacion", direccion: '', habitaciones: [], latitud: '', longitud: '', horaAbrir: '', horaCerrar: '',),
        Hoteles(nombre: "Unico", tipoEspacio: "Habitacion", direccion: '', habitaciones: [], latitud: '', longitud: '', horaAbrir: '', horaCerrar: '',),
        Hoteles(nombre: "Unico", tipoEspacio: "Habitacion", direccion: '', habitaciones: [], latitud: '', longitud: '', horaAbrir: '', horaCerrar: '',),
        Hoteles(nombre: "Unico", tipoEspacio: "Habitacion", direccion: '', habitaciones: [], latitud: '', longitud: '', horaAbrir: '', horaCerrar: '',),
      ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: hoteles.isEmpty ?  FirstHotel():ListHotel(hotelList: hoteles,));
  }
}

class ListHotel extends StatelessWidget {
  final List<Hoteles> hotelList;
  const ListHotel({
    required this.hotelList,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,
    decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xff3B2151), Color(0xff08000F)],
                stops: [0.0, 0.9],
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter)),
    child:Stack(
      alignment: Alignment(0,0),
      children: [
        Align(alignment: Alignment(-.8,-.7),child: Text("Tus Anuncions",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),),
        Align(alignment: Alignment(.9, -.72),child: IconButton(onPressed: () {  }, icon:Icon(Icons.add_circle_outline_rounded,color: Colors.white,size: 30,) ,),),
        Align(alignment: Alignment(0, .5),child:SizedBox(
          width: MediaQuery.of(context).size.width*.85,
          height: MediaQuery.of(context).size.height*.74,
          child: ListView.builder(
            padding: EdgeInsets.only(top: 20,bottom:30),
            itemCount: hotelList.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 55),
                child:aditem(nombre: hotelList[index].nombre, tipoEspacio: hotelList[index].tipoEspacio),//ExpandableWidget()
              );
            },
          ),
        ),)
      ],
    )
    );
    
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
