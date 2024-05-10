import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telodigo/data/controllers/negociocontroller.dart';
import 'package:telodigo/data/controllers/usercontroller.dart';
import 'package:telodigo/domain/models/favoritos.dart';
import 'package:telodigo/domain/models/habitaciones.dart';
import 'package:telodigo/domain/models/hoteles.dart';
import 'package:telodigo/domain/models/images.dart';
import 'package:telodigo/ui/components/customcomponents/customalert.dart';
import 'package:firebase_storage/firebase_storage.dart' as fs;
import 'package:telodigo/ui/pages/prueba/prueba.dart';

class PeticionesNegocio {
  static final CollectionReference collection =
      FirebaseFirestore.instance.collection("Negocios");
  static final fs.FirebaseStorage storage = fs.FirebaseStorage.instance;

  static final CollectionReference collectionFavorite =
      FirebaseFirestore.instance.collection("Favoritos");

  static final UserController controlleruser = Get.find();
  static final NegocioController controllernegocio = Get.find();

  static Future<List<Hoteles>> listNegocios() async {
    final QuerySnapshot querySnapshot = await collection
        .where('user', isEqualTo: controlleruser.usuario!.userName)
        .get();

    List<Hoteles> hoteles = [];

    final List<DocumentSnapshot> documents = querySnapshot.docs;

    for (DocumentSnapshot data in documents) {
      final String direccion = data["direccion"];

      final String horaAbrir = data["horaAbrir"];

      final String horaCerrar = data["horaCerrar"];

      final double latitud = data["latitud"];

      final double longitud = data["longitud"];

      final String nombre = data["nombre"];

      final double saldo = data["saldo"];

      final String tipoEspacio = data["tipoEspacio"];

      final List<String> servicios = (data["servicios"] as List).cast<String>();

      final List<String> metodosPago =
          (data["metodosPago"] as List).cast<String>();

      final List<dynamic> fotosJson = (data["fotos"] as List).cast<dynamic>();
      final List<Imagens> fotos =
          fotosJson.map((json) => Imagens.fromJson(json)).toList();

      final List<dynamic> habitacionesJson =
          (data["habitaciones"] as List).cast<dynamic>();
      final List<Habitaciones> habitaciones =
          habitacionesJson.map((json) => Habitaciones.fromMap(json)).toList();

      final double calificacion = data["calificacion"];

      final int id = data["id"];

      Hoteles hotel = Hoteles(
          id: id,
          saldo: saldo,
          user: controlleruser.usuario!.userName,
          fotos: fotos,
          servicios: servicios,
          metodosPago: metodosPago,
          direccion: direccion,
          nombre: nombre,
          tipoEspacio: tipoEspacio,
          habitaciones: habitaciones,
          latitud: latitud,
          longitud: longitud,
          horaAbrir: horaAbrir,
          horaCerrar: horaCerrar,
          calificacion: calificacion);

      // print(calificacion);
      hoteles.add(hotel);
    }

    controllernegocio.ListHotel(hoteles);
    return hoteles;
  }

  static Future<String> crearNegocio(Map<String, dynamic> hotel,
      BuildContext context, List<File> files) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: CircularProgressIndicator(),
                width: 30,
                height: 30,
              ),
              SizedBox(
                width: 30,
              ),
              Text("Creando Negocio..."),
            ],
          ),
        );
      },
    );

    try {
      var cant = 0;
      var url = "";
      Imagens img;
      for (var imagen in files) {
        url = await PeticionesMesa.cargarfoto(imagen, "User${hotel['user']}Id${hotel['id']}Nombre${hotel['nombre']}Cant${cant}");

        img = Imagens(image: url);

        controllernegocio.addImagen(img);

        cant = cant + 1;
      }

      hotel['fotos'] =
          controllernegocio.images?.map((foto) => foto.toJson()).toList();

      await collection.doc().set(hotel).timeout(
        Duration(seconds: 10),
        onTimeout: () async {
          Navigator.pop(context);
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const CustomAlert(
                title: "Error de Conexion",
                text: "La operación ha tardado demasiado en completarse",
              );
            },
          );

          throw TimeoutException(
              "La operación ha tardado demasiado en completarse");
        },
      );

      final int id = hotel["id"];

      final String direccion = hotel["direccion"];

      final String horaAbrir = hotel["horaAbrir"];

      final String horaCerrar = hotel["horaCerrar"];

      final double latitud = hotel["latitud"];

      final double longitud = hotel["longitud"];

      final double calificacion = hotel["calificacion"];

      final String nombre = hotel["nombre"];

      final double saldo = hotel["saldo"];

      final String tipoEspacio = hotel["tipoEspacio"];

      final List<String> servicios =
          (hotel["servicios"] as List).cast<String>();

      final List<String> metodosPago =
          (hotel["metodosPago"] as List).cast<String>();

      final List<dynamic> fotosJson = (hotel["fotos"] as List).cast<dynamic>();
      final List<Imagens> fotos =
          fotosJson.map((json) => Imagens.fromJson(json)).toList();

      final List<dynamic> habitacionesJson =
          (hotel["habitaciones"] as List).cast<dynamic>();
      final List<Habitaciones> habitaciones =
          habitacionesJson.map((json) => Habitaciones.fromMap(json)).toList();

      final String user = hotel["user"];


      Hoteles hotelcreado = Hoteles(
          id: id,
          saldo: saldo,
          user: user,
          fotos: fotos,
          servicios: servicios,
          metodosPago: metodosPago,
          direccion: direccion,
          nombre: nombre,
          tipoEspacio: tipoEspacio,
          habitaciones: habitaciones,
          latitud: latitud,
          longitud: longitud,
          horaAbrir: horaAbrir,
          horaCerrar: horaCerrar,
          calificacion: calificacion);

      controllernegocio.AddHotel(hotelcreado);

      return "create";
    } catch (error) {
      print("Error al agregar usuario: $error");
      return "error";
    }
  }

  static Future<List<Hoteles>> listNegociosClientes() async {
    final QuerySnapshot querySnapshot = await collection.limit(100).get();

    List<Hoteles> hoteles = [];

    final List<DocumentSnapshot> documents = querySnapshot.docs;

    for (DocumentSnapshot data in documents) {
      final String direccion = data["direccion"];

      final String horaAbrir = data["horaAbrir"];

      final String horaCerrar = data["horaCerrar"];

      final double latitud = data["latitud"];

      final double longitud = data["longitud"];

      final String nombre = data["nombre"];

      final double saldo = data["saldo"];

      final String tipoEspacio = data["tipoEspacio"];

      final List<String> servicios = (data["servicios"] as List).cast<String>();

      final List<String> metodosPago =
          (data["metodosPago"] as List).cast<String>();

      final List<dynamic> fotosJson = (data["fotos"] as List).cast<dynamic>();
      final List<Imagens> fotos =
          fotosJson.map((json) => Imagens.fromJson(json)).toList();

      final List<dynamic> habitacionesJson =
          (data["habitaciones"] as List).cast<dynamic>();
      final List<Habitaciones> habitaciones =
          habitacionesJson.map((json) => Habitaciones.fromMap(json)).toList();

      final double calificacion = data["calificacion"];

      final String user = data["user"];


      final int id = data["id"];

      if (saldo > 5.0) {
        Hoteles hotel = Hoteles(
            id: id,
            saldo: saldo,
            user: user,
            fotos: fotos,
            servicios: servicios,
            metodosPago: metodosPago,
            direccion: direccion,
            nombre: nombre,
            tipoEspacio: tipoEspacio,
            habitaciones: habitaciones,
            latitud: latitud,
            longitud: longitud,
            horaAbrir: horaAbrir,
            horaCerrar: horaCerrar,
            calificacion: calificacion);

        // print(calificacion);

        hoteles.add(hotel);
      }
    }

    // controllernegocio.ListHotel2(hoteles);
    return hoteles;
  }

 static Future<List<Hoteles>> listNegociosPrincipal(String request) async {
    final QuerySnapshot querySnapshot = await collection.where('tipoEspacio', isEqualTo: request).limit(10).get();

    List<Hoteles> hoteles = [];

    final List<DocumentSnapshot> documents = querySnapshot.docs;

    for (DocumentSnapshot data in documents) {
      final String direccion = data["direccion"];

      final String horaAbrir = data["horaAbrir"];

      final String horaCerrar = data["horaCerrar"];

      final double latitud = data["latitud"];

      final double longitud = data["longitud"];

      final String nombre = data["nombre"];

      final double saldo = data["saldo"];

      final String tipoEspacio = data["tipoEspacio"];

      final List<String> servicios = (data["servicios"] as List).cast<String>();

      final List<String> metodosPago =
          (data["metodosPago"] as List).cast<String>();

      final List<dynamic> fotosJson = (data["fotos"] as List).cast<dynamic>();
      final List<Imagens> fotos =
          fotosJson.map((json) => Imagens.fromJson(json)).toList();

      final List<dynamic> habitacionesJson =
          (data["habitaciones"] as List).cast<dynamic>();
      final List<Habitaciones> habitaciones =
          habitacionesJson.map((json) => Habitaciones.fromMap(json)).toList();

      final double calificacion = data["calificacion"];

      final String user = data["user"];

      final int id = data["id"];

      if (saldo > 5.0) {
        Hoteles hotel = Hoteles(
            id: id,
            saldo: saldo,
            user: user,
            fotos: fotos,
            servicios: servicios,
            metodosPago: metodosPago,
            direccion: direccion,
            nombre: nombre,
            tipoEspacio: tipoEspacio,
            habitaciones: habitaciones,
            latitud: latitud,
            longitud: longitud,
            horaAbrir: horaAbrir,
            horaCerrar: horaCerrar,
            calificacion: calificacion);

        // print(calificacion);

        hoteles.add(hotel);
      }
    }

    // controllernegocio.ListHotel2(hoteles);
    return hoteles;
  }


  static Future<List<Hoteles>> listMapHoteles() async {

    QuerySnapshot querySnapshot = await collection.limit(50).get();
    // final QuerySnapshot querySnapshot = await collection
    //     .get();

    List<Hoteles> reservas = [];

    final List<DocumentSnapshot> documents = querySnapshot.docs;

    print("Hota");

    for (DocumentSnapshot data in documents) {

      print("${data['nombre']}");
      if (data.data() != null) {

        Map<String, dynamic> jsonData = data.data()! as Map<String, dynamic>;
        Hoteles reserva = Hoteles.desdeDoc(jsonData);
        reservas.add(reserva);
      }
    }

    return reservas;
  }

  




  static Future<String> nuevoFavorito(
      Map<String, dynamic> favorito, BuildContext context) async {
    try {
      await collectionFavorite.doc().set(favorito).timeout(
        Duration(seconds: 15),
        onTimeout: () async {
          throw TimeoutException(
              "La operación ha tardado demasiado en completarse");
        },
      );

      final String nombre = favorito["nombre"];

      final int idHotel = favorito["idHotel"];

      final String idUser = favorito["idUser"];

      Favorito fav = Favorito(nombre: nombre, idHotel: idHotel, idUser: idUser);

      controllernegocio.AddFavorito(fav);

      return "create";
    } catch (error) {
      print("Error al agregar usuario: $error");
      return "error";
    }
  }

  static Future<void> EliminarFavorito(int idHotel, String nombre) async {
    collectionFavorite
        .where('idHotel', isEqualTo: idHotel)
        .where('idUser', isEqualTo: controlleruser.usuario!.userName)
        .where('nombre', isEqualTo: nombre)
        .get()
        .then((querySnapshot) {
      if (querySnapshot.size > 0) {
        final batch = FirebaseFirestore.instance.batch();

        querySnapshot.docs.forEach((doc) => batch.delete(doc.reference));

        batch.commit().then((_) => print('Favorite deleted'));

         
      } else {
        print('No favorite found to delete');
      }
    }).catchError((error) => print('Error getting favorites: $error'));
  }

  static Future<List<Hoteles>> listFavoritos() async {
    final QuerySnapshot querySnapshot = await collectionFavorite
        .where('idUser', isEqualTo: controlleruser.usuario!.userName)
        .get();

    List<Favorito> favoritos = [];

    final List<DocumentSnapshot> documents = querySnapshot.docs;

    for (DocumentSnapshot data in documents) {
      final String nombre = data["nombre"];

      final int idHotel = data["idHotel"];

      final String idUser = data["idUser"];

      Favorito fav = Favorito(nombre: nombre, idHotel: idHotel, idUser: idUser);

      favoritos.add(fav);
    }

    controllernegocio.ListFavoritos(favoritos);

    List<Hoteles> hoteles = [];
    for (var favorite in favoritos) {
      final QuerySnapshot querySnapshot = await collection
          .where('id', isEqualTo: favorite.idHotel)
          .limit(1)
          .get();

      final List<DocumentSnapshot> documents = querySnapshot.docs;

      for (DocumentSnapshot data in documents) {
        final String direccion = data["direccion"];

        final String horaAbrir = data["horaAbrir"];

        final String horaCerrar = data["horaCerrar"];

        final double latitud = data["latitud"];

        final double longitud = data["longitud"];

        final String nombre = data["nombre"];

        final double saldo = data["saldo"];

        final String tipoEspacio = data["tipoEspacio"];

        final List<String> servicios =
            (data["servicios"] as List).cast<String>();

        final List<String> metodosPago =
            (data["metodosPago"] as List).cast<String>();

        final List<dynamic> fotosJson = (data["fotos"] as List).cast<dynamic>();
        final List<Imagens> fotos =
            fotosJson.map((json) => Imagens.fromJson(json)).toList();

        final List<dynamic> habitacionesJson =
            (data["habitaciones"] as List).cast<dynamic>();
        final List<Habitaciones> habitaciones =
            habitacionesJson.map((json) => Habitaciones.fromMap(json)).toList();

        final double calificacion = data["calificacion"];

        final int id = data["id"];

        if (saldo > 5.0) {
          Hoteles hotel = Hoteles(
              id: id,
              saldo: saldo,
              user: controlleruser.usuario!.userName,
              fotos: fotos,
              servicios: servicios,
              metodosPago: metodosPago,
              direccion: direccion,
              nombre: nombre,
              tipoEspacio: tipoEspacio,
              habitaciones: habitaciones,
              latitud: latitud,
              longitud: longitud,
              horaAbrir: horaAbrir,
              horaCerrar: horaCerrar,
              calificacion: calificacion);

          // print(calificacion);

          hoteles.add(hotel);
        }
      }
    }

    controllernegocio.HotelesFavorito(hoteles);

    return hoteles;
  }
}
