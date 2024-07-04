import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telodigo/data/controllers/usercontroller.dart';
import 'package:telodigo/data/service/peticionesReporte.dart';
import 'package:telodigo/domain/models/calificacion.dart';
import 'package:telodigo/domain/models/habitaciones.dart';
import 'package:telodigo/domain/models/hoteles.dart';
import 'package:telodigo/domain/models/reserva.dart';

import '../../ui/components/customcomponents/customalert.dart';

class PeticionesReserva {
  static final CollectionReference collection =
      FirebaseFirestore.instance.collection("Reservas");

  static final CollectionReference collectionHotel =
      FirebaseFirestore.instance.collection("Negocios");

  static final UserController controlleruser = Get.find();

  static Future<bool> actualizarCantidadHabitacion({
    required String idHotel,
    required String nombreHabitacion,
    required String operacion,
  }) async {
    // Obtén el documento del hotel usando el idHotel

    QuerySnapshot querySnapshot2 = await FirebaseFirestore.instance
        .collection('Negocios')
        .where('id', isEqualTo: idHotel)
        .get();

    if (querySnapshot2.docs.isEmpty) {
      return false;
    }

    DocumentSnapshot document2 = querySnapshot2.docs.first;

    // Convierte el documento a un objeto Hoteles
    Hoteles hotel = Hoteles.desdeDoc(document2.data() as Map<String, dynamic>);

    print(hotel.estado);

    // Busca la habitación específica por su nombre
    bool habitacionActualizada = false;
    for (var habitacion in hotel.habitaciones) {
      if (habitacion.nombre == nombreHabitacion) {
        if (operacion == "resta") {
          habitacion.cantidad = habitacion.cantidad - 1;
        } else if (operacion == "suma") {
          habitacion.cantidad = habitacion.cantidad + 1;
        }
        habitacionActualizada = true;
        break;
      }
    }

    if (!habitacionActualizada) {
      return false;
    }

    // Guarda los cambios de vuelta en Firestore
    // await FirebaseFirestore.instance
    //     .collection('Negocios')
    //     .doc(document2.id)
    //     .update(hotel.toJson());

    await collectionHotel.doc(document2.id).update({
      "habitaciones":
          hotel.habitaciones.map((habitacion) => habitacion.toJson()).toList(),
    });

    return true;
  }

  static Future<String> RegistrarReserva(
      Reserva reserva, BuildContext context) async {
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
              Text("Reservando Habitación..."),
            ],
          ),
        );
      },
    );

    try {
      await actualizarCantidadHabitacion(
          idHotel: reserva.idHotel,
          nombreHabitacion: reserva.habitacion,
          operacion: "resta");

      var docRef = collection.doc();
      await docRef.set(reserva.toJson()).timeout(
        Duration(minutes: 20),
        onTimeout: () async {
          await docRef.delete().timeout(Duration(seconds: 0),
              onTimeout: () async {
            await actualizarCantidadHabitacion(
                idHotel: reserva.idHotel,
                nombreHabitacion: reserva.habitacion,
                operacion: "suma");

            throw TimeoutException(
                "La operación ha tardado demasiado en completarse");
          });
        },
      );
      Navigator.pop(context);
      return "create";
    } catch (e) {
      print('Error al enviar el mensaje: $e');
      await actualizarCantidadHabitacion(
          idHotel: reserva.idHotel,
          nombreHabitacion: reserva.habitacion,
          operacion: "suma");
      Navigator.pop(context);
      return "error";
    }
  }

  static Future<List<Reserva>> listReservas(BuildContext context) async {
    // await PeticionesReserva.actualizarCulminado(context, "user");
    final QuerySnapshot querySnapshot = await collection
        .where('idUser', isEqualTo: controlleruser.usuario!.userName)
        .get();

    List<Reserva> reservas = [];

    final List<DocumentSnapshot> documents = querySnapshot.docs;

    for (DocumentSnapshot data in documents) {
      if (data.data() != null) {
        Map<String, dynamic> jsonData = data.data()! as Map<String, dynamic>;
        Reserva reserva = Reserva.fromJson(jsonData);
        reservas.add(reserva);
      }
    }

    return reservas;
  }

  static Future<List<Reserva>> listReservasFiltro(
      String filtro, BuildContext context) async {
    // await PeticionesReserva.actualizarCulminado(context, "user");
    final QuerySnapshot querySnapshot = await collection
        .where('idUser', isEqualTo: controlleruser.usuario!.userName)
        .where('estado', isEqualTo: filtro)
        .get();

    List<Reserva> reservas = [];

    final List<DocumentSnapshot> documents = querySnapshot.docs;

    for (DocumentSnapshot data in documents) {
      if (data.data() != null) {
        Map<String, dynamic> jsonData = data.data()! as Map<String, dynamic>;
        Reserva reserva = Reserva.fromJson(jsonData);
        reservas.add(reserva);
      }
    }

    return reservas;
  }

  static Future<List<Reserva>> listReservasAnfitrion(
    BuildContext context,
  ) async {
    // await PeticionesReserva.actualizarCulminado(context, "anfitrion");

    final QuerySnapshot querySnapshot = await collection
        .where('idUserHotel', isEqualTo: controlleruser.usuario!.userName)
        .where('estado', isEqualTo: "En espera")
        .get();

    List<Reserva> reservas = [];

    final List<DocumentSnapshot> documents = querySnapshot.docs;

    for (DocumentSnapshot data in documents) {
      if (data.data() != null) {
        Map<String, dynamic> jsonData = data.data()! as Map<String, dynamic>;
        Reserva reserva = Reserva.fromJson(jsonData);
        reservas.add(reserva);
      }
    }

    return reservas;
  }

  static Future<void> VerificarCodigo(
      int id,
      String hotelid,
      String metodoPago,
      BuildContext context,
      String idUserHotel,
      double precio,
      Reserva reserva) async {
    try {
      QuerySnapshot querySnapshot =
          await collection.where('key', isEqualTo: id).get();

      DocumentSnapshot document = querySnapshot.docs.first;
      String documentoId = document.id;

      Map<String, dynamic> jsonData = document.data()! as Map<String, dynamic>;
      Reserva reserva = Reserva.fromJson(jsonData);

      int minuto = DateTime.now().minute;
      int horaFinal = DateTime.now().hour + reserva.tiempoReserva;
      DateTime fechaFinal = DateTime.now();

      if (metodoPago == "Tarjeta") {
        DateTime fechaCancelacion = DateTime(
            reserva.fechaMaximaLLegada.year,
            reserva.fechaMaximaLLegada.month,
            reserva.fechaMaximaLLegada.day,
            reserva.horaMaximaLlegada,
            reserva.minutoMaximoLlegada);

        DateTime fechaActual = DateTime.now();

        //ya paso la hora de cancelacion entonces la hora de la reserva queda tal cual esta

        if (fechaCancelacion.isBefore(fechaActual)) {
          horaFinal = reserva.horaFinalReserva;
          fechaFinal = fechaFinal;
        }
      }

      if (horaFinal >= 24) {
        horaFinal = horaFinal - 24;
        fechaFinal = fechaFinal.add(const Duration(days: 1));
      }

      await collection.doc(documentoId).update({
        'estado': "En la Habitacion",
        'horaInicioReserva': DateTime.now().hour,
        'horaFinalReserva': horaFinal,
        'minutoFinalReserva': minuto,
        'minutoInicioReserva': minuto,
        'fechaFinal': fechaFinal
      });

      if (metodoPago == "Efectivo" ||
          metodoPago == "Yape" ||
          metodoPago == "Plin") {
        await PeticionesReporte.reportePagoAdd(idUserHotel, precio);

        QuerySnapshot querySnapshot2 =
            await collectionHotel.where('id', isEqualTo: hotelid).get();

        DocumentSnapshot document2 = querySnapshot2.docs.first;
        String documentoId2 = document2.id;

        double comision = document["precio"] * 0.05;

        await collectionHotel.doc(documentoId2).update({
          'saldo': document2["saldo"] - comision,
        });
      }
    } catch (e) {
      print("Ocurrió un error: $e");
    }
  }

  static Future<bool> comprobarDisponibilidadReserva({
    required String idHotel,
    required String habitacion,
    required DateTime fecha,
    required int horaInicio,
    required int minutoInicio,
    required int tiempoHabitacion,
    required int numHabitaciones,
  }) async {
    final collection = FirebaseFirestore.instance.collection('Reservas');
    final QuerySnapshot querySnapshot = await collection
        // .where('estado', isEqualTo: "En espera")
        .where('estado', whereIn: ["En espera", "En la Habitacion"])
        .where('idHotel', isEqualTo: idHotel)
        .where('habitacion', isEqualTo: habitacion)
        .get();

    int contReservasCruzadas = 0;

    final List<DocumentSnapshot> documents = querySnapshot.docs;

    for (DocumentSnapshot data in documents) {
      if (data.data() != null) {
        Map<String, dynamic> jsonData = data.data()! as Map<String, dynamic>;
        Reserva reserva = Reserva.fromJson(jsonData);
        if (!await IsCulminado(reserva, data)) {
          DateTime startTime1 = DateTime(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day,
              reserva.horaInicioReserva,
              reserva.minutoInicioReserva); // 23 de mayo de 2023 a las 14:00

          // Definir el lapso de tiempo del primer lapso en horas y minutos
          int durationHours1 = reserva.tiempoReserva;
          int durationMinutes1 = 0;

          // Calcular la hora de fin del primer lapso de tiempo
          DateTime endTime1 = startTime1.add(Duration(
              hours: durationHours1,
              minutes: durationMinutes1)); // 23 de mayo de 2023 a las 16:00

          // Definir la hora de inicio del segundo lapso de tiempo
          DateTime startTime2 = DateTime(fecha.year, fecha.month, fecha.day,
              horaInicio, minutoInicio); // 23 de mayo de 2023 a las 15:30

          // Definir el lapso de tiempo del segundo lapso en horas y minutos
          int durationHours2 = tiempoHabitacion;
          int durationMinutes2 = 0;

          // Calcular la hora de fin del segundo lapso de tiempo
          DateTime endTime2 = startTime2.add(Duration(
              hours: durationHours2,
              minutes: durationMinutes2)); // 23 de mayo de 2023 a las 16:30

          // Comprobar si los dos lapsos de tiempo se solapan
          bool doTimeRangesOverlap =
              startTime1.isBefore(endTime2) && startTime2.isBefore(endTime1);

          // Imprimir el resultado
          if (doTimeRangesOverlap) {
            // print("Los dos lapsos de tiempo se solapan.");
            contReservasCruzadas = contReservasCruzadas + 1;
          }
        }
      }
    }

    // print(contReservasCruzadas);
    // print(numHabitaciones);

    if (contReservasCruzadas >= numHabitaciones) {
      return false;
    }

    return true;
  }

  static Future<int> comprobarDisponibilidadReserva2({
    required String idHotel,
    required String nombreHabitacion,
  }) async {
    QuerySnapshot querySnapshot2 = await FirebaseFirestore.instance
        .collection('Negocios')
        .where('id', isEqualTo: idHotel)
        .get();

    if (querySnapshot2.docs.isEmpty) {
      return 0;
    }

    DocumentSnapshot document2 = querySnapshot2.docs.first;

    // Convierte el documento a un objeto Hoteles
    Hoteles hotel = Hoteles.desdeDoc(document2.data() as Map<String, dynamic>);

    // Busca la habitación específica por su nombre
    Habitaciones? habitacionEspecifica;
    for (var habitacion in hotel.habitaciones) {
      if (habitacion.nombre == nombreHabitacion) {
        habitacionEspecifica = habitacion;
        break;
      }
    }

    // Si no se encuentra la habitación específica, retorna 0
    if (habitacionEspecifica == null) {
      return 0;
    }

    // Retorna la cantidad de la habitación específica
    return habitacionEspecifica.cantidad;
  }

  static Future<bool> IsCulminado(
      Reserva reserva, DocumentSnapshot data) async {
    DateTime targetDateTime = DateTime(
        reserva.fechaFinal.year,
        reserva.fechaFinal.month,
        reserva.fechaFinal.day,
        reserva.horaFinalReserva,
        reserva.minutoFinalReserva);

    // Fecha y hora actual
    DateTime now = DateTime.now();

    // Verificar si la fecha objetivo ya ha transcurrido
    if (targetDateTime.isBefore(now)) {
      data.reference.update({'estado': 'Culminado'});
      return true;
    }

    return false;
  }

  static Future<bool> IsCancel(
      Reserva reserva, DocumentSnapshot data, BuildContext context) async {
    if (reserva.estado == "En espera" && reserva.metodoPago != "Tarjeta") {
      DateTime targetDateTime = DateTime(
          reserva.fechaMaximaLLegada.year,
          reserva.fechaMaximaLLegada.month,
          reserva.fechaMaximaLLegada.day,
          reserva.horaMaximaLlegada,
          reserva.minutoMaximoLlegada);

      // Fecha y hora actual
      DateTime now = DateTime.now();

      // Verificar si la fecha objetivo ya ha transcurrido
      if (targetDateTime.isBefore(now)) {
        data.reference.update({'estado': 'Cancelada'});
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomAlert(
              title: "RESERVA CANCELADA",
              text:
                  "Su reserva en el telo ${reserva.nombreNegocio} ha sido cancelada por no llegar en el tiempo estipulado",
            );
          },
        );

        await PeticionesReserva.actualizarCantidadHabitacion(
            idHotel: reserva.idHotel,
            nombreHabitacion: reserva.habitacion,
            operacion: "suma");

        return true;
      }
    }

    return false;
  }

//esta es para cancelar las reservas que no se paguen con tajeta
  static Future<void> cancelarReservas(BuildContext context) async {
    final collection = FirebaseFirestore.instance.collection('Reservas');
    final QuerySnapshot querySnapshot = await collection
        .where('estado', isEqualTo: "En espera")
        .where('idUser', isEqualTo: controlleruser.usuario!.userName)
        .get();

    final List<DocumentSnapshot> documents = querySnapshot.docs;

    for (DocumentSnapshot data in documents) {
      if (data.data() != null) {
        Map<String, dynamic> jsonData = data.data()! as Map<String, dynamic>;
        Reserva reserva = Reserva.fromJson(jsonData);
        IsCancel(reserva, data, context);
      }
    }
  }

//esta es para cancelar las reservas que no se paguen con tajeta por el anfitrion
  static Future<void> cancelarReservasAnfitrion(BuildContext context) async {
    final collection = FirebaseFirestore.instance.collection('Reservas');
    final QuerySnapshot querySnapshot = await collection
        .where('estado', isEqualTo: "En espera")
        .where('idUserHotel', isEqualTo: controlleruser.usuario!.userName)
        .get();

    final List<DocumentSnapshot> documents = querySnapshot.docs;

    for (DocumentSnapshot data in documents) {
      if (data.data() != null) {
        Map<String, dynamic> jsonData = data.data()! as Map<String, dynamic>;
        Reserva reserva = Reserva.fromJson(jsonData);
        IsCancel(reserva, data, context);
      }
    }
  }

  //debo sacarla afuera a las vistas del usuario  Ok

  static Future<void> calificar(BuildContext context) async {
    final collection = FirebaseFirestore.instance.collection('Reservas');
    final QuerySnapshot querySnapshot = await collection
        .where('estado', isEqualTo: "Por Calificar")
        .where('idUser', isEqualTo: controlleruser.usuario!.userName)
        .get();

    final List<DocumentSnapshot> documents = querySnapshot.docs;

    for (DocumentSnapshot data in documents) {
      if (data.data() != null) {
        Map<String, dynamic> jsonData = data.data()! as Map<String, dynamic>;
        Reserva reserva = Reserva.fromJson(jsonData);

        data.reference.update({'estado': 'Culminado'});

        await mostrarAlertaCalificacion(context, reserva.idHotel,
            reserva.nombreNegocio, reserva.fotoPrincipal, reserva.idUserHotel);
      }
    }
  }

  //nuevo culminado
  static Future<void> culminado(
    BuildContext context,
  ) async {
    final collection = FirebaseFirestore.instance.collection('Reservas');
    final QuerySnapshot querySnapshot = await collection
        .where('estado', whereIn: ["En espera", "En la Habitacion"])
        .where('idUser', isEqualTo: controlleruser.usuario!.userName)
        .get();

    final List<DocumentSnapshot> documents = querySnapshot.docs;

    for (DocumentSnapshot data in documents) {
      if (data.data() != null) {
        Map<String, dynamic> jsonData = data.data()! as Map<String, dynamic>;
        Reserva reserva = Reserva.fromJson(jsonData);

        if (await IsCulminado(reserva, data)) {
          data.reference.update({'estado': 'Por Calificar'});
        }
      }
    }
  }

  //nuevo culminado por anfitrion
  static Future<void> culminadoAnfitrion(
    BuildContext context,
  ) async {
    final collection = FirebaseFirestore.instance.collection('Reservas');
    final QuerySnapshot querySnapshot = await collection
        .where('estado', whereIn: ["En espera", "En la Habitacion"])
        .where('idUserHotel', isEqualTo: controlleruser.usuario!.userName)
        .get();

    final List<DocumentSnapshot> documents = querySnapshot.docs;

    for (DocumentSnapshot data in documents) {
      if (data.data() != null) {
        Map<String, dynamic> jsonData = data.data()! as Map<String, dynamic>;
        Reserva reserva = Reserva.fromJson(jsonData);

        if (await IsCulminado(reserva, data)) {
          data.reference.update({'estado': 'Por Calificar'});
        }
      }
    }
  }

  // static Future<void> actualizarCulminado(
  //   BuildContext context,
  //   String typeUser,
  // ) async {
  //   final collection = FirebaseFirestore.instance.collection('Reservas');
  //   final QuerySnapshot querySnapshot = await collection
  //       .where('estado', whereIn: ["En espera", "En la Habitacion"]).get();

  //   final List<DocumentSnapshot> documents = querySnapshot.docs;

  //   for (DocumentSnapshot data in documents) {
  //     if (data.data() != null) {
  //       Map<String, dynamic> jsonData = data.data()! as Map<String, dynamic>;
  //       Reserva reserva = Reserva.fromJson(jsonData);
  //       await IsCancel(reserva, data, context);
  //       if (await IsCulminado(reserva, data)) {
  //         data.reference.update({'estado': 'Por Calificar'});
  //       }
  //     }
  //   }
  // }

  static Future<void> mostrarAlertaCalificacion(
      BuildContext context,
      String idNegocio,
      String nombre,
      String image,
      String idUserNegocio) async {
    double calificacion = 0.0;

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // El usuario debe calificar
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                  child: Text(
                "RESERVA CULMINADA",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              )),
              SizedBox(
                height: 10,
              ),
              ClipRRect(
                child: Image.network(
                  image,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              SizedBox(
                height: 10,
              ),
              Flexible(
                  child: Text(
                nombre,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
              )),
              SizedBox(
                height: 20,
              ),
              Text('Por favor, califique el negocio:'),
              CalificacionEstrellas(
                onRatingChanged: (rating) {
                  calificacion = rating;
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Calificar'),
              onPressed: () {
                guardarCalificacion(idNegocio, calificacion, idUserNegocio);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static Future<void> guardarCalificacion(
      String idNegocio, double calificacion, String idUserNegocio) async {
    final collection = FirebaseFirestore.instance.collection('Calificaciones');
    final calificacionNegocio = Calificacion(
        idNegocio: idNegocio,
        calificacion: calificacion,
        idUserNegocio: idUserNegocio);

    await collection.add(calificacionNegocio.toJson());
    double promedio = await calcularPromedioCalificaciones(idNegocio);

    final negocioQuerySnapshot =
        await collectionHotel.where('id', isEqualTo: idNegocio).get();

    if (negocioQuerySnapshot.docs.isNotEmpty) {
      final negocioDoc = negocioQuerySnapshot.docs.first;

      await negocioDoc.reference.update({
        'calificacion': promedio,
      });
    }
  }

  static Future<double> calcularPromedioCalificaciones(String idNegocio) async {
    final collection = FirebaseFirestore.instance.collection('Calificaciones');
    final querySnapshot =
        await collection.where('idNegocio', isEqualTo: idNegocio).get();

    if (querySnapshot.docs.isEmpty) {
      return 0.0;
    }

    double totalCalificaciones = 0;
    int cantidadCalificaciones = 0;

    querySnapshot.docs.forEach((doc) {
      totalCalificaciones += doc['calificacion'];
      cantidadCalificaciones++;
    });

    return totalCalificaciones / cantidadCalificaciones;
  }
}

class CalificacionEstrellas extends StatefulWidget {
  final Function(double) onRatingChanged;

  CalificacionEstrellas({required this.onRatingChanged});

  @override
  _CalificacionEstrellasState createState() => _CalificacionEstrellasState();
}

class _CalificacionEstrellasState extends State<CalificacionEstrellas> {
  double _rating = 0;

  Widget _buildStar(int index) {
    Icon icon;
    if (index >= _rating) {
      icon = Icon(
        Icons.star_border,
        color: Color.fromARGB(255, 53, 12, 128),
        size: 30,
      );
    } else if (index > _rating - 1 && index < _rating) {
      icon = Icon(
        Icons.star_half,
        color: Color.fromARGB(255, 53, 12, 128),
        size: 30,
      );
    } else {
      icon = Icon(
        Icons.star,
        color: Color.fromARGB(255, 53, 12, 128),
        size: 30,
      );
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          _rating = index + 1.0;
          widget.onRatingChanged(_rating);
        });
      },
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) => _buildStar(index)),
    );
  }
}
