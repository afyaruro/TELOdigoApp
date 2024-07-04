import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telodigo/data/controllers/negociocontroller.dart';
import 'package:telodigo/data/controllers/usercontroller.dart';
import 'package:telodigo/data/service/PeticionesReservas.dart';
import 'package:telodigo/domain/models/favoritos.dart';
import 'package:telodigo/domain/models/habitaciones.dart';
import 'package:telodigo/domain/models/hoteles.dart';
import 'package:telodigo/domain/models/images.dart';
import 'package:telodigo/ui/components/customcomponents/customalert.dart';
import 'package:firebase_storage/firebase_storage.dart' as fs;
import 'package:telodigo/data/service/peticionesImagenes.dart';

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

      final int horaAbrir = data["horaAbrir"];

      final int horaCerrar = data["horaCerrar"];

      final int minutoAbrir = data["minutoAbrir"];

      final int minutoCerrar = data["minutoCerrar"];

      final String tipoHorario = data["tipoHorario"];

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

      final String id = data["id"];

      final List<String> categorias =
          (data["categorias"] as List).cast<String>();

      final String estado = data["estado"] ?? "";

      Hoteles hotel = Hoteles(
          minutoAbrir: minutoAbrir,
          minutoCerrar: minutoCerrar,
          tipoHorario: tipoHorario,
          estado: estado,
          categorias: categorias,
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

  static Future<List<Hoteles>> listRecargas() async {
    final QuerySnapshot querySnapshot = await collection
        .where('user', isEqualTo: controlleruser.usuario!.userName)
        .where('estado', isEqualTo: "verificado")
        .get();

    List<Hoteles> hoteles = [];

    final List<DocumentSnapshot> documents = querySnapshot.docs;

    for (DocumentSnapshot data in documents) {
      final String direccion = data["direccion"];

      final int horaAbrir = data["horaAbrir"];

      final int horaCerrar = data["horaCerrar"];

      final int minutoAbrir = data["minutoAbrir"];

      final int minutoCerrar = data["minutoCerrar"];

      final String tipoHorario = data["tipoHorario"];

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

      final String id = data["id"];

      final List<String> categorias =
          (data["categorias"] as List).cast<String>();

      final String estado = data["estado"] ?? "";

      Hoteles hotel = Hoteles(
          minutoAbrir: minutoAbrir,
          minutoCerrar: minutoCerrar,
          tipoHorario: tipoHorario,
          estado: estado,
          categorias: categorias,
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
        url = await PeticionesImagenes.cargarfoto(imagen,
            "User${hotel['user']}Id${hotel['id']}Nombre${hotel['nombre']}Cant${cant}");

        img = Imagens(image: url);

        controllernegocio.addImagen(img);

        cant = cant + 1;
      }

      hotel['fotos'] =
          controllernegocio.images?.map((foto) => foto.toJson()).toList();

      await collection.doc().set(hotel).timeout(
        Duration(minutes: 5),
        onTimeout: () async {
          Navigator.pop(context);
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return CustomAlert(
                title: "Error de Conexion",
                text: "La operación ha tardado demasiado en completarse",
              );
            },
          );

          throw TimeoutException(
              "La operación ha tardado demasiado en completarse");
        },
      );

      final String id = hotel["id"];

      final String direccion = hotel["direccion"];

      final int horaAbrir = hotel["horaAbrir"];

      final int horaCerrar = hotel["horaCerrar"];

      final int minutoAbrir = hotel["minutoAbrir"];

      final int minutoCerrar = hotel["minutoCerrar"];

      final String tipoHorario = hotel["tipoHorario"];

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

      final List<String> categorias =
          (hotel["categorias"] as List).cast<String>();

      final String estado = hotel["estado"] ?? "";

      Hoteles hotelcreado = Hoteles(
          minutoAbrir: minutoAbrir,
          minutoCerrar: minutoCerrar,
          tipoHorario: tipoHorario,
          estado: estado,
          categorias: categorias,
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

      // controllernegocio.AddHotel(hotelcreado);
      PeticionesReserva.guardarCalificacion(
          hotelcreado.id, 3, hotelcreado.user);

      return "create";
    } catch (error) {
      print("Error al agregar usuario: $error");
      return "error";
    }
  }

  static Future<List<Hoteles>> listNegociosClientes(
      String nombreNegocio) async {
    // final QuerySnapshot querySnapshot = await collection.get();
    // hoteles = querySnapshot.data ?? [];
    // List<Hoteles> filteredHoteles = reservas
    //     .where((reserva) =>
    //         reserva.idUser.toLowerCase().contains(_searchText.toLowerCase()))
    //     .toList();

    final QuerySnapshot querySnapshot =
        await collection.where('estado', isEqualTo: "verificado").get();

    List<Hoteles> hoteles = [];

    final List<DocumentSnapshot> documents = querySnapshot.docs;

    for (DocumentSnapshot data in documents) {
      final String direccion = data["direccion"];

      final int horaAbrir = data["horaAbrir"];

      final int horaCerrar = data["horaCerrar"];

      final int minutoAbrir = data["minutoAbrir"];

      final int minutoCerrar = data["minutoCerrar"];

      final String tipoHorario = data["tipoHorario"];

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

      final String id = data["id"];

      final List<String> categorias =
          (data["categorias"] as List).cast<String>();

      final String estado = data["estado"] ?? "";

      if (saldo > 5.0) {
        Hoteles hotel = Hoteles(
            minutoAbrir: minutoAbrir,
            minutoCerrar: minutoCerrar,
            tipoHorario: tipoHorario,
            estado: estado,
            categorias: categorias,
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

    List<Hoteles> filteredHoteles = hoteles
        .where((hotel) =>
            hotel.nombre.toLowerCase().contains(nombreNegocio.toLowerCase()))
        .toList();

    // controllernegocio.ListHotel2(hoteles);
    // return hoteles;
    return filteredHoteles;
  }

  static Future<List<Hoteles>> listNegociosPrincipal(
      String request, String filtro) async {
    final QuerySnapshot querySnapshot = await collection
        .where('categorias', arrayContains: request)
        .where('estado', isEqualTo: "verificado")
        .get();

    List<Hoteles> hoteles = [];

    final List<DocumentSnapshot> documents = querySnapshot.docs;

    for (DocumentSnapshot data in documents) {
      final String direccion = data["direccion"];

      final int horaAbrir = data["horaAbrir"];

      final int horaCerrar = data["horaCerrar"];

      final int minutoAbrir = data["minutoAbrir"];

      final int minutoCerrar = data["minutoCerrar"];

      final String tipoHorario = data["tipoHorario"];

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

      final String id = data["id"];

      final List<String> categorias =
          (data["categorias"] as List).cast<String>();
      final String estado = data["estado"] ?? "";

      if (saldo > 5.0) {
        Hoteles hotel = Hoteles(
            minutoAbrir: minutoAbrir,
            minutoCerrar: minutoCerrar,
            tipoHorario: tipoHorario,
            estado: estado,
            categorias: categorias,
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

    List<Hoteles> filteredHoteles = hoteles
        .where((hotel) =>
            hotel.nombre.toLowerCase().contains(filtro.toLowerCase()))
        .toList();

    // controllernegocio.ListHotel2(hoteles);
    // return hoteles;
    return filteredHoteles;

    // return hoteles;
  }

  static Future<Hoteles?> FirstNegocioCategory(String categoria) async {
    final QuerySnapshot querySnapshot = await collection
        .where('categorias', arrayContains: categoria)
        // .where('saldo', isGreaterThan: 5.0)
        .limit(1)
        .get();

    if (querySnapshot.docs.isEmpty) {
      return null;
    }

    final DocumentSnapshot data = querySnapshot.docs.first;

    final String direccion = data["direccion"];
    final int horaAbrir = data["horaAbrir"];

    final int horaCerrar = data["horaCerrar"];

    final int minutoAbrir = data["minutoAbrir"];

    final int minutoCerrar = data["minutoCerrar"];

    final String tipoHorario = data["tipoHorario"];
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
    final String id = data["id"];
    final List<String> categorias = (data["categorias"] as List).cast<String>();
    final String estado = data["estado"] ?? "";

    Hoteles hotel = Hoteles(
        minutoAbrir: minutoAbrir,
        minutoCerrar: minutoCerrar,
        tipoHorario: tipoHorario,
        estado: estado,
        categorias: categorias,
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

    return hotel;
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
      String idUnico = '${favorito["idHotel"]}_${favorito["idUser"]}';

      await collectionFavorite.doc(idUnico).set(favorito);

      return "create";
    } catch (error) {
      print("Error al agregar el favorito: $error");
      return "error";
    }
  }

  static Future<void> EliminarFavorito(String idHotel, String nombre) async {
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

      final String idHotel = data["idHotel"];

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

        final int horaAbrir = data["horaAbrir"];

        final int horaCerrar = data["horaCerrar"];

        final int minutoAbrir = data["minutoAbrir"];

        final int minutoCerrar = data["minutoCerrar"];

        final String tipoHorario = data["tipoHorario"];

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

        final String id = data["id"];

        final String user = data["user"];

        final String estado = data["estado"] ?? "";

        final List<String> categorias =
            (data["categorias"] as List).cast<String>();

        if (saldo > 5.0) {
          Hoteles hotel = Hoteles(
              minutoAbrir: minutoAbrir,
              minutoCerrar: minutoCerrar,
              tipoHorario: tipoHorario,
              estado: estado,
              categorias: categorias,
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
    }

    controllernegocio.HotelesFavorito(hoteles);

    return hoteles;
  }

  static Future<bool> isFavorito(String idHotel) async {
    final QuerySnapshot querySnapshot = await collectionFavorite
        .where('idUser', isEqualTo: controlleruser.usuario!.userName)
        .where('idHotel', isEqualTo: idHotel)
        .limit(1)
        .get();

    // Verificar si hay documentos en la respuesta
    if (querySnapshot.docs.isNotEmpty) {
      return true; // El hotel es favorito
    }

    return false; // El hotel no es favorito
  }

  static Future<void> eliminarFavorito(String idHotel) async {
    final QuerySnapshot querySnapshot = await collectionFavorite
        .where('idUser', isEqualTo: controlleruser.usuario!.userName)
        .where('idHotel', isEqualTo: idHotel)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      final String docId = querySnapshot.docs.first.id;

      await collectionFavorite.doc(docId).delete();
    }
  }
}
