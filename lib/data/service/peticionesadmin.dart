import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:telodigo/data/service/peticionesPagos.dart';
import 'package:telodigo/domain/models/habitaciones.dart';
import 'package:telodigo/domain/models/hoteles.dart';
import 'package:telodigo/domain/models/images.dart';
import 'package:telodigo/domain/models/informe.dart';
import 'package:telodigo/domain/models/solicitdPago.dart';
import 'package:telodigo/domain/models/usuario.dart';
import 'package:telodigo/ui/pages/administrador/homeAdmin.dart';

class PeticionesAdmin {
  static final CollectionReference collection =
      FirebaseFirestore.instance.collection("Negocios");

  static final CollectionReference collectionU =
      FirebaseFirestore.instance.collection("Usuarios");

  static Future<bool> ActualizarEstadoPago(String motivo, String estado,
      String id, String user, double monto) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      // Obtener los documentos de la colección "Pagos" con el id especificado
      QuerySnapshot querySnapshot =
          await firestore.collection('Pagos').where('id', isEqualTo: id).get();

      if (querySnapshot.docs.isEmpty) {
        return false;
      }

      var resp = querySnapshot.docs.first;

      await firestore.collection('Pagos').doc(resp.id).update({
        'estado': estado,
        'motivo': motivo,
      });

      if (estado == "Rechazado") {
        PeticionesPagos.generarPago(user, monto);
      }

      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> ActualizarEstadoNegocio(
    String estado,
    String id,
  ) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      // Obtener los documentos de la colección "Pagos" con el id especificado
      QuerySnapshot querySnapshot = await firestore
          .collection('Negocios')
          .where('id', isEqualTo: id)
          .get();

      if (querySnapshot.docs.isEmpty) {
        return false;
      }

      var resp = querySnapshot.docs.first;

      await firestore.collection('Negocios').doc(resp.id).update({
        'estado': estado,
      });

      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<List<Informe>> obtenerInformes() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    QuerySnapshot querySnapshot = await firestore
        .collection('InformeProblema')
        .orderBy('fecha', descending: true)
        .get();

    List<Informe> informes = querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return Informe.fromJson(data);
    }).toList();

    return informes;
  }

  static Future<List<SolicitudPago>> obtenerPagosEnEspera() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Obtener los documentos de la colección "Pagos" con el estado "En espera"
    QuerySnapshot querySnapshot = await firestore
        .collection('Pagos')
        .where('estado', isEqualTo: 'En espera')
        .get();

    // Mapear los documentos a objetos de la clase SolicitudPago
    List<SolicitudPago> pagos = querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return SolicitudPago.fromJson(data);
    }).toList();

    return pagos;
  }

  static Future<List<Usuario>> listUsuariosTodos(String filtroUserName) async {
    final QuerySnapshot querySnapshot = await collectionU.get();

    List<Usuario> usuarios = [];

    final List<DocumentSnapshot> documents = querySnapshot.docs;

    for (DocumentSnapshot data in documents) {
      final String userName = data["userName"];

      final String nombres = data["nombres"];

      final String password = data["password"];

      final String correo = data["correo"];

      final String apellidos = data["apellidos"];

      final String fechaNacimiento = data["fechaNacimiento"];

      final String foto = data["foto"];

      final double saldoCuenta = data["saldoCuenta"];

      Usuario user = Usuario(
          userName: userName,
          password: password,
          nombres: nombres,
          apellidos: apellidos,
          correo: correo,
          fechaNacimiento: fechaNacimiento,
          foto: foto,
          modoOscuro: false,
          saldoCuenta: saldoCuenta);

      if (user.userName != "Admin") {
        usuarios.add(user);
      }
    }

    List<Usuario> filteredusuarios = usuarios
        .where((usuario) => usuario.userName
            .toLowerCase()
            .contains(filtroUserName.toLowerCase()))
        .toList();

    return filteredusuarios;
  }

  static Future<List<Hoteles>> listNegociosTodos(String nombreNegocio) async {
    final QuerySnapshot querySnapshot =
        await collection.where('estado', isEqualTo: 'verificado').get();

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

      final List<String> categorias =
          (data["categorias"] as List).cast<String>();

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

      hoteles.add(hotel);
    }

    List<Hoteles> filteredHoteles = hoteles
        .where((hotel) =>
            hotel.nombre.toLowerCase().contains(nombreNegocio.toLowerCase()))
        .toList();

    return filteredHoteles;
  }

  static Future<List<Hoteles>> listPorVerificar() async {
    final QuerySnapshot querySnapshot =
        await collection.where('estado', isEqualTo: 'por verificar').get();

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

      final List<String> categorias =
          (data["categorias"] as List).cast<String>();

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

      hoteles.add(hotel);
    }

    return hoteles;
  }

  static Future<void> eliminarNegocio(String id, BuildContext context) async {
    if (!context.mounted)
      return; // Verificar si el contexto está montado antes de cerrar el diálogo inicial
    try {
      // Cerrar el diálogo inicial

      // Mostrar un diálogo de progreso mientras se elimina el negocio
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 30),
                Text("Eliminando Negocio..."),
              ],
            ),
          );
        },
      );

      QuerySnapshot querySnapshot =
          await collection.where('id', isEqualTo: id).get();

      if (querySnapshot.docs.isNotEmpty) {
        var docId = querySnapshot.docs.first.id;
        await collection.doc(docId).delete();
        if (context.mounted)
          Navigator.of(context).pop(); // Cerrar el diálogo de progreso

        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Negocio Eliminado"),
              content: const Text("El negocio se ha eliminado correctamente"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomeAdmin(
                                  currentIndex: 2,
                                )));
                  },
                  child: Text("Aceptar"),
                ),
              ],
            );
          },
        );
      } else {
        // Si no se encuentra ningún documento, cerrar el diálogo de progreso y mostrar un mensaje de error
        if (context.mounted) Navigator.of(context).pop();
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Error"),
              content: const Text(
                  "No se encontró ningún negocio con el ID especificado."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Cerrar el diálogo
                  },
                  child: Text("Aceptar"),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      // Cerrar el diálogo de progreso en caso de error
      if (context.mounted) Navigator.of(context).pop();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Error"),
            content: Text("Error al eliminar el negocio: $e"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Cerrar el diálogo
                },
                child: Text("Aceptar"),
              ),
            ],
          );
        },
      );
      print("Error al eliminar documentos: $e");
    }
  }

  static Future<void> eliminarUsuario(
      String userName, BuildContext context) async {
    if (!context.mounted)
      return; // Verificar si el contexto está montado antes de cerrar el diálogo inicial
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 30),
                Text("Eliminando Usuario..."),
              ],
            ),
          );
        },
      );

      QuerySnapshot querySnapshot =
          await collectionU.where('userName', isEqualTo: userName).get();

      if (querySnapshot.docs.isNotEmpty) {
        var docId = querySnapshot.docs.first.id;
        await collectionU.doc(docId).delete();
        if (context.mounted)
          Navigator.of(context).pop(); // Cerrar el diálogo de progreso

        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Usuario Eliminado"),
              content: const Text("El usuario se ha eliminado correctamente"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomeAdmin(
                                  currentIndex: 1,
                                )));
                  },
                  child: Text("Aceptar"),
                ),
              ],
            );
          },
        );
      } else {
        // Si no se encuentra ningún documento, cerrar el diálogo de progreso y mostrar un mensaje de error
        if (context.mounted) Navigator.of(context).pop();
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Error"),
              content: const Text(
                  "No se encontró ningún usuario con el username especificado."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Cerrar el diálogo
                  },
                  child: Text("Aceptar"),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      // Cerrar el diálogo de progreso en caso de error
      if (context.mounted) Navigator.of(context).pop();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Error"),
            content: Text("Error al eliminar el usuario: $e"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Cerrar el diálogo
                },
                child: Text("Aceptar"),
              ),
            ],
          );
        },
      );
    }
  }
}
